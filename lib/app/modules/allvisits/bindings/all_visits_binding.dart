import 'package:get/get.dart';

import '../controllers/all_visits_controller.dart';

class ALLVisitsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ALLVisitController>(
      () => ALLVisitController(),
    );
  }
}
