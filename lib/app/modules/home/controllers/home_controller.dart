import 'package:ar_visiting_app/app/core/models/profile/profile_model.dart';
import 'package:ar_visiting_app/app/modules/home/screens/archive_visits_screen.dart';
import 'package:ar_visiting_app/app/modules/home/screens/profile_screen.dart';
import 'package:ar_visiting_app/app/modules/home/screens/visits_screen.dart';
import 'package:ar_visiting_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/controller/main_controller.dart';
import '../../../core/models/login/loginmodel.dart';
import '../../../core/models/oder/order_model.dart';
import '../../../core/models/visits/VisitsModel.dart';
import '../../../core/models/visits/visitmodel.dart';
import '../../../core/services/cache_helper.dart';
import '../../../core/services/secure_cache_helper.dart';
import '../../../core/utils/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../../../core/models/tags/tags_model.dart';
import '../screens/report_screen.dart';

class HomeController extends GetxController {
  var screens = <Widget>[const VisitsScreen(), const ArchiveVisitsScreen(), const ReportScreen(), const ProfileScreen()].obs;
  var pageController = PageController();
  var visitsPageController = PageController();
  var title = <RxString>[RxString('visits'.tr),RxString('archives'.tr),RxString('reports'.tr),RxString('profile'.tr),].obs;
  var currentScreen = 0.obs;
  var isLoading = false.obs;
  var isLoadingInternal = false.obs;
  var mainController = MainController();
  var me = RxBool(true);
  var lastPage = RxBool(false);
  var onMeSearch = RxBool(false);
  var onAllSearch = RxBool(false);
  var token = Get.arguments[2] as RxString;
  var searchQuery = ''.obs;
  var allSearchQuery = ''.obs;
  var lang = Get.arguments[0] as RxString;
  var userNames = <String>[].obs;
  var userId = <int>[].obs;
  var tags = [
    TagsModel(name: 'New',value: 1,type: null,nameAr: 'جديد',isSelected: RxBool(false)),
    TagsModel(name: 'inprogress',value: 2,type: null,nameAr: 'قيد التنفيذ',isSelected: RxBool(false)),
    TagsModel(name: 'assigned',value: 3,type: 'assigned',nameAr: 'تم تعيينه',isSelected: RxBool(false)),
    TagsModel(name: 'Delayed',value: 4,type: null,nameAr: 'متأخر',isSelected: RxBool(false)),
    TagsModel(name: 'done',value: 5,type: null,nameAr: 'تم',isSelected: RxBool(false)),
    TagsModel(name: 'cancelled',value: 6,type: null,nameAr: 'تم إلغاؤه',isSelected: RxBool(false)),
  ];
  var isSubmitted = RxBool(false);
  var meVisits = <DayVisits>[].obs;
  var allVisits = <DayVisits>[].obs;
  var meSearchResults = <DayVisits>[].obs;
  var archiveSearchResults = <VisitModel>[].obs;
  var visitsReport = <VisitModel>[].obs;
  var allSearchResults = <DayVisits>[].obs;
  var patient = User().obs;
  var visitsArchives = <VisitModel>[].obs;
  var isDark = Get.arguments[1] as RxBool;
  var profile =ProfileModel().obs;
  var order =<int>[];
  var orderVisits =<VisitModel>[].obs;
  TextEditingController searchController = TextEditingController();
  TextEditingController allSearchController = TextEditingController();
  TextEditingController archiveSearchController = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController familyId = TextEditingController();
  TextEditingController familyNumber = TextEditingController();
  TextEditingController phone = TextEditingController();
  var id =RxInt(-1);

