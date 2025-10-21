import 'package:get/get.dart';

import '../../../app_module.dart';
import '../../../domain/usecase/base_use_case_interface.dart';
import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
          () => ProfileController(getIt<BaseUseCaseInterface>()),
    );
  }
}