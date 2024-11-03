import 'package:get/get.dart';

import '../controllers/assign_servant_visit_controller.dart';



class AssignServantVisitBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AssignServantVisitController>(
      () => AssignServantVisitController(),
    );
  }

}