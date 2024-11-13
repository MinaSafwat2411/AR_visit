import 'package:ar_visiting_app/app/core/models/area/areamodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/firebase/AddVisitFirebase.dart';
import '../../../core/firebase/GetAreaFirebase.dart';
import '../../../core/models/visits/addvisitmodel.dart';
import '../../../core/sharedchache/cache_helper.dart';
import '../../../core/utils/app_string.dart';
import '../../../routes/app_pages.dart';

class AddNewVisitController extends GetxController {
  var addressType = ''.obs;
  var addressTypeAr = ''.obs;
  var areaName = ''.obs;
  var areaNameAr = ''.obs;
  var areaNames = <String>[].obs;
  var areaNamesAr = <String>[].obs;
  var areaData =<Area>[].obs;
  var isLoading = false.obs;
  var id =''.obs;
  String lang=CacheHelper.getData(key: 'lang')??'en';
  final formKey = GlobalKey<FormState>();
  var addressTypeList=['Hospital', 'Home', 'Dar'];
  var addressTypeListAr=['مستشفى', 'منزل', 'دار'];

  TextEditingController dateController = TextEditingController();
  TextEditingController fromTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();
  TextEditingController numberOfPeopleController = TextEditingController();
  TextEditingController patientNameController = TextEditingController();
  TextEditingController patientLocationController = TextEditingController();
  TextEditingController patientAddressController = TextEditingController();
  TextEditingController assistantNameController = TextEditingController();
  TextEditingController patientPhoneController = TextEditingController();
  TextEditingController assistantPhoneController = TextEditingController();
  TextEditingController patientFamIDController = TextEditingController();
  TextEditingController patientIDNumberController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController googleLinkController = TextEditingController();

