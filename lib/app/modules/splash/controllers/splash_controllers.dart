import 'dart:async';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    onNavigate();
  }

  void onNavigate(){
    print("object");
    Timer(const Duration(seconds: 5), () {
      Get.offNamed(Routes.LOGIN);
    });
  }
}