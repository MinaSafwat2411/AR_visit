
import 'dart:async';
import 'package:get/get.dart';
import '../../../core/services/cache_helper.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  var token = ''.obs;
  var lang = ''.obs;
  var isDark = RxBool(false);
  var reload = false.obs;

  @override
  void onInit() async {
    lang.value = await CacheHelper.getData(key: 'lang') ?? 'en';
    isDark.value = await CacheHelper.getData(key: 'isDark')?? false;
    super.onInit();
    onNavigate();
  }


  void onNavigate() async {
    try{
      token.value = await CacheHelper.getData(key: 'token') ?? '';
      Timer(const Duration(seconds: 3),() {
        if (token.value.isEmpty) {
          Get.offNamed(Routes.LOGIN, arguments: [lang.value, isDark.value]);
          return;
        } else {
          Get.offNamed(Routes.HOME, arguments: [lang.value, isDark.value, token.value]);
        }
      });
    }catch(e){
      Get.offNamed(Routes.LOGIN,arguments: [lang.value,isDark.value]);
    }
    }
}
