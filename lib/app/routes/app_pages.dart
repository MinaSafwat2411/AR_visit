import 'package:ar_visiting_app/app/modules/all_visits/views/all_visits_view.dart';
import 'package:ar_visiting_app/app/modules/assign_father_visit/bindings/assign_father_visit_binding.dart';
import 'package:ar_visiting_app/app/modules/assign_father_visit/views/assign_father_visit_view.dart';
import 'package:ar_visiting_app/app/modules/assign_servant_visit/views/assign_servant_visit_view.dart';
import 'package:ar_visiting_app/app/modules/edit_visit/bindings/edit_visit_binding.dart';
import 'package:ar_visiting_app/app/modules/edit_visit/views/edit_visit_view.dart';
import 'package:ar_visiting_app/app/modules/profile/bindings/profile_bindings.dart';
import 'package:ar_visiting_app/app/modules/profile/views/profile_views.dart';
import 'package:ar_visiting_app/app/modules/splash/bindings/splash_binding.dart';
import 'package:ar_visiting_app/app/modules/splash/views/splash_views.dart';
import 'package:ar_visiting_app/app/modules/visit_details/blinding/visit_details_blinding.dart';
import 'package:ar_visiting_app/app/modules/visit_details/views/visit_details_views.dart';
import 'package:get/get.dart';

import '../modules/add_new_visit/bindings/add_new_visit_binding.dart';
import '../modules/add_new_visit/views/add_new_visit_view.dart';
import '../modules/all_visits/bindings/all_visits_binding.dart';
import '../modules/assign_servant_visit/bindings/assign_servant_visit_binding.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/visits/bindings/visits_binding.dart';
import '../modules/visits/views/visits_view.dart';

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
      page: () => const AddNewVisitView(),
      binding: AddNewVisitBinding(),
    ),
    GetPage(
      name: _Paths.VISITS,
      page: () =>  const VisitsView(),
      binding: VisitsBinding(),
    ),
    GetPage(
      name: _Paths.ALLVISITS,
      page: () =>  const AllVisitsView(),
      binding: AllVisitsBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () =>  const SplashViews(),
      binding: SplashBinding(),
    ),
    GetPage(
        name: _Paths.VISIT_DETAILS,
        page: () => const VisitDetailsViews(),
        binding: VisitDetailsBlinding(),
    ),
    GetPage(
      name: _Paths.EDIT_VISIT,
      page: () => const EditVisitView(),
      binding: EditVisitBinding(),
    )    ,
    GetPage(
      name: _Paths.ASSIN_Father_VISIT,
      page: () => const AssignFatherVisitView(),
      binding: AssignFatherVisitBinding(),
    ),
    GetPage(
      name: _Paths.ASSIN_SERVANT_VISIT,
      page: () => const AssignServantVisitView(),
      binding: AssignServantVisitBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileViews(),
      binding: ProfileBinding(),
    )
  ];
}
