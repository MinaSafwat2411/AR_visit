import 'package:ar_visiting_app/app/data/models/address_type/address_type_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/area/areamodel.dart';
import '../../../data/models/login/loginmodel.dart';
import '../../../data/models/patient/patient_model.dart';
import '../../../data/models/visits/visitmodel.dart';
import '../../../data/repository/dio_helper_repository.dart';
import '../../../domain/usecase/base_use_case.dart';
import '../../../routes/app_pages.dart';
import '../../visit_details/di/operation_type.dart';

class AddEditVisitController extends GetxController {
  var isLoading = false.obs;
  var id =''.obs;
  var lang=''.obs;
  final formKey = GlobalKey<FormState>();
  var token = ''.obs;
  var newVisit = VisitModel().obs;
  var visit =VisitModel().obs;
  var isDark = RxBool(false);
  var visitId = RxInt(-1);
  var titles =<String>['newVisitTitle'.tr,'editVisitTitle'.tr,'cloneVisitTitle'.tr].obs;
  var buttonText =<String>['add'.tr,'edit'.tr,'clone'.tr].obs;
  var currentScreen= RxInt(0);
  var internalLoading= RxBool(false);
  var patient = <PatientModel>[].obs;
  var addressType = <AddressTypeModel>[].obs;
  var areas = <AreaModel>[].obs;
  var selectedPatient = PatientModel().obs;
  var selectedArea = AreaModel().obs;
  var selectedAddressType = AddressTypeModel().obs;
  final BaseUseCase useCase = BaseUseCase(repository: DioHelperRepository.repository);

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


  void getAddressType(){
    if(lang.value=='en'){
      addressType.add(AddressTypeModel(addressTypeTd: 1,addressTypeValue: 'Home'));
      addressType.add(AddressTypeModel(addressTypeTd: 2,addressTypeValue: 'Hospital'));
      addressType.add(AddressTypeModel(addressTypeTd: 3,addressTypeValue: 'Dar'));
      addressType.add(AddressTypeModel(addressTypeTd: 4,addressTypeValue: 'others'));
    }else{
      addressType.add(AddressTypeModel(addressTypeTd: 1,addressTypeValue: 'منزل'));
      addressType.add(AddressTypeModel(addressTypeTd: 2,addressTypeValue: 'مستشفى'));
      addressType.add(AddressTypeModel(addressTypeTd: 3,addressTypeValue: 'دار'));
      addressType.add(AddressTypeModel(addressTypeTd: 4,addressTypeValue: 'دار'));
    }
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
      var patientData = await useCase.getUserData(lang.value, token.value)??[];
      for (var element in patientData) {
        patient.add(PatientModel(id: element.id,name: lang.value=='en'? element.name?.name??'' : element.name?.nameAr??''));
      }
      areas(await useCase.getAreaData(lang.value, token.value) ?? []);
  }

  void clone()async{
    addVisit();
  }

  void editVisit() async{
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
      visit(await useCase.editVisit(lang.value,token.value,newVisit.value));
      Get.offNamedUntil(
          Routes.VISIT_DETAILS,arguments: [lang.value,isDark.value,token.value,visit.value], (route) => route.settings.name == Routes.HOME);
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
    patientFamIDController=TextEditingController(text: visit.value.e1C1F.toString());
    patientIDNumberController=TextEditingController(text: visit.value.nR.toString());
    selectedArea.value=AreaModel(id: visit.value.area?.id,name: visit.value.area?.name??'');
    selectedAddressType.value=AddressTypeModel(addressTypeTd: visit.value.addressType?.value,addressTypeValue: visit.value.addressType?.name??'');
    selectedPatient.value =PatientModel(name: visit.value.userName??'',id: visit.value.userId);
  }

  void onSelectPatient(PatientModel patient){
    selectedPatient.value = patient;
    Get.back(closeOverlays: true);
  }

  void onSelectArea(AreaModel area){
    selectedArea.value = area;
    Get.back(closeOverlays: true);
  }

  void onSelectAddressType(AddressTypeModel addressType){
    selectedAddressType.value = addressType;
    Get.back(closeOverlays: true);
  }

  void addVisit() async{
    internalLoading(true);
    try{
      newVisit.value = VisitModel(
        date: dateController.text,
        from: fromTimeController.text,
        to: toTimeController.text,
        patientNums: int.parse(numberOfPeopleController.text),
        address: patientAddressController.text,
        attendant: assistantNameController.text,
        attendantPhone: assistantPhoneController.text,
        e1C1F: int.parse(patientFamIDController.text),
        nR: int.parse(patientIDNumberController.text),
        note: noteController.text,
        addressUrl: googleLinkController.text,
        areaId: selectedArea.value.id,
        addressTypeId: selectedAddressType.value.addressTypeTd,
        userId: selectedPatient.value.id,
      );
      visit(await useCase.addVisit(lang.value,token.value,newVisit.value));
      Get.snackbar("Visits", "Visit add successfully");
      Get.offNamedUntil(
          Routes.VISIT_DETAILS,
              arguments: [lang.value,isDark.value,token.value,visit.value],
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
    token.value =Get.arguments[2];
    isDark.value =Get.arguments[1];
    lang.value =Get.arguments[0];
    var operationType =Get.arguments[3];
    if(operationType == OperationType.ADD){
      currentScreen.value =0;
      getAddressType();
      await getData();
    }else if(operationType ==OperationType.EDIT){
      currentScreen.value =1;
      getAddressType();
      await getData();
      visit.value =Get.arguments[4];
      displayData();
    }else if(operationType == OperationType.CLONE){
      currentScreen.value =2;
      getAddressType();
      await getData();
      visit.value =Get.arguments[4];
      displayData();
    }
    isLoading(false);
    super.onInit();
  }

}
