import 'package:ar_visiting_app/app/core/models/visits/statusmodel.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/models/visits/visitmodel.dart';
import '../../../core/services/cache_helper.dart';

class VisitDetailsControllers extends GetxController {
  var isLoading = false.obs;
  var isDropdownOpen  = false.obs;
  var visitTime  = ''.obs;
  String id =Get.arguments;
  var visitData=VisitModel(
    address: '',
    addressType: 0,
    addressUrl: '',
    areaName: '',
    attendant: '',
    attendantPhone: '',
    date: '',
    from: '',
    id: 0,
    patientNums: 0,
    status: Status(value: 0, name: ''),
    to: '',
    userName: '',
    fatherName: '',
    note: '',
    servantName: ''
  ).obs;
  String lang=CacheHelper.getData(key: 'lang')??'en';

  Future<void> launchPhoneDialer(String phoneNumber) async {
    final Uri phoneUrl = Uri(scheme: 'tel', path: phoneNumber);
    try {
      await launch(phoneUrl.toString());
    } catch (e) {
      print('Could not launch phone dialer: $e');
    }
  }
  Future<void> launchGoogleLink(String googleLink) async {
    final Uri phoneUrl = Uri(scheme :'https',path:googleLink);
    try {
      await launch(phoneUrl.toString());
    } catch (e) {
      print('Could not launch phone dialer: $e');
    }
  }
  Future<bool> requestPhonePermission() async {
    PermissionStatus status = await Permission.phone.request();
    return status == PermissionStatus.granted;

  }

  void onClone(String id)async{
  }
  @override
  void onInit() async{
    super.onInit();
    await getVisitDetails();
  }
  // Fetch Visit Details from Firebase
  Future<void> getVisitDetails() async {
  }
  void onDone(){
  }
  void getTime(){
  }

  void onCanceled() {
  }
}