import 'package:ar_visiting_app/app/core/controller/main_controller.dart';
import 'package:ar_visiting_app/app/core/models/login/loginmodel.dart';
import 'package:ar_visiting_app/app/core/services/secure_cache_helper.dart';
import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:ar_visiting_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
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
  var bottomSheetIsOpened =RxBool(false);
  var father = <User>[].obs;
  var fatherNames =<String>[].obs;
  var fatherId =<int>[].obs;
  var servant = <User>[].obs;
  var servantNames =<String>[].obs;
  var servantId =<int>[].obs;





  Future<void> getServantNames() async {
    isLoading.value = true;
    servant.value = (await mainController.getUserList(2));
    for (var servant in servant) {
      servantNames.add(servant.name!);
      servantId.add(servant.id!);
    }
  }

  onServantSelected(int index)async{
    isLoading(true);
    await mainController.assignServent(visitId, servantId[index]);
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
      visit.value = await mainController.getVisitData(visitId);
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




  Future<void> getFatherNames() async {
    isLoading.value = true;
    father.value = (await mainController.getUserList(1));
    for (var father in father) {
      fatherNames.add(father.name!);
      fatherId.add(father.id!);
    }
  }

  onFatherSelected(int index)async{
    isLoading(true);
    await mainController.assignFather(visitId, fatherId[index]);
    isLoading(false);
    getVisitData();  
}


  void onClone(int id) async {
    isLoading(true);
    var visitId = await mainController.addVisit(visit.value);
    isLoading(false);
    Get.toNamed(Routes.EDIT_VISIT, arguments: visitId);
  }

  @override
  void onInit() async {
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    getVisitData();
    getFatherNames();
    getServantNames();
    super.onInit();
  }

  void onDone() async {
    Get.back(closeOverlays: true);
    isLoading(true);
    await mainController.onDone(visitId);
    visit.value=await mainController.getVisitData(visitId);
    isLoading(false);
  }

  

  void onCanceled() async {
    Get.back(closeOverlays: true);
    isLoading(true);
    await mainController.onCanceled(visitId);
    visit.value=await mainController.getVisitData(visitId);
    isLoading(false);
  }

  void onInProgress() async {
    Get.back(closeOverlays: true);
    isLoading(true);
    await mainController.onInProgress(visitId);
    visit.value =await mainController.getVisitData(visitId);
    isLoading(false);
  }

  void onDelay() async {
    Get.back(closeOverlays: true);
    isLoading(true);
    await mainController.onDeylayed(visitId);
    visit.value=await mainController.getVisitData(visitId);
    isLoading(false);
  }
}
