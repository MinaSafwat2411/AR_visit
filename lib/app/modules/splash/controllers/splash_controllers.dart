
import 'package:ar_visiting_app/app/core/services/dio_helper.dart';
import 'package:ar_visiting_app/app/core/utils/backend_endpoint.dart';
import 'package:get/get.dart';
import '../../../core/services/cache_helper.dart';
import '../../../core/services/secure_cache_helper.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  var token = ''.obs;
  var lang = ''.obs;
  var isDark = RxBool(false);
  var reload = false.obs;

  @override
  void onInit() async {
    token.value = await SecureCacheHelper.getData(key: 'token') ?? '';
    lang.value = await CacheHelper.getData(key: 'lang') ?? 'en';
    isDark.value = await CacheHelper.getData(key: 'isDark')?? false;
    super.onInit();
    onNavigate();
  }


  void onNavigate() async {
    try {
      await DioHelper.getData(
        url: BackendEndpoint.enums,
        token: token.value,
        lang: lang.value,
      );
      Get.offNamed(Routes.HOME, arguments: [lang,isDark,token]);
    }catch (e) {
      Get.offNamed(Routes.LOGIN,arguments: [lang,isDark]);
    }
  }

}
