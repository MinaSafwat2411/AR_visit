import 'package:ar_visiting_app/app/core/models/users/users.dart';
import 'package:ar_visiting_app/app/core/services/dio_helper.dart';
import 'package:ar_visiting_app/app/core/utils/backend_endpoint.dart';
import 'package:ar_visiting_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../core/firebase/GetUserFirebase.dart';
import '../../../core/services/cache_helper.dart';
import '../../../core/services/secure_cache_helper.dart';
import '../../../routes/app_pages.dart';

class ProfileControllers extends GetxController {

  var id=''.obs;
  Rx<bool> isLoading = false.obs;
  var name =''.obs;
  var lang = CacheHelper.getData(key: 'lang') ?? 'en';
  var textDirection = TextDirection.ltr.obs;
  var token = ''.obs;
  var user=Users(
    id: '',
    name: '',
    nameAr: ''
  ).obs;

  @override
  void onInit()async {
    token.value=(await SecureCacheHelper.getData(key: 'token'))!;
    getUserId();
    await getUserData();
    super.onInit();
  }

  void getUserId(){
    id.value=CacheHelper.getData(key: 'user');
  }
  void changeLanguage(String languageCode) {
    lang = languageCode;
    CacheHelper.saveData(key: 'lang',value: languageCode);
    var locale = Locale(languageCode);
    Get.updateLocale(locale);
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


  void logout()async{
    try{
      await DioHelper.postData(url: BackendEndpoint.logout,token:  token.value,);
      Get.snackbar('Logout', 'logout successfully');
      SecureCacheHelper.removeData(key: 'token');
      Get.offAllNamed(Routes.LOGIN);
    }catch(e){
      Get.snackbar('Error', 'check your connection');
    }
  }
}