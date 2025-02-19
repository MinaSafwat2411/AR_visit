import 'package:ar_visiting_app/app/core/controller/main_controller.dart';
import 'package:ar_visiting_app/app/core/models/login/loginmodel.dart';
import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/models/visits/visitmodel.dart';

class VisitDetailsControllers extends GetxController {
  var token = ''.obs;
  var isLoading = false.obs;
  var visit = VisitModel().obs;
  var lang = ''.obs;
  var visitId = RxInt(-1);
  var mainController = MainController();
  var father = <DropDown>[].obs;
  var fatherNames = <String>[].obs;
  var fatherId = <int>[].obs;
  var servant = <DropDown>[].obs;
  var servantNames = <String>[].obs;
  var servantId = <int>[].obs;
  var isDark = RxBool(false);

  Future<void> getFatherServantNames() async {
    isLoading(true);
    servant.value = (await mainController.getFatherServantData(lang.value,token.value,2));
    for (var servant in servant) {
      if (lang.value == 'en') {
        servantNames.add(servant.name?.name??'');
      } else {
        servantNames.add(servant.name?.nameAr??'');
      }
      servantId.add(servant.id??-1);
    }
    father.value = (await mainController.getFatherServantData(lang.value,token.value,1));
    for (var father in father) {
      if (lang.value == 'en') {
        fatherNames.add(father.name?.name??'');
      } else {
        fatherNames.add(father.name?.nameAr??'');
      }
      fatherId.add(father.id??-1);
    }
    isLoading(false);
  }

  onServantSelected(int index) async {
    isLoading(true);
    await mainController.assignServant(lang.value,token.value,visitId.value, servantId[index]);
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
    visit.value = await mainController.getVisitData(lang.value,token.value,visitId.value);
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
    await mainController.assignFather(lang.value,token.value,visitId.value, fatherId[index]);
    isLoading(false);
    getVisitData();
  }


  void onDone() async {
    Get.back(closeOverlays: true);
    isLoading(true);
    await mainController.onDone(lang.value,token.value,visitId.value);
    visit.value = await mainController.getVisitData(lang.value,token.value,visitId.value);
    isLoading(false);
  }

  void onCanceled() async {
    Get.back(closeOverlays: true);
    isLoading(true);
    await mainController.onCanceled(lang.value,token.value,visitId.value);
    visit.value = await mainController.getVisitData(lang.value,token.value,visitId.value);
    isLoading(false);
  }

  void onInProgress() async {
    Get.back(closeOverlays: true);
    isLoading(true);
    await mainController.onInProgress(lang.value,token.value,visitId.value);
    visit.value = await mainController.getVisitData(lang.value,token.value,visitId.value);
    isLoading(false);
  }

  void onDelay() async {
    Get.back(closeOverlays: true);
    isLoading(true);
    await mainController.onDelayed(lang.value,token.value,visitId.value);
    visit.value = await mainController.getVisitData(lang.value,token.value,visitId.value);
    isLoading(false);
  }

  @override
  void onInit() async {
    lang.value = Get.arguments[0];
    isDark.value = Get.arguments[1];
    token.value = Get.arguments[2];
    visit.value = Get.arguments[3];
    visitId.value = visit.value.id ?? -1;
    getFatherServantNames();
    super.onInit();
  }
}
