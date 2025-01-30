import 'package:ar_visiting_app/app/core/controller/main_controller.dart';
import 'package:ar_visiting_app/app/core/models/area/areamodel.dart';
import 'package:ar_visiting_app/app/core/models/login/loginmodel.dart';
import 'package:ar_visiting_app/app/core/models/visits/visitmodel.dart';
import 'package:ar_visiting_app/app/core/services/secure_cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/cache_helper.dart';
import '../../../routes/app_pages.dart';

class AddNewVisitController extends GetxController {
  var addressType = ''.obs;
  var userType = ''.obs;
  var areaName = ''.obs;
  var areaNames = <String>[].obs;
  var userNames = <String>[].obs;
  var areaId = <int>[].obs;
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
    if (datePicked != null) {
      dateController.text = "${datePicked.year}-${datePicked.month.toString().padLeft(2, '0')}-${datePicked.day.toString().padLeft(2, '0')}";
    }
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
    if (fromTimePicked != null && Get.isRegistered<AddNewVisitController>() && Get.context != null) {
      fromTimeController.text = fromTimePicked.format(Get.context!).toString();
    }
  }

  Future<void> selectedToTime() async {
    if (!Get.isRegistered<AddNewVisitController>() || Get.context == null) return;
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
    isLoading.value = true;
    try {
      var userData = await mainController.getUserData();
      var areaData = await mainController.getAreaData();
        areaData?.forEach((element) {
        areaNames.add(element.name!);
        areaId.add(element.id!);
      });
      userData?.forEach((element) {
        userNames.add(element.name!);
        userId.add(element.id!);
      });
    }catch(e){
      Get.snackbar("Error", "Failed to retrieve area details");
    }finally{
      isLoading(false);
    }
  }

  void addVisit() async{
    isLoading(true);
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
      mainController.addVisit(newVisit.value);
      Get.snackbar("Visits", "Visit add successfully");
      Get.offNamedUntil(
          Routes.HOME,
              (route) => route.settings.name == Routes.VISITS
      );
    }catch (e){
      Get.snackbar("Error", e.toString());
    }finally{
      isLoading(false);
    }
  }

  @override
  void onInit() async{
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    getAddressType();
    getData();
    super.onInit();
  }
}
