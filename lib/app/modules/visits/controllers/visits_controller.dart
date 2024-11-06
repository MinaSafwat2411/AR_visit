import 'dart:async';

import 'package:ar_visiting_app/app/core/models/visits/visitsmodel.dart';
import 'package:ar_visiting_app/app/core/sharedchache/cache_helper.dart';
import 'package:get/get.dart';

import '../../../core/firebase/GetVisitDetailsFirebase.dart';
import '../../../core/utils/app_string.dart';


class VisitController extends GetxController {
  var visitData = <String, VisitModel>{}.obs;
  var visitsDates = <String>[].obs;
  var tagsStatusList = [false ,true ,false, false, false, false].obs;
  var isLoading=RxBool(false);
  var groupedVisits = <DateTime, List<VisitModel>>{}.obs;
  var sortedDates = <DateTime>[].obs;
  var id=''.obs;
  String lang=CacheHelper.getData(key: 'lang')??'en';
  var tags= ["Me","All","NEW","Assigned","Done","Canceled"];
  var tagsAr= ["أنا","الكل", "جديد", "تم تعيينه", "تم", "تم إلغاؤه"];

  void getUserId(){
    id.value=CacheHelper.getData(key: 'user');
  }
  String getYesterday(){
    return lang =='en'? AppStringsEn.yesterday : AppStringsAr.yesterday;
  }
  String getToday(){
    return lang =='en'? AppStringsEn.today : AppStringsAr.today;
  }
  String getTomorrow(){
    return lang =='en'? AppStringsEn.tomorrow : AppStringsAr.tomorrow;
  }
  String getVisitTitle(){
    return lang =='en'? AppStringsEn.visitTitle : AppStringsAr.visitTitle;
  }
  String getNoOfPeople(){
    return lang =='en'? AppStringsEn.noOfPeople : AppStringsAr.noOfPeople;
  }
  String getFather(){
    return lang =='en'? AppStringsEn.father : AppStringsAr.father;
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
  String getZone(){
    return lang =='en'? AppStringsEn.zone : AppStringsAr.zone;
  }
  String getServant(){
    return lang =='en'? AppStringsEn.servant : AppStringsAr.servant;
  }


  @override
  void onInit() async{
    super.onInit();
    getUserId();
    await getVisitData();
    _startRefreshTimer();
  }



  void _startRefreshTimer() {
    Timer.periodic(const Duration(seconds: 30), (timer) {
      getVisitData();
    });
  }

  Future<void> getVisitData() async {
    isLoading.value = true;
    String selectedStatus = tags[tagsStatusList.indexOf(true)];

    try {
      final visits = await VisitsRetriever.retrieveVisits();
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
