import 'package:ar_visiting_app/app/core/controller/main_controller.dart';
import 'package:ar_visiting_app/app/core/models/api_response/api_response.dart';
import 'package:ar_visiting_app/app/core/services/dio_helper.dart';
import 'package:ar_visiting_app/app/core/services/secure_cache_helper.dart';
import 'package:ar_visiting_app/app/core/utils/backend_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/models/visits/visitmodel.dart';
import '../../../core/services/cache_helper.dart';

class VisitDetailsControllers extends GetxController {
  var token = ''.obs;
  var isLoading = false.obs;
  var isDropdownOpen = false.obs;
  var visitTime = ''.obs;
  var visit = VisitModel().obs;
  int visitId = Get.arguments;
  var lang = ''.obs;
  var mainController = MainController();

  Future<void> launchPhoneDialer(String phoneNumber) async {
    final Uri phoneUrl = Uri(scheme: 'tel', path: phoneNumber);
    try {
      // ignore: deprecated_member_use
      await launch(phoneUrl.toString());
    } catch (e) {
      Get.snackbar('Error', 'Could not launch phone dialer');
    }
  }

  Future<void> launchGoogleLink(String googleLink) async {
    final Uri phoneUrl = Uri(scheme: 'https', path: googleLink);
    try {
      // ignore: deprecated_member_use
      await launch(phoneUrl.toString());
    } catch (e) {
      Get.snackbar('Error', 'Could not launch Google link');
    }
  }

  Future<bool> requestPhonePermission() async {
    PermissionStatus status = await Permission.phone.request();
    return status == PermissionStatus.granted;
  }

  void getVisitData() async {
    isLoading(true);
    try {
      final response = await DioHelper.getData(
          url: '${BackendEndpoint.visits}/${visitId.toString()}',
          token: token.value,
          lang: lang.value);
      final apiResponse = ApiResponse<VisitModel>.fromJson(response.data,
          (json) => VisitModel.fromJson(json as Map<String, dynamic>));
      visit.value = apiResponse.data!;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load visit data');
    } finally {
      isLoading(false);
    }
  }

  String getAddressType(int address) {
    String s = '';
    switch (address) {
      case 1:
        s = 'home';
      case 2:
        s = 'hospital';
      case 3:
        s = 'dar';
      case 4:
        s = 'others';
    }
    return s;
  }

  void onClone(int id) async {}
  @override
  void onInit() async {
    token.value = (await SecureCacheHelper.getData(key: 'token'))!;
    lang.value = (await CacheHelper.getData(key: 'lang'))!;
    getVisitData();
    super.onInit();
  }

  void onDone() async {
    Get.back(closeOverlays: true);
    isLoading(true);
    await mainController.onDone(visitId);
    isLoading(false);
  }

  

  void onCanceled() async {
    Get.back(closeOverlays: true);
    isLoading(true);
    await mainController.onCanceled(visitId);
    isLoading(false);
  }

  void onInprogress() async {
    Get.back(closeOverlays: true);
    isLoading(true);
    await mainController.onInProgress(visitId);
    isLoading(false);
  }

  void onDelay() async {
    Get.back(closeOverlays: true);
    isLoading(true);
    await mainController.onDeylayed(visitId);
    isLoading(false);
  }
}
