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
import '../../../core/models/visits/VisitsModel.dart';
import '../../../core/models/visits/visitmodel.dart';
import '../../../core/services/cache_helper.dart';
import '../../../core/services/secure_cache_helper.dart';
import '../../../core/utils/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../../../core/models/tags/tags_model.dart';

class HomeController extends GetxController {
  var screens = <Widget>[].obs;
  var pageController = PageController();
  var visitsPageController = PageController();
  var title = <String>[].obs;
  var currentScreen = 0.obs;
  var isLoading = false.obs;
  var isLoadingInternal = false.obs;
  var mainController = MainController();
  var me = RxBool(true);
  var lastPage = RxBool(false);
  var onMeSearch = RxBool(false);
  var onAllSearch = RxBool(false);
  var token = ''.obs;
  var searchQuery = ''.obs;
  var allSearchQuery = ''.obs;
  var lang = ''.obs;
  var tags = [
    TagsModel(name: 'New',value: 1,type: null,nameAr: 'جديد',isSelected: RxBool(false)),
    TagsModel(name: 'assigned',value: null,type: 'assigned',nameAr: 'تم تعيينه',isSelected: RxBool(false)),
    TagsModel(name: 'inprogress',value: 2,type: null,nameAr: 'قيد التنفيذ',isSelected: RxBool(false)),
    TagsModel(name: 'Delayed',value: 3,type: null,nameAr: 'متأخر',isSelected: RxBool(false)),
    TagsModel(name: 'done',value: 4,type: null,nameAr: 'تم',isSelected: RxBool(false)),
    TagsModel(name: 'cancelled',value: 5,type: null,nameAr: 'تم إلغاؤه',isSelected: RxBool(false)),
  ];
  var meVisits = <DayVisits>[].obs;
  var allVisits = <DayVisits>[].obs;
  var meSearchResults = <DayVisits>[].obs;
  var archiveSearchResults = <DayVisits>[].obs;
  var allSearchResults = <DayVisits>[].obs;
  var patient = User().obs;
  var visitsArchives = <DayVisits>[].obs;
  var darkMode = RxBool(false);
  var profile =ProfileModel().obs;
  var order =<int>[].obs;
  TextEditingController searchController = TextEditingController();
  TextEditingController allSearchController = TextEditingController();
  TextEditingController archiveSearchController = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController familyId = TextEditingController();
  TextEditingController familyNumber = TextEditingController();
  TextEditingController phone = TextEditingController();

  var textDirection = TextDirection.LTR.obs;
  var id =RxInt(-1);


  void changeLanguage(String languageCode) {
    lang.value = languageCode;
    CacheHelper.saveData(key: 'lang', value: languageCode);
    var locale = Locale(languageCode);
    Get.updateLocale(locale);
    getArchivesData();
    getVisitsData();
    runApp(MyApp());
  }

  
  void logout() async {
    isLoadingInternal(true);
    mainController.logout();
    isLoadingInternal(false);
  }
  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString.replaceAll('/', '-'));
    String formattedDate = DateFormat('d-MMM').format(date);
    return formattedDate;
  }

  void onDone(int id) async {
    isLoadingInternal(true);
    mainController.onDone(id);
    getVisitsData();
  }
  Future<void> getArchivesData() async {
      isLoadingInternal(true);
      visitsArchives.value = [];  
      visitsArchives.value =await mainController.getArchivesVisits();
      isLoadingInternal(false);
  }

  void getProfile()async{
    isLoadingInternal(true);
    profile.value = await mainController.getProfile();
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
    isLoading(true);
    await mainController.addPatient(User(
        statusValue: 2,
        typeValue: 3,
        e1C1F: familyId.text,
        nR: familyNumber.text,
        email: email.text,
        phone: phone.text,
        name: name.text,
        nameAr: nameAr.text));
    isLoading(false);
  }
    void onSearchArchive(String value) {
    if (value.isEmpty||value =='') {
      archiveSearchResults.value = visitsArchives;
    } else {
      archiveSearchResults.value = visitsArchives
          .map((day) => DayVisits(
              day: day.day,
              visits: day.visits
                  .where((visit) => visit.userName!
                      .toLowerCase()
                      .contains(value.toLowerCase()))
                  .toList()))
          .where((day) => day.visits.isNotEmpty)
          .toList();
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
                  .toList()))
          .where((day) => day.visits.isNotEmpty)
          .toList();
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
                  .toList()))
          .where((day) => day.visits.isNotEmpty)
          .toList();
    }
  }

  void onCanceled(int id) async {
    Get.back(closeOverlays: true);
    isLoadingInternal(true);
    mainController.onCanceled(id);
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
        color = AppColors.orange;
      case 4:
        color = AppColors.green;
      case 5:
        color = AppColors.red;
    }
    return color;
  }

  void onClone(VisitModel visit) async {
    isLoadingInternal(true);
    var visitId = await mainController.addVisit(visit);
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
      if (tags[index].value != null) {
        query = {'status': tags[index].value};
      } else {
        query = {};
      }
    }
    meVisits.value =await mainController.getMeVisitData();
    allVisits.value = await mainController.getAllVisitData(query);
    meSearchResults.value = meVisits;
    allSearchResults.value = allVisits;
    isLoadingInternal(false);
  }

  void onBottomNavItemClicked(int index) {
    pageController.jumpToPage(index);
  }
  @override
  void update([List<Object>? ids, bool condition = true]) {
    order.value = (CacheHelper.getIntList(key: 'order')) ?? [];
    super.update(ids, condition);
    }

  @override
  void onInit() async {
    isLoading(true);
    title.value = ['My Visits','archives','reports','profile',];
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    order.value =(CacheHelper.getIntList(key: 'order'))?? [];
    screens.value = [
      const VisitsScreen(),
      const ArchiveVisitsScreen(),
      const Center(child: Text('Coming Soon'),),
      const ProfileScreen()
    ];
    getVisitsData();
    getArchivesData();
    getProfile();
    isLoading(false);
    super.onInit();
  }
}
