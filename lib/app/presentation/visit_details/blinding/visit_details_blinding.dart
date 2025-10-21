import 'package:get/get.dart';

import '../../../app_module.dart';
import '../../../domain/usecase/base_use_case_interface.dart';
import '../controllers/visit_details_controllers.dart';

class VisitDetailsBlinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitDetailsControllers>(
          () => VisitDetailsControllers(getIt<BaseUseCaseInterface>()),
    );
  }
}