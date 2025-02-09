import 'package:ar_visiting_app/app/modules/register/controllers/register_controller.dart';
import 'package:get/get.dart';


class RegisterBlinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
          () => RegisterController(),
    );
  }
}