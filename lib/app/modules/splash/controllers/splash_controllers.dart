import 'dart:async';
import 'package:ar_visiting_app/app/core/utils/app_string.dart';
import 'package:get/get.dart';
import '../../../core/sharedchache/cache_helper.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  bool loginDone=CacheHelper.getData(key: 'loginDone') ?? false;
  String lang=CacheHelper.getData(key: 'lang') ?? 'en';

  @override
  void onInit()async {
    super.onInit();
    onNavigate();
  }

  void onNavigate(){
    Timer(const Duration(seconds:4), () {
      if(loginDone) {
        Get.offNamed(Routes.VISITS);
      }else{
        Get.offNamed(Routes.LOGIN);
      }
    });
  }
}