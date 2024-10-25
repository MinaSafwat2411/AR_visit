import 'package:ar_visiting_app/app/core/models/visits/visitsmodel.dart';
import 'package:get/get.dart';

import '../../../core/firebase/GetVisitDetailsFirebase.dart';

class VisitDetailsControllers extends GetxController {
  var isLoading = false.obs;
  var isDropdownOpen  = false.obs;
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

  @override
  void onInit() async{
    super.onInit();
    getVisitDetails();
  }
  void onMenuClicked(){
    isDropdownOpen.value=!isDropdownOpen.value;
  }
  // Fetch Visit Details from Firebase
  void getVisitDetails() async {
    isLoading.value = true;
    try {
      VisitModel? visitDetails = await VisitDetailRetriever.retrieveVisitDetails(id);
      visitData.value=visitDetails!;
    } catch (e) {
      Get.snackbar("Error", "Failed to retrieve visit details: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onNavigate() {
    // Handle navigation
  }
}