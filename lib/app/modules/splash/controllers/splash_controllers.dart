import 'dart:async';
import 'package:ar_visiting_app/app/core/services/secure_cache_helper.dart';
import 'package:get/get.dart';
import '../../../core/services/cache_helper.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  var token=''.obs;
  var lang=''.obs;

  @override
  void onInit()async {
    token.value=await SecureCacheHelper.getData(key: 'token') ?? '';
    lang.value=await SecureCacheHelper.getData(key: 'lang') ?? 'en';
    super.onInit();
    onNavigate();
  }

  void onNavigate(){
    Timer(const Duration(seconds:4), () {
      if(token.isNotEmpty) {
        Get.offNamed(Routes.VISITS);
      }else{
        Get.offNamed(Routes.LOGIN);
      }
    });
  }
}