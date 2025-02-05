
import 'package:ar_visiting_app/app/modules/home/bindings/home_binding.dart';
import 'package:ar_visiting_app/app/modules/home/views/home_view.dart';
import 'package:ar_visiting_app/app/modules/splash/bindings/splash_binding.dart';
import 'package:ar_visiting_app/app/modules/splash/views/splash_views.dart';
import 'package:ar_visiting_app/app/modules/visit_details/blinding/visit_details_blinding.dart';
import 'package:ar_visiting_app/app/modules/visit_details/views/visit_details_views.dart';
import 'package:get/get.dart';
import '../modules/add_edit_visit/bindings/add_edit_visit_binding.dart';
import '../modules/add_edit_visit/views/add_edit_visit_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ADD_NEW_VISIT,
      page: () => const AddEditVisitView(),
      binding: AddEditVisitBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashViews(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.VISIT_DETAILS,
      page: () => const VisitDetailsViews(),
      binding: VisitDetailsBlinding(),
    ),
    GetPage(
        name: _Paths.HOME,
        page: () => const HomeView(),
        binding: HomeBinding()
    ),
  ];
}
