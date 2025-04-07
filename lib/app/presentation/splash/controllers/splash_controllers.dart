import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../main.dart';
import '../../../core/services/cache_helper.dart';
import '../../../data/repository/dio_helper_repository.dart';
import '../../../domain/usecase/base_use_case.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  var token = ''.obs;
  var lang = ''.obs;
  var isDark = RxBool(false);
  var reload = false.obs;
  final useCase = BaseUseCase(repository: DioHelperRepository.repository);

  @override
  void onInit() async {
    lang(await CacheHelper.getData(key: 'lang')?? 'en');
    isDark(await CacheHelper.getData(key: 'isDark')?? false);
    token(await CacheHelper.getData(key: 'token') ?? '');
    var changeLocale= Get.arguments??false;
    if(changeLocale){
      var locale = Locale(lang.value);
      Get.updateLocale(locale);
      runApp(MyApp(
        lang: lang.value,
        isDark: isDark.value,
      ));
    }
    super.onInit();
    onNavigate();
  }


  void onNavigate() async {
    if (token.value=='') {
      Get.offNamed(Routes.LOGIN, arguments: [lang.value, isDark.value]);
    } else {
      var enums =await useCase.getEnums(lang.value, token.value);
      if (enums != null) {
        CacheHelper.saveEnums(enums);
        Get.offNamed(
            Routes.HOME, arguments: [lang.value, isDark.value, token.value]);
      }
    }
  }
}
