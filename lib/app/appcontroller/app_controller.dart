import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/services/cache_helper.dart';

class AppController extends GetxController {

  var isDark= RxBool(false);
  var lang = RxString('');

  ThemeMode get themeMode => isDark.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() async{
    isDark.value = !isDark.value;
    await CacheHelper.saveData(key: 'isDark', value: isDark.value);
  }

  var currentLocale = const Locale('ar', 'SA').obs;

  void changeLocale(Locale locale) {
    currentLocale.value = locale;
  }

  void changeLanguage(String lang)async {
    await CacheHelper.saveData(key: 'lang', value: lang);
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
