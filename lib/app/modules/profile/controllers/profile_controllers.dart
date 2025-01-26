import 'package:ar_visiting_app/app/core/models/api_response/api_response.dart';
import 'package:ar_visiting_app/app/core/models/login/loginmodel.dart';
import 'package:ar_visiting_app/app/core/services/dio_helper.dart';
import 'package:ar_visiting_app/app/core/utils/backend_endpoint.dart';
import 'package:ar_visiting_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/services/cache_helper.dart';
import '../../../core/services/secure_cache_helper.dart';
import '../../../routes/app_pages.dart';

class ProfileControllers extends GetxController {
  Rx<bool> isLoading = false.obs;
  var lang = ''.obs;
  var textDirection = TextDirection.ltr.obs;
  var token = ''.obs;
  var user = User().obs;
  var id =RxInt(-1);

  @override
  void onInit() async {
    token.value = (await SecureCacheHelper.getData(key: 'token'))!;
    lang.value = (await CacheHelper.getData(key: 'lang'))!;
    id.value= int.parse((await SecureCacheHelper.getData(key: 'user'))!);
    getUserData();
    super.onInit();
  }

  void changeLanguage(String languageCode) {
    lang.value = languageCode;
    CacheHelper.saveData(key: 'lang', value: languageCode);
    var locale = Locale(languageCode);
    Get.updateLocale(locale);
    runApp(MyApp());
  }

  void getUserData() async {
    try {
      isLoading(true);
      var response = await DioHelper.getData(
          url: '${BackendEndpoint.users}/${id.value.toString()}', lang: lang.value, token: token.value);
      var apiResponse = ApiResponse<User>.fromJson(
          response.data, (json) => User.fromJson(json as Map<String, dynamic>));
      user.value = apiResponse.data!;
    } catch (e) {
      Get.snackbar('Error', 'check your connection');
    } finally {
      isLoading(false);
    }
  }

  void logout() async {
    try {
      await DioHelper.postData(
        url: BackendEndpoint.logout,
        token: token.value,
      );
      Get.snackbar('Logout', 'logout successfully');
      SecureCacheHelper.removeData(key: 'token');
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar('Error', 'check your connection');
    }
  }
}
