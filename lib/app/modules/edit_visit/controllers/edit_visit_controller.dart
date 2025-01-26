
import 'package:ar_visiting_app/app/core/controller/main_controller.dart';
import 'package:ar_visiting_app/app/core/models/login/loginmodel.dart';
import 'package:ar_visiting_app/app/core/models/visits/visitmodel.dart';
import 'package:ar_visiting_app/app/core/services/cache_helper.dart';
import 'package:ar_visiting_app/app/modules/add_new_visit/controllers/add_new_visit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/area/areamodel.dart';

class EditVisitController extends GetxController {
  var visit =VisitModel().obs;
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
  int visitId = Get.arguments;
  var lang=''.obs;
  final formKey = GlobalKey<FormState>();
  var addressTypeList=<String>[].obs;
  var token = ''.obs;
  var newVisit = VisitModel().obs;

  var mainController = MainController();

  Future<void> getVisitDetails() async {
    isLoading.value = true;
    try {

    } catch (e) {
      Get.snackbar("Error", "Failed to retrieve visit details: $e");
    } finally {
      isLoading.value = false;
    }
  }



  TextEditingController dateController = TextEditingController();
  TextEditingController fromTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();
  TextEditingController numberOfPeopleController = TextEditingController();
  TextEditingController patientAddressController = TextEditingController();
  TextEditingController assistantNameController = TextEditingController();
  TextEditingController assistantPhoneController = TextEditingController();
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
    }
  }


  void editVisit() async{
    Get.back(closeOverlays: true);
    isLoading(true);
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
        area_id: areaId[areaNames.indexOf(areaName.value)],
        addressType: addressTypeList.indexOf(addressType.value)+1,
        );
        await mainController.editVisit(newVisit.value,visit.value.id!);
    }catch (e){
      Get.snackbar("Error", e.toString());
    }finally{
      isLoading(false);
    }
  }

  Future<void> getVisitData()async{
    isLoading(true);
    try{
      visit.value= (await mainController.getVisitData(visitId))!;
    }catch(e){
      Get.snackbar("Error", "Failed to retrieve visit data: $e");
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
    areaName.value=visit.value.areaName!;
    addressType.value=addressTypeList[visit.value.addressType!-1];
    isLoading(false);
  }

  @override
  void onInit() async {
    lang.value =(await CacheHelper.getData(key: 'lang'))!;
    getAddressType();
    await getVisitData();
    await getData();
    displayData();
    super.onInit();
  }
}
