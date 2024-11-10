import 'package:get/get.dart';

import '../controllers/all_visits_controller.dart';

class AllVisitsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllVisitController>(
      () => AllVisitController(),
    );
  }
}
