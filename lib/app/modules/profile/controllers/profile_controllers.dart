import 'package:ar_visiting_app/app/core/models/users/users.dart';
import 'package:ar_visiting_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../core/firebase/GetUserFirebase.dart';
import '../../../core/sharedchache/cache_helper.dart';
import '../../../core/utils/app_string.dart';
import '../../../routes/app_pages.dart';

class ProfileControllers extends GetxController {

  var id=''.obs;
  String lang=CacheHelper.getData(key: 'lang')??'en';
  Rx<bool> isLoading = false.obs;
  var name =''.obs;
  var user=Users(
    id: '',
    name: '',
    nameAr: ''
  ).obs;

  String getProfile(){
    return  lang == 'en' ? AppStringsEn.profile:AppStringsAr.profile;
  }
  String getAccount(){
    return  lang == 'en' ? AppStringsEn.account:AppStringsAr.account;
  }
  String getLanguage(){
    return  lang == 'en' ? AppStringsEn.language:AppStringsAr.language;
  }
  String getLanguageComfim(){
    return  lang == 'en' ? AppStringsEn.languageComfim:AppStringsAr.languageComfim;
  }
  String getLang(){
    return  lang == 'en' ? AppStringsEn.lang:AppStringsAr.lang;
  }
  String getEnglish(){
    return  lang == 'en' ? AppStringsEn.english:AppStringsAr.english;
  }
  String getArabic(){
    return  lang == 'en' ? AppStringsEn.arabic:AppStringsAr.arabic;
  }
  String getFQA(){
    return  lang == 'en' ? AppStringsEn.fAQ:AppStringsAr.fAQ;
  }
  String getLogout(){
    return  lang == 'en' ? AppStringsEn.logout:AppStringsAr.logout;
  }
  String getSettings(){
    return  lang == 'en' ? AppStringsEn.settings:AppStringsAr.settings;
  }
  @override
  void onInit()async {
    getUserId();
    await getUserData();
    super.onInit();
  }

  void getUserId(){
    id.value=CacheHelper.getData(key: 'user');
  }
  void changeToArabic(){
    CacheHelper.saveData(key: 'lang',value: 'ar');
    Get.offAllNamed(Routes.PROFILE);
    runApp(MyApp());
  }
  void changeToEnglish(){
    CacheHelper.saveData(key: 'lang',value: 'en');
    Get.offAllNamed(Routes.PROFILE);
    runApp(MyApp());
  }



  Future<void> getUserData() async {
    isLoading.value = true;
    try {
      Users? retrievedUser = await GetUserData.retrieveUserData(id.value);
      if (retrievedUser != null) {
        user.value = retrievedUser;

        lang =='en'? name.value=user.value.name!: name.value=user.value.nameAr!;
      } else {
      }
    } catch (e) {
      Get.snackbar('Error', 'can\'t fetch data' );
    } finally {
      isLoading.value = false;
    }
  }


  void logout(){
    CacheHelper.removeData(key: 'user');
    CacheHelper.removeData(key: 'loginDone');
    Get.offAllNamed(Routes.LOGIN);
  }
}