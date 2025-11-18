import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/services/cache_helper.dart';
import '../domain/usecase/base_use_case_interface.dart';

class AppController extends GetxController {

  AppController(this.useCase);

  final BaseUseCaseInterface useCase;

  var isDark= RxBool(false);
  var lang = RxString('');

  ThemeMode get themeMode => isDark.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() async{
    isDark.value = !isDark.value;
    await useCase.setTheme(isDark.value);
  }

  var currentLocale = const Locale('ar', 'SA').obs;

  void changeLocale(Locale locale) {
    currentLocale.value = locale;
  }

  void changeLanguage(String lang)async {
    await useCase.setLang(lang);
    this.lang.value = lang;
    Get.updateLocale(Locale(lang));
  }

  @override
  void onInit() {
    super.onInit();
    lang.value = CacheHelper.getData(key: 'lang') ?? 'ar';
    isDark.value = CacheHelper.getData(key: 'isDark') ?? false;
    currentLocale.value = Locale(lang.value);
  }
}
