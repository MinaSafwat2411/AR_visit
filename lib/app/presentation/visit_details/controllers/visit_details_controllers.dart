import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/models/login/loginmodel.dart';
import '../../../data/models/visits/visitmodel.dart';
import '../../../data/repository/dio_helper_repository.dart';
import '../../../domain/usecase/base_use_case.dart';
import '../../../domain/usecase/base_use_case_interface.dart';

class VisitDetailsControllers extends GetxController {
  VisitDetailsControllers(this.useCase);
  var isLoading = false.obs;
  var visit = VisitModel().obs;
  var visitId = RxInt(-1);
  var father = <DropDown>[].obs;
  var fatherNames = <String>[].obs;
  var fatherNamesAr = <String>[].obs;
  var fatherId = <int>[].obs;
  var servant = <DropDown>[].obs;
  var servantNames = <String>[].obs;
  var servantNamesAr = <String>[].obs;
  var servantId = <int>[].obs;
  final BaseUseCaseInterface useCase;

  Future<void> getFatherServantNames() async {
    isLoading(true);
    servant(await useCase.getFatherServantData(2));
    for (var servant in servant) {
      servantNames.add(servant.name?.name ?? '');
      servantNamesAr.add(servant.name?.nameAr ?? '');
      servantId.add(servant.id ?? -1);
    }
    father(await useCase.getFatherServantData(1));
    for (var father in father) {
      fatherNames.add(father.name?.name ?? '');
      fatherNamesAr.add(father.name?.nameAr ?? '');
      fatherId.add(father.id ?? -1);
    }
    isLoading(false);
  }

  onServantSelected(int index) async {
    try {
      isLoading(true);
      await useCase.assignServant(visitId.value, servantId[index]);
      await getVisitData();
    }catch(e){
      Get.snackbar('Error', 'Could not assign servant');
    }finally{
      isLoading(false);
    }
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

  Future<void> getVisitData() async {
    try {
      isLoading(true);
      visit(await useCase.getVisitData(visitId.value));
    } catch (e) {
      Get.snackbar('Error', 'Could not get visit data');
    } finally {
      isLoading(false);
    }
  }

  Color statusColor(int status) {
    var color = const Color(0xffffffff);
    switch (status) {
      case 1:
        color = AppColors.deepBrown;
      case 2 :
        color =AppColors.charcoalGray;
      case 3:
        color = AppColors.blue;
      case 4:
        color = AppColors.charcoalGray;
      case 5:
        color = AppColors.green;
      case 6:
        color = AppColors.red;
    }
    return color;
  }

  String getAddressType(int address, String lang) {
    String s = '';
    switch (address) {
      case 1:
        if (lang == 'ar') {
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
    try {
      isLoading(true);
      await useCase.assignFather(visitId.value, fatherId[index]);
      await getVisitData();
    } catch (e) {
      Get.snackbar('Error', 'Could not assign father');
    } finally {
      isLoading(false);
    }
  }

  void onDone() async {
    isLoading(true);
    visit(await useCase.onDone(visitId.value));
    isLoading(false);
  }

  void onCanceled() async {
    isLoading(true);
    visit(await useCase.onCanceled(visitId.value));
    isLoading(false);
  }

  void onInProgress() async {
    isLoading(true);
    visit(await useCase.onInProgress(visitId.value));
    isLoading(false);
  }

  void onDelay() async {
    isLoading(true);
    visit(await useCase.onDelayed(visitId.value));
    isLoading(false);
  }

  @override
  void onInit() async {
    visit.value = Get.arguments;
    visitId.value = visit.value.id ?? -1;
    getFatherServantNames();
    super.onInit();
  }
}
