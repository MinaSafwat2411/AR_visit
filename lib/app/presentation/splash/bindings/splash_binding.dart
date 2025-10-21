import 'package:get/get.dart';

import '../../../app_module.dart';
import '../../../domain/usecase/base_use_case_interface.dart';
import '../controllers/splash_controllers.dart';



class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
          () => SplashController(getIt<BaseUseCaseInterface>()),
    );
  }
}
