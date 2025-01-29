
import 'package:ar_visiting_app/app/core/services/dio_helper.dart';
import 'package:ar_visiting_app/app/core/services/secure_cache_helper.dart';
import 'package:ar_visiting_app/app/core/utils/backend_endpoint.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  var token = ''.obs;
  var lang = ''.obs;
  var reload = false.obs;

  @override
  void onInit() async {
    token.value = await SecureCacheHelper.getData(key: 'token') ?? '';
    lang.value = await SecureCacheHelper.getData(key: 'lang') ?? 'en';
    super.onInit();
    onNavigate();
  }

  void onNavigate() async {
    reload.value = false;
    if (token.isNotEmpty) {
      try {
        await DioHelper.getData(
            url: BackendEndpoint.enums, token: token.value,lang: lang.value);
                  Get.offNamed(Routes.HOME);
      } catch (e) {
        Get.snackbar('Error', 'check your connection');
        reload.value = true;
      }
    } else {
      Get.offNamed(Routes.LOGIN);
    }
  }
}
