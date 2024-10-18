import 'dart:async';

import 'package:ar_visiting_app/app/core/firebase/GetVisitsFirebase.dart';
import 'package:ar_visiting_app/app/core/models/visits/visitsmodel.dart';
import 'package:get/get.dart';


class VisitController extends GetxController {
  var visitData = <String, VisitModel>{}.obs;
  var visitsDates = <String>[].obs;
  var tagsStatusList = [true, false, false, false, false, false].obs;
  var tags=["All","NEW","Assigned","Done","Canceled"];
  var isLoading=RxBool(false);

  @override
  void onInit() async{
    super.onInit();
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

    try {
      final visits = await VisitDetailsRetriever.retrieveVisits();
      visitData.value = visits;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }finally{
      isLoading.value = false;
    }
  }

  Map<String, VisitModel> getFilteredVisitData(String selectedStatus) {
    if (selectedStatus == "All") {
      return Map<String, VisitModel>.from(visitData);
    }

    return Map<String, VisitModel>.fromEntries(
      visitData.entries.where((entry) {
        final visitModel = entry.value; // Cast the value to VisitModel
        return visitModel.status == selectedStatus;
      }).map((entry) => MapEntry<String, VisitModel>(entry.key, entry.value)),
    );
  }
}