  void changeVisitOrder()async{
    await mainController.orderVisit(token.value,lang.value,OrderModel(ids: order));
  }
  void changeLanguage(String languageCode) async{
    lang.value = languageCode;
    CacheHelper.saveData(key: 'lang', value: languageCode);
    var locale = Locale(languageCode);
    Get.updateLocale(locale);
    title.value = [RxString('visits'.tr),RxString('archives'.tr),RxString('reports'.tr),RxString('profile'.tr),].obs;
    getVisitsData();
    getArchivesData();
    getProfile();
    runApp(MyApp(lang: lang.value,isDark:  isDark.value,));
  }
  void changeTheme()async{
    await CacheHelper.saveData(key: 'isDark', value: isDark.value);
    runApp(MyApp(lang: lang.value,isDark:  isDark.value,));
  }

  
  void logout() async {
    isLoadingInternal(true);
    mainController.logout(token.value,lang.value);
    isLoadingInternal(false);
  }
  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString.replaceAll('/', '-'));
    String formattedDate = DateFormat('d-MMM', lang.value == 'ar' ? 'ar' : 'en').format(date);
    return formattedDate;
  }

  void onDone(int id) async {
    isLoadingInternal(true);
    mainController.onDone(token.value,lang.value,id);
    getVisitsData();
  }
  Future<void> getArchivesData() async {
      isLoadingInternal(true);
      visitsArchives.value = [];  
      visitsArchives.value =await mainController.getArchivesVisits(lang.value,token.value);
      archiveSearchResults.value= visitsArchives;
      isLoadingInternal(false);
  }

  Future<void> getFatherServantData() async {
    try {
      var userData = await mainController.getUserData(lang.value,token.value);
      for (var element in userData) {
        userNames.add(element.name!);
        userId.add(element.id!);
      }
    }catch(e){
      Get.snackbar("Error", "Failed to retrieve area details");
    }
  }

  Future<void> onUserSelected(String user)async{
    isLoadingInternal(true);
    visitsReport.value = await mainController.getReport(token.value,lang.value,userId[userNames.indexOf(user)]);
    isLoadingInternal(false);
  }

  void getProfile()async{
    isLoadingInternal(true);
    profile.value = await mainController.getProfile(lang.value,token.value);
    isLoadingInternal(false);
  }

  void getAllVisits() async {
    searchController.text = '';
    visitsPageController.jumpToPage(1);
    me.value = false;
  }

  void getMyVisits() async {
    searchController.text = '';
    visitsPageController.jumpToPage(0);
    me.value = true;
  }

  void addPatient() async {
    isSubmitted(true);
    await mainController.addPatient(token.value,lang.value,User(
        statusValue: 2,
        e1C1F: familyId.text,
        nR: familyNumber.text,
        email: email.text,
        phone: phone.text,
        name: name.text,
        nameAr: nameAr.text));
        isSubmitted(false);
  }
    void onSearchArchive(String value) {
    if (value.isEmpty||value =='') {
      archiveSearchResults.value = visitsArchives;
    } else {
      archiveSearchResults.value = visitsArchives.where((value)=> value.userName!.toLowerCase().contains(value.userName!.toLowerCase())).toList();
    }
  }

  void onSearchMe(String value) {
    if (value.isEmpty||value =='') {
      meSearchResults.value = meVisits;
    } else {
      meSearchResults.value = meVisits
          .map((day) => DayVisits(
              day: day.day,
              visits: day.visits
                  .where((visit) => visit.userName!
                      .toLowerCase()
                      .contains(value.toLowerCase()))
                  .toList().obs))
          .where((day) => day.visits.isNotEmpty)
          .toList().obs;
    }
  }
    void onSearchAll(String value) {
    if (value.isEmpty||value =='') {
      allSearchResults.value = allVisits;
    } else  {
      allSearchResults.value = allVisits
          .map((day) => DayVisits(
              day: day.day,
              visits: day.visits
                  .where((visit) => visit.userName!
                      .toLowerCase()
                      .contains(value.toLowerCase()))
                  .toList().obs))
          .where((day) => day.visits.isNotEmpty)
          .toList();
    }
  }

  void onCanceled(int id) async {
    Get.back(closeOverlays: true);
    isLoadingInternal(true);
    mainController.onCanceled(token.value,lang.value,id);
    getVisitsData();
  }

  Color statusColor(int status) {
    var color = const Color(0xffffffff);
    switch (status) {
      case 1:
        color = AppColors.violetPurple;
      case 2:
        color = AppColors.blue;
      case 3:
        color = AppColors.trinidadColor;
      case 4:
        color = AppColors.orange;
      case 5:
        color = AppColors.green;
        case 6:
          color=AppColors.red;
    }
    return color;
  }

  void onClone(VisitModel visit) async {
    isLoadingInternal(true);
    var visitId = await mainController.addVisit(token.value,lang.value,visit);
    isLoadingInternal(false);
    Get.toNamed(Routes.EDIT_VISIT, arguments: visitId);
  }

  void onTagsChanged(int index) {
    if (tags[index].isSelected.value) {
      for (int i = 0; i < tags.length; i++) {
        tags[i].isSelected.value = false;
      }
    } else {
      for (int i = 0; i < tags.length; i++) {
        tags[i].isSelected.value = false;
      }
      tags[index].isSelected.value = true;
    }
    allSearchController.text = '';
    getVisitsData();
  }

  Future<void> getVisitsData() async {
    int index = tags.indexWhere((element) => element.isSelected.value == true);
    isLoadingInternal(true);
    Map<String, dynamic> query = {};
    if (index != -1) {
        query = {'status': tags[index].value};
    }
    meVisits.value =await mainController.getMeVisitData(lang.value,token.value);
    allVisits.value = await mainController.getAllVisitData(lang.value,token.value,query);
    meSearchResults.value = meVisits;
    meSearchResults.value = meVisits;
    allSearchResults.value = allVisits;
    isLoadingInternal(false);
  }

  void onBottomNavItemClicked(int index) {
    pageController.jumpToPage(index);
  }

  @override
  void onInit() async {
    isLoading(true);
    getVisitsData();
    getArchivesData();
    getProfile();
    getFatherServantData();
    isLoading(false);
    super.onInit();
  }
}
