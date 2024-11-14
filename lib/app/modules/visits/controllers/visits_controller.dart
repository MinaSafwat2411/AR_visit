import 'dart:async';

import 'package:ar_visiting_app/app/core/firebase/AddVisitFirebase.dart';
import 'package:ar_visiting_app/app/core/models/visits/visitsmodel.dart';
import 'package:ar_visiting_app/app/core/sharedchache/cache_helper.dart';
import 'package:get/get.dart';

import '../../../core/firebase/GetVisitDetailsFirebase.dart';
import '../../../core/models/visits/addvisitmodel.dart';
import '../../../core/utils/app_string.dart';
import '../../../routes/app_pages.dart';


class VisitController extends GetxController {
  var visitData = <String, VisitModel>{}.obs;
  var visitsDates = <String>[].obs;
  var tagsStatusList = [true ,false ,false, false, false, false].obs;
  var isLoading=RxBool(false);
  var groupedVisits = <DateTime, List<VisitModel>>{}.obs;
  var sortedDates = <DateTime>[].obs;
  var id=''.obs;
  String lang=CacheHelper.getData(key: 'lang')??'en';
  var tags= ["Me","All","NEW","Assigned","Done","Canceled"];
  var tagsAr= ["أنا","الكل", "جديد", "تم تعيينه", "تم", "تم إلغاؤه"];
  var visit=VisitModel(
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

  void getUserId(){
    id.value=CacheHelper.getData(key: 'user');
  }


  String getStatus(String status){
    if(lang =='en'){
      return status;
    }else{
      switch(status){
        case "NEW":
          return 'جديد';
        case "Assigned":
          return 'تم تعيينه';
        case "Done":
          return 'تم';
        case "Canceled":
          return 'تم الغاؤه';
      }
      return status;
    }
  }



  @override
  void onInit() async{
    super.onInit();
    getUserId();
    await getVisitData();
    _startRefreshTimer();
  }



  void _startRefreshTimer() {
    Timer.periodic(const Duration(seconds: 240), (timer) {
      getVisitData();
    });
  }
  void onCanceled(String id)async{
    isLoading(true);
    try{
      VisitModel? visitDetails = await VisitsRetriever.retrieveVisitDetails(id);
      visit.value=visitDetails!;
    }catch (e){
      Get.snackbar("Error", e.toString());
    }finally{
      try{
        Visit visitData = Visit(
            area: visit.value.area,
            father: visit.value.father,
            patient: visit.value.patient,
            servant: visit.value.servant,
            assistant: visit.value.assistant,
            status: 'Canceled',
            address: visit.value.address,
            visitDate: visit.value.visitDate,
            visitTimeRangeFrom: visit.value.visitTimeRangeFrom,
            visitTimeRangeTo:visit.value.visitTimeRangeTo,
            numberOfPeople: visit.value.numberOfPeople,
            note: visit.value.note,
            googleLink: visit.value.googleLink
        );
        VisitSubmission.updateVisit(id,visitData);
        Get.snackbar("Visits", "Visits has been Done");
      }catch(e){
        Get.snackbar("Error", e.toString());
      }finally{
        isLoading.value=false;
      }
      getVisitData();
    }
  }
  void onClone(String id)async{
    isLoading(true);
    try{
      VisitModel? visitDetails = await VisitsRetriever.retrieveVisitDetails(id);
      visit.value=visitDetails!;
    }catch (e){
      Get.snackbar("Error", e.toString());
    }finally{
      try{
        Visit visitData = Visit(
            area: visit.value.area,
            servant: {
              'id': '',
              'isFather': false,
              'name': '',
              'nameAr': '',
              'phoneNumber': ''
            },
            father: {
              'id': '',
              'isFather': true,
              'name': '',
              'nameAr': '',
              'phoneNumber': ''
            },
            patient: visit.value.patient,
            assistant: visit.value.assistant,
            status: 'New',
            address: visit.value.address,
            visitDate: visit.value.visitDate,
            visitTimeRangeFrom: visit.value.visitTimeRangeFrom,
            visitTimeRangeTo:visit.value.visitTimeRangeTo,
            numberOfPeople: visit.value.numberOfPeople,
            note: visit.value.note,
            googleLink: visit.value.googleLink
        );
        id = await VisitSubmission.submitVisit(visitData);
        Get.snackbar("Visits", "Visits has been Done");
      }catch(e){
        Get.snackbar("Error", e.toString());
      }finally{
        isLoading.value=false;
      }
      Get.toNamed(Routes.EDIT_VISIT,arguments: id);
      getVisitData();
    }
  }

  void onDone(String id)async{
    isLoading(true);
    try{
      VisitModel? visitDetails = await VisitsRetriever.retrieveVisitDetails(id);
      visit.value=visitDetails!;
    }catch (e){
      Get.snackbar("Error", e.toString());
    }finally{
      try{
        Visit visitData = Visit(
            area: visit.value.area,
            father: visit.value.father,
            patient: visit.value.patient,
            servant: visit.value.servant,
            assistant: visit.value.assistant,
            status: 'Done',
            address: visit.value.address,
            visitDate: visit.value.visitDate,
            visitTimeRangeFrom: visit.value.visitTimeRangeFrom,
            visitTimeRangeTo:visit.value.visitTimeRangeTo,
            numberOfPeople: visit.value.numberOfPeople,
            note: visit.value.note,
            googleLink: visit.value.googleLink
        );
        VisitSubmission.updateVisit(id,visitData);
        Get.snackbar("Visits", "Visits has been Done");
      }catch(e){
        Get.snackbar("Error", e.toString());
      }finally{
        isLoading.value=false;
      }
      getVisitData();
    }
  }
  Future<void> getVisitData() async {
    isLoading.value = true;
    String selectedStatus = tags[tagsStatusList.indexOf(true)];

    try {
      final visits = await VisitsRetriever.retrieveVisits(false);
      visitData.value = visits;
      if (selectedStatus == "All") {
        visitData.value =Map<String, VisitModel>.from(visitData);
      } else if (selectedStatus != "All" && selectedStatus != "Me"){
        visitData.value= Map<String, VisitModel>.fromEntries(
          visitData.entries.where((entry) {
            final visitModel = entry.value;
            return visitModel.status == selectedStatus;
          }).map((entry) => MapEntry<String, VisitModel>(entry.key, entry.value)),
        );
      }else if(selectedStatus == "Me"){
        visitData.value= Map<String, VisitModel>.fromEntries(
          visitData.entries.where((entry) {
            final visitModel = entry.value;
            return visitModel.father['id'] == id.value || visitModel.servant['id'] == id.value;
          }).map((entry) => MapEntry<String, VisitModel>(entry.key, entry.value)),
        );
    }
      groupedVisits.value={};
      for(var item in  visitData.values) {
        DateTime visitDate = DateTime.parse(item.visitDate);
        if (!groupedVisits.containsKey(visitDate)) {
          groupedVisits[visitDate] = [];
        }
        groupedVisits[visitDate]!.add(item);
      }
      sortedDates.value = groupedVisits.keys.toList()
        ..sort((a, b) => a.compareTo(b));
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }finally{
      isLoading.value = false;
    }
  }

}
