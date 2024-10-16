import 'package:ar_visiting_app/app/core/firebase/GetVisitsFirebase.dart';
import 'package:ar_visiting_app/app/core/models/login/visitsmodel.dart';
import 'package:get/get.dart';


class VisitController extends GetxController {
  var visitData = <String, dynamic>{}.obs;
  var visitsDates = <String>[].obs;
  var tagsStatusList = [true, false, false, false, false, false].obs;
  var tags=["All","NEW","Assigned","Done","Canceled"];

  @override
  void onInit() {
    super.onInit();
    getVisitdata();
  }

  void getVisitdata() async {
    List<VisitModel> visits = await VisitDetailsRetriever.retrieveVisits(); // Await the data

    Map<String, VisitModel> tempVisitData = {};
    List<String> tempVisitsDates = [];

    for (var visit in visits) {
      tempVisitData[visit.visitDate] = visit;
      tempVisitsDates.add(visit.visitDate);
    }

    visitData.value = tempVisitData;
    visitsDates.value = tempVisitsDates;
  }

  Map<String, VisitModel> getFilteredVisitData(String selectedStatus) {
    if (selectedStatus == "All") {
      return Map<String, VisitModel>.from(visitData);
    }

    return Map<String, VisitModel>.fromEntries(
      visitData.entries.where((entry) {
        final visitModel = entry.value as VisitModel; // Cast the value to VisitModel
        return visitModel.status == selectedStatus;
      }).map((entry) => MapEntry<String, VisitModel>(entry.key, entry.value as VisitModel)),
    );
  }
}
