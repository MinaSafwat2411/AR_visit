import 'package:ar_visiting_app/app/core/controller/main_controller.dart';
import 'package:ar_visiting_app/app/core/models/area/areamodel.dart';
import 'package:ar_visiting_app/app/core/models/login/loginmodel.dart';
import 'package:ar_visiting_app/app/core/models/visits/visitmodel.dart';
import 'package:ar_visiting_app/app/core/services/secure_cache_helper.dart';
import 'package:ar_visiting_app/app/modules/visit_details/di/operation_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/cache_helper.dart';
import '../../../routes/app_pages.dart';

class AddEditVisitController extends GetxController {
  var addressType = ''.obs;
  var userType = ''.obs;
  var areaName = ''.obs;
  var areaNames = <String>[].obs;
  var areaId = <int>[].obs;
  var userNames = <String>[].obs;
  var userId = <int>[].obs;
  var areaData =<AreaModel>[].obs;
  var userData =<User>[].obs;
  var isLoading = false.obs;
  var id =''.obs;
  var lang=''.obs;
  final formKey = GlobalKey<FormState>();
  var addressTypeList=<String>[].obs;
  var token = ''.obs;
  var newVisit = VisitModel().obs;
  var mainController = MainController();
  var visit =VisitModel(
    areaName: null,
    addressType: null
  ).obs;
  var isDark = RxBool(false);
  var visitId = RxInt(-1);
  var titles =<String>['newVisitTitle'.tr,'editVisitTitle'.tr,'cloneVisitTitle'.tr].obs;
  var buttonText =<String>['add'.tr,'edit'.tr,'clone'.tr].obs;
  var currentScreen= RxInt(0);
  var internalLoading= RxBool(false);

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



  Future<void> getVisitDetails() async {
    isLoading.value = true;
    try {

    } catch (e) {
      Get.snackbar("Error", "Failed to retrieve visit details: $e");
    } finally {
      isLoading.value = false;
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
  void getAddressType(){
    if(lang.value=='en'){
      addressTypeList.value=['Home','Hospital', 'Dar','others'];
    }else{
      addressTypeList.value=['منزل','مستشفى', 'دار','اخري'];
    }
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
      var userData = await mainController.getUserData(lang.value, token.value);
      var areaData = await mainController.getAreaData(lang.value, token.value);
      for (var element in areaData) {
        areaNames.add(element.name!);
        areaId.add(element.id!);
      }
      for (var element in userData) {
        userNames.add(element.name!);
        userId.add(element.id!);
      }
  }

  void clone()async{
    addVisit();
  }

  void editVisit() async{
    internalLoading(true);
    try{
      newVisit.value = VisitModel(
        date: mainController.changeFormatDB(dateController.text),
        from: fromTimeController.text,
        to: toTimeController.text,
        patientNums: int.parse(numberOfPeopleController.text),
        address: patientAddressController.text,
        attendant: assistantNameController.text,
        attendantPhone: assistantPhoneController.text,
        note: noteController.text,
        addressUrl: googleLinkController.text,
        areaId: areaId[areaNames.indexOf(areaName.value)],
        addressType: addressTypeList.indexOf(addressType.value)+1,
        id: visit.value.id,
      );
      visit.value = await mainController.editVisit(lang.value,token.value,newVisit.value);
      Get.offNamedUntil(
          Routes.VISIT_DETAILS,arguments: [lang.value,isDark.value,token.value,visit.value], (route) => route.settings.name == Routes.HOME);
    }catch (e){
      Get.snackbar("Error", e.toString());
    }finally{
      internalLoading(false);
    }
  }


  void displayData() {
    dateController = TextEditingController(text: visit.value.date);
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
    areaName.value=visit.value.areaName??'';
    addressType.value=addressTypeList[visit.value.addressType!-1];
    userType.value =visit.value.userName??'';
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
        areaId: areaId[areaNames.indexOf(areaName.value)],
        addressType: addressTypeList.indexOf(addressType.value)+1,
        userId: userId[userNames.indexOf(userType.value)]
      );
      visit.value = await mainController.addVisit(lang.value,token.value,newVisit.value);
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
