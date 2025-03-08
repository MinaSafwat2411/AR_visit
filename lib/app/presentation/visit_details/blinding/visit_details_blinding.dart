import 'package:get/get.dart';

import '../controllers/visit_details_controllers.dart';

class VisitDetailsBlinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitDetailsControllers>(
          () => VisitDetailsControllers(),
    );
  }
}