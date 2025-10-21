import 'package:get/get.dart';

import '../../../app_module.dart';
import '../../../domain/usecase/base_use_case_interface.dart';
import '../controllers/register_controller.dart';


class RegisterBlinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
          () => RegisterController(getIt<BaseUseCaseInterface>()),
    );
  }
}