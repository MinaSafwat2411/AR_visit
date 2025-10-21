import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../main.dart';
import '../../../core/services/cache_helper.dart';
import '../../../data/repository/dio_helper_repository.dart';
import '../../../domain/usecase/base_use_case.dart';
import '../../../domain/usecase/base_use_case_interface.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  SplashController(this.useCase);
  var token = ''.obs;
  var reload = false.obs;
  final BaseUseCaseInterface useCase;

  @override
  void onInit() async {
    token(await CacheHelper.getData(key: 'token') ?? '');
    super.onInit();
    onNavigate();
  }


  void onNavigate() async {
    if (token.value=='') {
      Get.offNamed(Routes.LOGIN);
    } else {
      var enums =await useCase.getEnums();
      if (enums != null) {
        Get.offNamed(Routes.HOME);
      }
    }
  }
}
