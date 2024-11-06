import 'dart:async';

import 'package:ar_visiting_app/app/core/models/visits/visitsmodel.dart';
import 'package:ar_visiting_app/app/core/sharedchache/cache_helper.dart';
import 'package:ar_visiting_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../core/firebase/GetVisitDetailsFirebase.dart';


class VisitController extends GetxController {
  var visitData = <String, VisitModel>{}.obs;
  var visitsDates = <String>[].obs;
  var tagsStatusList = [false ,true ,false, false, false, false].obs;
  var tags=["Me","All","NEW","Assigned","Done","Canceled"];
  var isLoading=RxBool(false);
  var groupedVisits = <DateTime, List<VisitModel>>{}.obs;
  var sortedDates = <DateTime>[].obs;
  var id=''.obs;
  String lang=CacheHelper.getData(key: 'lang')??'en';

  void getUserId(){
    id.value=CacheHelper.getData(key: 'user');
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
