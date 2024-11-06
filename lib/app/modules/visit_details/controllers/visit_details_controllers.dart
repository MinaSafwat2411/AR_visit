import 'package:ar_visiting_app/app/core/models/visits/visitsmodel.dart';
import 'package:ar_visiting_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../core/firebase/AddVisitFirebase.dart';
import '../../../core/firebase/GetVisitDetailsFirebase.dart';
import '../../../core/models/visits/addvisitmodel.dart';
import '../../../core/sharedchache/cache_helper.dart';
import '../../../core/utils/app_string.dart';

class VisitDetailsControllers extends GetxController {
  var isLoading = false.obs;
  var isDropdownOpen  = false.obs;
  var visitTime  = ''.obs;
  String id =Get.arguments;
  var visitData=VisitModel(
    id: '',
    status: '',
    area: {},
    father: {},
    patient: {},
    assistant: {},
    servant: {},
    visitDate: '',
    visitTimeRangeFrom: '',
    visitTimeRangeTo: '',
    numberOfPeople: '',
    address: {},
    googleLink: '',
    note: ''
  ).obs;
  String lang=CacheHelper.getData(key: 'lang')??'en';

  String getVisitDetailsTitle(){
    return lang =='en'? AppStringsEn.visitDetailsTitle : AppStringsAr.visitDetailsTitle;
  }
  String getVisitCancelComfirm(){
    return lang =='en'? AppStringsEn.cancelComfirm : AppStringsAr.cancelComfirm;
  }
  String getComfirmYes(){
    return lang =='en'? AppStringsEn.yes : AppStringsAr.yes;
  }
  String getComfirmNo(){
    return lang =='en'? AppStringsEn.no : AppStringsAr.no;
  }
  String getEdit(){
    return lang =='en'? AppStringsEn.edit : AppStringsAr.edit;
  }
  String getCancel(){
    return lang =='en'? AppStringsEn.cancel : AppStringsAr.cancel;
  }
  String getPatientName(){
    return lang =='en'? AppStringsEn.patientName : AppStringsAr.patientName;
  }
  String getPatientArid(){
    return lang =='en'? AppStringsEn.arid : AppStringsAr.arid;
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
  String getTimeSting(){
    return lang =='en'? AppStringsEn.time : AppStringsAr.time;
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
  String getServant(){
    return lang =='en'? AppStringsEn.servant : AppStringsAr.servant;
  }
  String getFather(){
    return lang =='en'? AppStringsEn.father : AppStringsAr.father;
  }
  String getAssign(){
    return lang =='en'? AppStringsEn.assign : AppStringsAr.assign;
  }
  String getDone(){
    return lang =='en'? AppStringsEn.assign : AppStringsAr.assign;
  }
  String getAssignComfim(){
    return lang =='en'? AppStringsEn.assignComfirm : AppStringsAr.assignComfirm;
  }
  String getDoneComfim(){
    return lang =='en'? AppStringsEn.doneComfirm : AppStringsAr.doneComfirm;
  }


  @override
  void onInit() async{
    super.onInit();
    await getVisitDetails();
  }
  void onMenuClicked(){
    isDropdownOpen.value=!isDropdownOpen.value;
  }
  // Fetch Visit Details from Firebase
  Future<void> getVisitDetails() async {
    isLoading.value = true;
    try {
      VisitModel? visitDetails = await VisitsRetriever.retrieveVisitDetails(id);
      visitData.value=visitDetails!;
    } catch (e) {
      Get.snackbar("Error", "Failed to retrieve visit details: $e");
    } finally {
      isLoading.value = false;
      getTime();
    }
  }
  void onDone(){
    isLoading(true);
    try{
      Visit newVisit = Visit(
          area: visitData.value.area,
          father: visitData.value.father,
          patient: visitData.value.patient,
          servant: visitData.value.servant,
          assistant: visitData.value.assistant,
          status: 'Done',
          address: visitData.value.address,
          visitDate: visitData.value.visitDate,
          visitTimeRangeFrom: visitData.value.visitTimeRangeFrom,
          visitTimeRangeTo:visitData.value.visitTimeRangeTo,
          numberOfPeople: visitData.value.numberOfPeople,
          note: visitData.value.note,
          googleLink: visitData.value.googleLink
      );
      VisitSubmission.updateVisit(id,newVisit);
      Get.snackbar("Visits", "Visits has been Done");
      Get.offAllNamed(Routes.VISITS);
    }catch (e){
      Get.snackbar("Error", e.toString());
    }finally{
      isLoading(false);
    }
  }
  void getTime(){
    String? from;
    String? to;
    if(visitData.value.visitTimeRangeTo.length==7){
      to=visitData.value.visitTimeRangeTo.substring(0,4);
    }else if(visitData.value.visitTimeRangeTo.length==8){
      to=visitData.value.visitTimeRangeTo.substring(0,5);
    }
    if(visitData.value.visitTimeRangeFrom.length==7){
      from=visitData.value.visitTimeRangeFrom.substring(0,4);
    }else if(visitData.value.visitTimeRangeFrom.length==8){
      from=visitData.value.visitTimeRangeFrom.substring(0,5);
    }

    lang == 'en'? visitTime.value='$from To $to':visitTime.value='$from الي $to';
  }

  void onCanceled() {
    isLoading(true);
    try{
      Visit newVisit = Visit(
          area: visitData.value.area,
          father: visitData.value.father,
          patient: visitData.value.patient,
          servant: visitData.value.servant,
          assistant: visitData.value.assistant,
          status: 'Canceled',
          address: visitData.value.address,
          visitDate: visitData.value.visitDate,
          visitTimeRangeFrom: visitData.value.visitTimeRangeFrom,
          visitTimeRangeTo:visitData.value.visitTimeRangeTo,
          numberOfPeople: visitData.value.numberOfPeople,
          note: visitData.value.note,
          googleLink: visitData.value.googleLink
      );
      VisitSubmission.updateVisit(id,newVisit);
      Get.snackbar("Visits", "Visits has been canceled");
      Get.offAllNamed(Routes.VISITS);
    }catch (e){
      Get.snackbar("Error", e.toString());
    }finally{
      isLoading(false);
    }
  }
}