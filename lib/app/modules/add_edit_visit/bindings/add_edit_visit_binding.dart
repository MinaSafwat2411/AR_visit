import 'package:get/get.dart';

import '../controllers/add_new_visit_controller.dart';

class AddNewVisitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewVisitController>(
      () => AddNewVisitController(),
    );
  }
}