  String getNewVisitTitle(){
    return lang =='en'? AppStringsEn.newVisitTitle : AppStringsAr.newVisitTitle;
  }
  String getSubmit(){
    return lang =='en'? AppStringsEn.submit : AppStringsAr.submit;
  }
  String getComfirmYes(){
    return lang =='en'? AppStringsEn.yes : AppStringsAr.yes;
  }
  String getComfirmNo(){
    return lang =='en'? AppStringsEn.no : AppStringsAr.no;
  }
  String getPatientName(){
    return lang =='en'? AppStringsEn.patientName : AppStringsAr.patientName;
  }
  String getAssistantName(){
    return lang =='en'? AppStringsEn.assistantName : AppStringsAr.assistantName;
  }
  String getPatientNameValidate(){
    return lang =='en'? AppStringsEn.patientNameValidate : AppStringsAr.patientNameValidate;
  }
  String getPatientPhoneNumber(){
    return lang =='en'? AppStringsEn.patientPhoneNumber : AppStringsAr.patientPhoneNumber;
  }
  String getNoOfPeople(){
    return lang =='en'? AppStringsEn.noOfPeople : AppStringsAr.noOfPeople;
  }
  String getAssistantPhoneNumber(){
    return lang =='en'? AppStringsEn.assistantPhoneNumber : AppStringsAr.assistantPhoneNumber;
  }
  String getAssistantNameValidate(){
    return lang =='en'? AppStringsEn.assistantNameValidate : AppStringsAr.assistantNameValidate;
  }
  String getAssistantPhoneNumberValidate1(){
    return lang =='en'? AppStringsEn.assistantPhoneNumberValidate1 : AppStringsAr.assistantPhoneNumberValidate1;
  }
  String getAssistantPhoneNumberValidate2(){
    return lang =='en'? AppStringsEn.assistantPhoneNumberValidate2 : AppStringsAr.assistantPhoneNumberValidate2;
  }
  String getAddressType(){
    return lang =='en'? AppStringsEn.addressType : AppStringsAr.addressType;
  }
  String getAddress(){
    return lang =='en'? AppStringsEn.address : AppStringsAr.address;
  }
  String getAddressValidate(){
    return lang =='en'? AppStringsEn.addressValidate : AppStringsAr.addressValidate;
  }
  String getZone(){
    return lang =='en'? AppStringsEn.zone : AppStringsAr.zone;
  }
  String getDate(){
    return lang =='en'? AppStringsEn.date : AppStringsAr.date;
  }
  String getFrom(){
    return lang =='en'? AppStringsEn.from : AppStringsAr.from;
  }
  String getStart(){
    return lang =='en'? AppStringsEn.start : AppStringsAr.start;
  }
  String getNotes(){
    return lang =='en'? AppStringsEn.notes : AppStringsAr.notes;
  }
  String getEnd(){
    return lang =='en'? AppStringsEn.end : AppStringsAr.end;
  }
  String getTo(){
    return lang =='en'? AppStringsEn.to : AppStringsAr.to;
  }
  String getFromValidate(){
    return lang =='en'? AppStringsEn.fromValidate : AppStringsAr.fromValidate;
  }
  String getToValidate(){
    return lang =='en'? AppStringsEn.toValidate : AppStringsAr.toValidate;
  }
  String getDateValidate(){
    return lang =='en'? AppStringsEn.dateValidate : AppStringsAr.dateValidate;
  }
  String getGoogleMapLink(){
    return lang =='en'? AppStringsEn.googleMapsLink : AppStringsAr.googleMapsLink;
  }
  List<String> getAddressTypeList(){
    return lang =='en'? addressTypeList: addressTypeListAr;
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
                      255, 239, 84, 0), //header and selced day background color
                  onPrimary: Colors.white, // titles and
                  onSurface: Colors.black, // Month days , years
                ),
              ),
              child: child!);
        });
    if (datePicked != null) {
      // setState(() {
      dateController.text = datePicked.toString().split(" ")[0];
      // });
    }
  }
  void getAreaData(){
    int? index;
    if(areaName.value==''){
      index=areaNamesAr.value.indexOf(areaNameAr.value);
      areaName.value = areaNames[index];
    }else if(areaNameAr.value ==''){
      index=areaNames.value.indexOf(areaName.value);
      areaNameAr.value = areaNamesAr[index];
    }
  }
  void getTypeAddress(){
    int? index;
    if(addressType.value==''){
      index=addressTypeListAr.indexOf(addressTypeAr.value);
      print(index);
      addressType.value = addressTypeList[index];
    }else if(addressTypeAr.value ==''){
      index=addressTypeList.indexOf(addressType.value);
      print(index);
      addressTypeAr.value = addressTypeListAr[index];
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
    if (fromTimePicked != null) {
        fromTimeController.text = fromTimePicked.format(context).toString();
    }
  }

  Future<void> selectedToTime(BuildContext context) async {
    TimeOfDay? toTimePicked = await showTimePicker(
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
    if (toTimePicked != null) {
        toTimeController.text = toTimePicked.format(context).toString();
    }
  }

  Future<void> getAreasNames() async {
    isLoading.value = true;
    try {
      areaData.value = await GetAreaFirebase.retrieveArea();
      areaNames.value = areaData.map((area) => area.area!).toList();
      areaNamesAr.value = areaData.map((area) => area.areaAr!).toList();
    }catch(e){
      Get.snackbar("Error", "Failed to retrieve area details");
    }finally{
      isLoading.value=false;
    }
  }

  void addVisit() async{
    isLoading(true);
    try{
      getAreaData();
      getTypeAddress();
      Visit newVisit = Visit(
        area: {
          'name': areaName.value,
          'nameAr': areaNameAr.value
        },
        father: {
          'id': '',
          'isFather': true,
          'name': '',
          'nameAr': '',
          'phoneNumber': ''
        },
        patient: {
          'name': patientNameController.text,
          'phoneNumber': patientPhoneController.text,
          'PatientFamilyId': patientFamIDController.text,
          'PatientIDNumber': patientIDNumberController.text,
        },
        servant: {
          'id': '',
          'isFather': false,
          'name': '',
          'nameAr': '',
          'phoneNumber': ''
        },
         assistant: {
            'name': assistantNameController.text,
            'phoneNumber':assistantPhoneController.text
          },
        status: 'NEW',
        address: {
          'address':patientAddressController.text,
          'addressType':addressType.value,
          'addressTypeAr':addressTypeAr.value,
        },
        visitDate: dateController.text,
        visitTimeRangeFrom: fromTimeController.text,
        visitTimeRangeTo: toTimeController.text,
        numberOfPeople: numberOfPeopleController.text,
        note: noteController.text,
        googleLink: googleLinkController.text
      );
      id.value = await VisitSubmission.submitVisit(newVisit);
      Get.snackbar("Visits", "Visits add successfully");
      Get.offNamedUntil(
          Routes.VISIT_DETAILS,
              (route) => route.settings.name == Routes.VISITS,
          arguments: id.value
      );
    }catch (e){
      Get.snackbar("Error", e.toString());
    }finally{
      isLoading(false);
    }
  }

  @override
  void onInit() async{
    await getAreasNames();
    super.onInit();
  }
}
