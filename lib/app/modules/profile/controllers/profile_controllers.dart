import 'package:ar_visiting_app/app/core/models/users/users.dart';
import 'package:ar_visiting_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../core/firebase/GetUserFirebase.dart';
import '../../../core/sharedchache/cache_helper.dart';
import '../../../routes/app_pages.dart';

class ProfileControllers extends GetxController {

  var id=''.obs;
  String lang=CacheHelper.getData(key: 'lang')??'en';
  Rx<bool> isLoading = false.obs;
  var user=Users(
    id: '',
    name: ''
  ).obs;

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
    runApp(MyApp());
  }
  void changeToEnglish(){
    CacheHelper.saveData(key: 'lang',value: 'en');
    runApp(MyApp());
  }



  Future<void> getUserData() async {
    isLoading.value = true;
    try {
      Users? retrievedUser = await GetUserData.retrieveUserData(id.value);
      if (retrievedUser != null) {
        user.value = retrievedUser;
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