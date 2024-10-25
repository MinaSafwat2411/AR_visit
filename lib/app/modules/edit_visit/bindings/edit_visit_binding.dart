import 'package:get/get.dart';

import '../controllers/edit_visit_controller.dart';

class EditVisitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditVisitController>(
      () => EditVisitController(),
    );
  }
}
