import 'package:ar_visiting_app/app/data/models/address_type/address_type_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/area/areamodel.dart';
import '../../../data/models/patient/patient_model.dart';
import '../../../data/models/visits/visitmodel.dart';
import '../../../data/repository/dio_helper_repository.dart';
import '../../../domain/usecase/base_use_case.dart';
import '../../../domain/usecase/base_use_case_interface.dart';
import '../../../routes/app_pages.dart';
import '../../visit_details/di/operation_type.dart';

class AddEditVisitController extends GetxController {
  AddEditVisitController(this.useCase);
  var isLoading = false.obs;
  var id =''.obs;
  final formKey = GlobalKey<FormState>();
  var newVisit = VisitModel().obs;
  var visit =VisitModel().obs;
  var visitId = RxInt(-1);
  var titles =<String>['newVisitTitle'.tr,'editVisitTitle'.tr,'cloneVisitTitle'.tr].obs;
  var buttonText =<String>['add'.tr,'edit'.tr,'clone'.tr].obs;
  var currentScreen= RxInt(0);
  var internalLoading= RxBool(false);
  var patient = <PatientModel>[].obs;
  var patientAr = <PatientModel>[].obs;
  var addressType = <AddressTypeModel>[].obs;
  var addressTypeAr = <AddressTypeModel>[].obs;
  var areas = <AreaModel>[].obs;
  var selectedPatient = PatientModel().obs;
  var selectedArea = AreaModel().obs;
  var selectedAddressType = AddressTypeModel().obs;
  final BaseUseCaseInterface useCase;
  final key = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController();
  TextEditingController fromTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();
  TextEditingController numberOfPeopleController = TextEditingController();
  TextEditingController patientAddressController = TextEditingController();
  TextEditingController assistantNameController = TextEditingController();
  TextEditingController assistantPhoneController = TextEditingController();
  TextEditingController patientFamIDController = TextEditingController();
  TextEditingController patientIDNumberController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController googleLinkController = TextEditingController();
  TextEditingController patientNameController = TextEditingController();
  TextEditingController zoneController = TextEditingController();

  String changeFormatDB(String date) {
    var newDate = '';
    try {
      newDate =
      '${date.substring(6, 10)}-${date.substring(3, 5)}-${date.substring(0, 2)}';
    } catch (e) {
      Get.snackbar('Error', 'Invalid date format');
    }
    return newDate;
  }

  String changeFormatView(String date) {
    var newDate = '';
    try {
      newDate =
      '${date.substring(0, 2)}-${date.substring(3, 5)}-${date.substring(6, 10)}';
    } catch (e) {
      Get.snackbar('Error', 'Invalid date format');
    }
    return newDate;
  }

