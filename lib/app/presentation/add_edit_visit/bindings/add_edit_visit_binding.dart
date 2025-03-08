import 'package:get/get.dart';

import '../controllers/add_edit_visit_controller.dart';

class AddEditVisitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEditVisitController>(
      () => AddEditVisitController(),
    );
  }
}
