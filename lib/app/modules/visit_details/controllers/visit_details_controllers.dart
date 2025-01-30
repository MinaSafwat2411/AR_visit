import 'package:ar_visiting_app/app/core/controller/main_controller.dart';
import 'package:ar_visiting_app/app/core/models/login/loginmodel.dart';
import 'package:ar_visiting_app/app/core/services/secure_cache_helper.dart';
import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:ar_visiting_app/app/routes/app_pages.dart';
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
  var lang = ''.obs;
  var visitId = RxInt(-1);
  var mainController = MainController();
  var bottomSheetIsOpened = RxBool(false);
  var father = <User>[].obs;
  var fatherNames = <String>[].obs;
  var fatherId = <int>[].obs;
  var servant = <User>[].obs;
  var servantNames = <String>[].obs;
  var servantId = <int>[].obs;
  var isDark = RxBool(false);

  Future<void> getFatherServantNames() async {
    isLoading(true);
    servant.value = (await mainController.getUserList(2));
    for (var servant in servant) {
      servantNames.add(servant.name!);
      servantId.add(servant.id!);
    }
    father.value = (await mainController.getUserList(1));
    for (var father in father) {
      fatherNames.add(father.name!);
      fatherId.add(father.id!);
    }
    isLoading(false);
  }

  onServantSelected(int index) async {
    isLoading(true);
    await mainController.assignServent(visitId.value, servantId[index]);
    isLoading(false);
    getVisitData();
  }

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
    visit.value = await mainController.getVisitData(visitId.value);
    isLoading(false);
  }

  Color statusColor(int status) {
    var color = const Color(0xffffffff);
    switch (status) {
      case 1:
        color = AppColors.violetPurple;
      case 2:
        color = AppColors.blue;
      case 3:
        color = AppColors.orange;
      case 4:
        color = AppColors.green;
      case 5:
        color = AppColors.red;
    }
    return color;
  }

  String getAddressType(int address) {
    String s = '';
    switch (address) {
      case 1:
        if (lang.value == 'ar') {
          switch (address) {
            case 1:
              s = 'المنزل';
              break;
            case 2:
              s = 'المستشفى';
              break;
            case 3:
              s = 'دار';
              break;
            case 4:
              s = 'أخرى';
              break;
          }
        } else {
          switch (address) {
            case 1:
              s = 'Home';
              break;
            case 2:
              s = 'Hospital';
              break;
            case 3:
              s = 'House';
              break;
            case 4:
              s = 'Other';
              break;
          }
        }
        return s;
    }
    return s;
  }

  onFatherSelected(int index) async {
    isLoading(true);
    await mainController.assignFather(visitId.value, fatherId[index]);
    isLoading(false);
    getVisitData();
  }

  void onClone() async {
    isLoading(true);
    var id = await mainController.addVisit(visit.value);
    isLoading(false);
    Get.toNamed(Routes.EDIT_VISIT, arguments: id);
  }

  void onDone() async {
    Get.back(closeOverlays: true);
    isLoading(true);
    await mainController.onDone(visitId.value);
    visit.value = await mainController.getVisitData(visitId.value);
    isLoading(false);
  }

  void onCanceled() async {
    Get.back(closeOverlays: true);
    isLoading(true);
    await mainController.onCanceled(visitId.value);
    visit.value = await mainController.getVisitData(visitId.value);
    isLoading(false);
  }

  void onInProgress() async {
    Get.back(closeOverlays: true);
    isLoading(true);
    await mainController.onInProgress(visitId.value);
    visit.value = await mainController.getVisitData(visitId.value);
    isLoading(false);
  }

  void onDelay() async {
    Get.back(closeOverlays: true);
    isLoading(true);
    await mainController.onDeylayed(visitId.value);
    visit.value = await mainController.getVisitData(visitId.value);
    isLoading(false);
  }

  @override
  void onInit() async {
    token.value = (await SecureCacheHelper.getData(key: 'token')) ?? '';
    lang.value = (await CacheHelper.getData(key: 'lang')) ?? 'en';
    isDark.value = (await CacheHelper.getData(key: 'isDark')) ?? false;
    visit.value = Get.arguments;
    visitId.value = visit.value.id ?? -1;
    getFatherServantNames();
    super.onInit();
  }
}
