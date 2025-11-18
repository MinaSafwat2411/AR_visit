import 'package:ar_visiting_app/app/core/utils/app_string.dart';
import 'package:ar_visiting_app/app/core/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/app_module.dart';
import 'app/appcontroller/app_controller.dart';
import 'app/core/services/cache_helper.dart';
import 'app/domain/usecase/base_use_case_interface.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await CacheHelper.init();
  await initializeDateFormatting('ar','en');
  Get.put(AppController(getIt<BaseUseCaseInterface>()));
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
  final AppController appController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() =>GetMaterialApp(
      theme: AppThemes.light,
      darkTheme:  AppThemes.dark,
      themeMode: appController.isDark.value? ThemeMode.dark: ThemeMode.light,
      translations: MyTranslations(),
      debugShowCheckedModeBanner: false,
      locale:  appController.currentLocale.value,
      textDirection: appController.lang.value =='en' ? TextDirection.ltr:TextDirection.rtl,
      title: "AR Visit",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
    );
  }
}
