import 'package:get/get.dart';

import '../controllers/assign_father_visit_controller.dart';


class AssignFatherVisitBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AssignFatherVisitController>(
      () => AssignFatherVisitController(),
    );
  }

}