  void getAddressType(){
      addressType.add(AddressTypeModel(addressTypeTd: 1,addressTypeValue: 'Home'));
      addressType.add(AddressTypeModel(addressTypeTd: 2,addressTypeValue: 'Hospital'));
      addressType.add(AddressTypeModel(addressTypeTd: 3,addressTypeValue: 'Dar'));
      addressType.add(AddressTypeModel(addressTypeTd: 4,addressTypeValue: 'others'));
      addressTypeAr.add(AddressTypeModel(addressTypeTd: 1,addressTypeValue: 'منزل'));
      addressTypeAr.add(AddressTypeModel(addressTypeTd: 2,addressTypeValue: 'مستشفى'));
      addressTypeAr.add(AddressTypeModel(addressTypeTd: 3,addressTypeValue: 'دار'));
      addressTypeAr.add(AddressTypeModel(addressTypeTd: 4,addressTypeValue: 'اخري'));
  }
  Future<void> selectDate(BuildContext context) async {
    DateTime? datePicked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color.fromARGB(
                      255, 239, 84, 0),
                  onPrimary: Colors.white,
                  onSurface: Colors.black,
                ),
              ),
              child: child!);
        });
    dateController.text = "${datePicked!.day.toString().padLeft(2, '0')}-${datePicked.month.toString().padLeft(2, '0')}-${datePicked.year}";
  }

  Future<void> selectedFromTime(BuildContext context) async {
    TimeOfDay? fromTimePicked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color.fromARGB(
                      255, 239, 84, 0), //header and selced day background color
                  onPrimary: Colors.white, // titles and
                  onSurface: Colors.black, // Month days , years
                ),
              ),
              child: child!);
        });
    if (fromTimePicked != null && Get.isRegistered<AddEditVisitController>() && Get.context != null) {
      fromTimeController.text = fromTimePicked.format(Get.context!).toString();
    }
  }

  Future<void> selectedToTime() async {
    if (!Get.isRegistered<AddEditVisitController>() || Get.context == null) return;
    TimeOfDay? toTimePicked = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color.fromARGB(
                      255, 239, 84, 0), //header and selected day background color
                  onPrimary: Colors.white, // titles and
                  onSurface: Colors.black, // Month days, years
                ),
              ),
              child: child!);
        });
    if (toTimePicked != null) {
      toTimeController.text = toTimePicked.format(Get.context!).toString();
    }
  }
  Future<void> getData() async {
      var patientData = await useCase.getUserData()??[];
      for (var element in patientData) {
        patientAr.add(PatientModel(id: element.id,name: element.name?.nameAr??''));
        patient.add(PatientModel(id: element.id,name: element.name?.name??''));
      }
      areas(await useCase.getAreaData() ?? []);
  }

  void clone()async{
    addVisit();
  }

  void editVisit() async{
    if(!onValidate())return;
    try{
      internalLoading(true);
      newVisit.value = VisitModel(
        date: useCase.changeFormatDB(dateController.text),
        from: fromTimeController.text,
        to: toTimeController.text,
        patientNums: int.parse(numberOfPeopleController.text),
        address: patientAddressController.text,
        attendant: assistantNameController.text,
        attendantPhone: assistantPhoneController.text,
        note: noteController.text,
        addressUrl: googleLinkController.text,
        areaId: selectedArea.value.id,
        addressTypeId: selectedAddressType.value.addressTypeTd,
        id: visit.value.id,
      );
      visit(await useCase.editVisit(newVisit.value));
      Get.offNamedUntil(
          Routes.VISIT_DETAILS,arguments: visit.value, (route) => route.settings.name == Routes.HOME);
    }catch (e){
      Get.snackbar("Error", e.toString());
    }finally{
      internalLoading(false);
    }
  }


  void displayData() {
    if(currentScreen.value != 2)dateController = TextEditingController(text: visit.value.date);
    fromTimeController = TextEditingController(text: visit.value.from);
    toTimeController = TextEditingController(text: visit.value.to);
    numberOfPeopleController =TextEditingController(text: visit.value.patientNums.toString());
    patientAddressController = TextEditingController(text: visit.value.address);
    assistantNameController = TextEditingController(text: visit.value.attendant);
    assistantPhoneController =TextEditingController(text: visit.value.attendantPhone);
    noteController = TextEditingController(text: visit.value.note);
    googleLinkController = TextEditingController(text: visit.value.addressUrl);
    selectedArea.value= AreaModel(id: visit.value.area?.id,name: visit.value.area?.name??'');
    selectedAddressType.value=AddressTypeModel(addressTypeTd: visit.value.addressType?.value,addressTypeValue: visit.value.addressType?.name??'');
    selectedPatient.value =PatientModel(name: visit.value.userName??'',id: visit.value.userId);
  }

  void onSelectPatient(PatientModel patient){
    selectedPatient.value = patient;
  }

  void onSelectArea(AreaModel area){
    selectedArea.value = area;
  }

  void onSelectAddressType(AddressTypeModel addressType){
    selectedAddressType.value = addressType;
  }

  bool onValidate(){
    if(selectedPatient.value.id == null){
      Get.snackbar('Error', 'Please select a patient');
      return false;
    }if(selectedArea.value.id == null){
      Get.snackbar('Error', 'Please select an area');
      return false;
    }if(selectedAddressType.value.addressTypeTd == null){
      Get.snackbar('Error', 'Please select an address type');
      return false;
    }else{
      return true;
    }
  }
  void addVisit() async{
    if(!onValidate())return;
    try{
      internalLoading(true);
      newVisit.value = VisitModel(
        date: changeFormatDB(dateController.text),
        from: fromTimeController.text,
        to: toTimeController.text,
        patientNums: int.parse(numberOfPeopleController.text),
        address: patientAddressController.text,
        attendant: assistantNameController.text,
        attendantPhone: assistantPhoneController.text,
        note: noteController.text,
        addressUrl: googleLinkController.text,
        areaId: selectedArea.value.id,
        addressTypeId: selectedAddressType.value.addressTypeTd,
        userId: selectedPatient.value.id,
      );
      visit(await useCase.addVisit(newVisit.value));
      Get.offNamedUntil(
          Routes.VISIT_DETAILS,
              arguments: visit.value,
              (route) => route.settings.name == Routes.HOME
      );
    }catch (e){
      Get.snackbar("Error", e.toString());
    }finally{
      internalLoading(false);
    }
  }
  @override
  void onInit() async {
    isLoading(true);
    var operationType =Get.arguments[0];
    if(operationType == OperationType.ADD){
      currentScreen.value =0;
      getAddressType();
      await getData();
    }else if(operationType ==OperationType.EDIT){
      currentScreen.value =1;
      getAddressType();
      await getData();
      visit.value =Get.arguments[1];
      displayData();
    }else if(operationType == OperationType.CLONE){
      currentScreen.value =2;
      getAddressType();
      await getData();
      visit.value =Get.arguments[1];
      displayData();
    }
    isLoading(false);
    super.onInit();
  }

}
