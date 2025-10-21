import 'package:get/get.dart';

import '../../../app_module.dart';
import '../../../domain/usecase/base_use_case_interface.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(getIt<BaseUseCaseInterface>()),
    );
  }
}
