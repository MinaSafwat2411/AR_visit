import 'package:ar_visiting_app/app/core/models/visits/visitsmodel.dart';
import 'package:ar_visiting_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../core/firebase/AddVisitFirebase.dart';
import '../../../core/firebase/GetVisitDetailsFirebase.dart';
import '../../../core/models/visits/addvisitmodel.dart';
import '../../../core/sharedchache/cache_helper.dart';

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

    visitTime.value='$from To $to';
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