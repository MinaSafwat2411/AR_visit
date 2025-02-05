import 'package:ar_visiting_app/app/core/utils/app_string.dart';
import 'package:ar_visiting_app/app/core/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/core/services/cache_helper.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await initializeDateFormatting('ar','en');
  bool isDark = await CacheHelper.getData(key: 'isDark') ?? false;
  String lang = await CacheHelper.getData(key: 'lang') ?? 'en';

  runApp(MyApp(isDark: isDark,lang: lang));
}
class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': AppStringsEn().keys,
    'ar': AppStringsAr().keys,
  };
}

class MyApp extends StatelessWidget {
   const MyApp({
    super.key,
    required this.isDark,
    required this.lang
  });
  final bool isDark;
  final String lang;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      darkTheme: isDark ? darkTheme:lightTheme,
      translations: MyTranslations(),
      debugShowCheckedModeBanner: false,
      locale:  Locale(lang),
      textDirection: lang =='en' ? TextDirection.ltr:TextDirection.rtl,
      title: "AR Visit",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
