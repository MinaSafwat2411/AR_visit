import 'package:get/get.dart';
import '../presentation/add_edit_visit/bindings/add_edit_visit_binding.dart';
import '../presentation/add_edit_visit/views/add_edit_visit_view.dart';
import '../presentation/home/bindings/home_binding.dart';
import '../presentation/home/views/home_view.dart';
import '../presentation/login/bindings/login_binding.dart';
import '../presentation/login/views/login_view.dart';
import '../presentation/profile/bindings/profile_binding.dart';
import '../presentation/profile/views/profile_view.dart';
import '../presentation/register/bindings/register_blinding.dart';
import '../presentation/register/views/register_view.dart';
import '../presentation/splash/bindings/splash_binding.dart';
import '../presentation/splash/views/splash_views.dart';
import '../presentation/visit_details/blinding/visit_details_blinding.dart';
import '../presentation/visit_details/views/visit_details_views.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ADD_NEW_VISIT,
      page: () =>  AddEditVisitView(),
      binding: AddEditVisitBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashViews(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.VISIT_DETAILS,
      page: () => VisitDetailsViews(),
      binding: VisitDetailsBlinding(),
    ),
    GetPage(
        name: _Paths.HOME,
        page: () => HomeView(),
        binding: HomeBinding()),
    GetPage(
        name: _Paths.REGISTER,
        page: () => const RegisterView(),
        binding: RegisterBlinding()),
    GetPage(
        name: _Paths.PROFILE,
        page: () =>  ProfileView(),
        binding: ProfileBinding())
  ];
}
