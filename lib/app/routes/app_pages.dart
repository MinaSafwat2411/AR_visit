import 'package:get/get.dart';

import '../modules/add_new_visit/bindings/add_new_visit_binding.dart';
import '../modules/add_new_visit/views/add_new_visit_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/visits/bindings/visits_binding.dart';
import '../modules/visits/views/visits_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ADD_NEW_VISIT,
      page: () => const AddNewVisitView(),
      binding: AddNewVisitBinding(),
    ),
    GetPage(
      name: _Paths.VISITS,
      page: () =>  VisitsView(),
      binding: VisitsBinding(),
    ),
  ];
}
