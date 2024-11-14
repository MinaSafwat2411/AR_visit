import 'package:ar_visiting_app/app/core/utils/app_string.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/core/firbaseoptions/firebase_options.dart';
import 'app/core/sharedchache/cache_helper.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await initializeDateFormatting('ar','en');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': AppStringsEn().keys,
    'ar': AppStringsAr().keys,
  };
}

class MyApp extends StatelessWidget {
   MyApp({
    super.key,
  });
  String lang = CacheHelper.getData(key: 'lang') ?? 'en';
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
