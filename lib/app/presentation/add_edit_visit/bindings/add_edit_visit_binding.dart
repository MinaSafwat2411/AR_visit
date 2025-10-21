import 'package:get/get.dart';

import '../../../app_module.dart';
import '../../../domain/usecase/base_use_case_interface.dart';
import '../controllers/add_edit_visit_controller.dart';

class AddEditVisitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEditVisitController>(
      () => AddEditVisitController(getIt<BaseUseCaseInterface>()),
    );
  }
}
