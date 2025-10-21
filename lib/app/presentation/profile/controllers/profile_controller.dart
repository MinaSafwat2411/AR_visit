import 'dart:ui';

import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:get/get.dart';

import '../../../data/models/profile/profile_model.dart';
import '../../../data/repository/dio_helper_repository.dart';
import '../../../domain/usecase/base_use_case.dart';
import '../../../domain/usecase/base_use_case_interface.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  ProfileController(this.useCase);
  var isLoading = false.obs;
  RxString lang=RxString('');
  var token = ''.obs;
  final BaseUseCaseInterface useCase;

  var profile = ProfileModel().obs;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  void getProfile()async{
    try{
      isLoading(true);
      await useCase.getProfile().then((value) {
        profile.value = value?? ProfileModel();
      });
      isLoading(false);
    }catch(e){
      Get.snackbar('Error', e.toString());
    }finally{
      isLoading(false);
    }
  }

  void onLogout(){
    try{
      isLoading(true);
      useCase.logout().then((value) {
        Get.offAllNamed(Routes.LOGIN);
      });
      isLoading(false);
    }catch(e){
      Get.snackbar('Error', e.toString());
    }finally{
      isLoading(false);
    }
  }

  Color getStatuses(int status){
    switch(status){
      case 1:
        return AppColors.green;
      case 2:
        return AppColors.yellow;
      case 3:
        return AppColors.red;
    }
    return AppColors.boulder;
  }

}