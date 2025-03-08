import 'package:get/get.dart';

import '../controllers/register_controller.dart';


class RegisterBlinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
          () => RegisterController(),
    );
  }
}