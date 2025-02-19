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
import '../../../core/utils/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../../../core/models/tags/tags_model.dart';
import '../screens/report_screen.dart';
import 'package:collection/collection.dart';

class HomeController extends GetxController {
  var screens = <Widget>[
    const VisitsScreen(),
    const ArchiveVisitsScreen(),
    const ReportScreen(),
    const ProfileScreen()
  ].obs;
  var pageController = PageController();
  var visitsPageController = PageController();
  var title = <RxString>[
    RxString('visits'.tr),
    RxString('archives'.tr),
    RxString('reports'.tr),
    RxString('profile'.tr),
  ].obs;
  var currentScreen = 0.obs;
  var isLoading = false.obs;
  var isLoadingInternal = false.obs;
  var mainController = MainController();
  var me = RxBool(true);
  var lastPageAll = RxBool(false);
  var lastPageMe = RxBool(false);
  var lastPageArchive = RxBool(false);
  var lastPageReports = RxBool(false);
  var token = ''.obs;
  var lang = ''.obs;
  var userNames = <String>[].obs;
  var userId = <int>[].obs;
  var tags = [
    TagsModel(
        name: 'New',
        value: 1,
        type: null,
        nameAr: 'جديد',
        isSelected: RxBool(false)),
    TagsModel(
        name: 'inprogress',
        value: 2,
        type: null,
        nameAr: 'قيد التنفيذ',
        isSelected: RxBool(false)),
    TagsModel(
        name: 'assigned',
        value: 3,
        type: 'assigned',
        nameAr: 'تم تعيينه',
        isSelected: RxBool(false)),
    TagsModel(
        name: 'Delayed',
        value: 4,
        type: null,
        nameAr: 'متأخر',
        isSelected: RxBool(false)),
    TagsModel(
        name: 'done',
        value: 5,
        type: null,
        nameAr: 'تم',
        isSelected: RxBool(false)),
    TagsModel(
        name: 'cancelled',
        value: 6,
        type: null,
        nameAr: 'تم إلغاؤه',
        isSelected: RxBool(false)),
  ];
  var isSubmitted = RxBool(false);
  var myVisitsGrouped = <DayVisits>[].obs;
  var allVisitsGrouped = <DayVisits>[].obs;
  var visitsReport = <VisitModel>[].obs;
  var patient = User().obs;
  var visitsArchives = <VisitModel>[].obs;
  var isDark = RxBool(false);
  var profile = ProfileModel().obs;
  var order = <int>[];
  var orderVisits = <VisitModel>[].obs;
  var myVisits = <VisitModel>[].obs;
  var archiveVisits = <VisitModel>[].obs;
  var allVisits = <VisitModel>[].obs;
  var allVisitsFiltered = <DayVisits>[].obs;
  var archiveVisitsFiltered = <VisitModel>[].obs;
  var selectedTag = 0.obs;
  var allVisitsScrollController = ScrollController();
  var myVisitsScrollController = ScrollController();
  var archiveVisitsScrollController = ScrollController();
  var reportScrollController = ScrollController();
  var currentPageAll = 1.obs;
  var currentPageArchive = 1.obs;
  var currentPageReports = 1.obs;
  var currentPageMy = 1.obs;
  var isLoadingMore = false.obs;
  var userRx = ''.obs;
  TextEditingController searchController = TextEditingController();
  TextEditingController allSearchController = TextEditingController();
  TextEditingController archiveSearchController = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController familyId = TextEditingController();
  TextEditingController familyNumber = TextEditingController();
  TextEditingController phone = TextEditingController();
  var id = RxInt(-1);

  void changeVisitOrder() async {
    await mainController.orderVisit(
        lang.value, token.value, OrderModel(ids: order));
  }

  void changeLanguage(String languageCode) async {
    lang.value = languageCode;
    CacheHelper.saveData(key: 'lang', value: languageCode);
    var locale = Locale(languageCode);
    Get.updateLocale(locale);
    title.value = [
      RxString('visits'.tr),
      RxString('archives'.tr),
      RxString('reports'.tr),
      RxString('profile'.tr),
    ].obs;
    getData();
    runApp(MyApp(
      lang: lang.value,
      isDark: isDark.value,
    ));
  }

  void changeTheme() async {
    await CacheHelper.saveData(key: 'isDark', value: isDark.value);
    runApp(MyApp(
      lang: lang.value,
      isDark: isDark.value,
    ));
  }

  void logout() async {
    isLoadingInternal(true);
    mainController.logout(lang.value, token.value);
    Get.offAllNamed(Routes.LOGIN, arguments: [lang.value, isDark.value]);
    isLoadingInternal(false);
  }

  String formatDate(String dateString) {
    DateTime date = DateFormat('dd-MM-yyyy').parseStrict(dateString);
    String formattedDate =
        DateFormat('d-MMM', lang.value == 'ar' ? 'ar' : 'en').format(date);
    return formattedDate;
  }

  RxList<DayVisits> groupByDay(List<VisitModel> visits) {
    var groupedVisits = groupBy(visits, (visit) => visit.date);
    var groupedVisitsList = <DayVisits>[];
    groupedVisits.forEach(
      (key, value) {
        groupedVisitsList.add(DayVisits(day: key ?? "", visits: RxList(value)));
      },
    );

    return groupedVisitsList.obs;
  }

  Future<void> onUserSelected(String user) async {
    isLoadingInternal(true);
    lastPageReports(false);
    currentPageReports(1);
    visitsReport.value = await mainController.getReport(
        lang.value, token.value, userId[userNames.indexOf(user)], {
          'user_id': userId[userNames.indexOf(user)],
    });
    userRx(user);
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
    await mainController.addPatient(
        lang.value,
        token.value,
        User(
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
    if (value.isEmpty) {
      archiveVisitsFiltered.value = archiveVisits;
    } else {
      archiveVisitsFiltered.value = archiveVisits
          .where((element) =>
              element.userName!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
  }

  void onSearchAll(String value) {
    if (value.isEmpty) {
      allVisitsFiltered.value = groupByDay(allVisits);
    } else {
      allVisitsFiltered.value = groupByDay(allVisits
          .where((element) =>
              element.userName!.toLowerCase().contains(value.toLowerCase()) &&
              element.status?.value == tags[selectedTag.value].value)
          .toList());
    }
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
        color = AppColors.red;
    }
    return color;
  }

  void onTagsChanged(int index) {
    if (tags[index].isSelected.value) {
      for (int i = 0; i < tags.length; i++) {
        tags[i].isSelected.value = false;
      }
      allVisitsFiltered.value = groupByDay(allVisits);
    } else {
      for (int i = 0; i < tags.length; i++) {
        tags[i].isSelected.value = false;
      }
      tags[index].isSelected.value = true;
      selectedTag(index);
      allVisitsFiltered.value = groupByDay(allVisits
          .where((element) => element.status?.value == tags[index].value)
          .toList());
    }
  }

  Future<void> getData() async {
    try {
      isLoadingInternal(true);
      myVisits.value = await mainController
          .getMeVisitData(lang.value, token.value, {'me': 1});
      allVisits.value =
          await mainController.getAllVisitData(lang.value, token.value, {});
      archiveVisits.value =
          await mainController.getArchivesVisits(lang.value, token.value, {});
      profile.value = await mainController.getProfile(lang.value, token.value);
      allVisitsGrouped.value = groupByDay(allVisits);
      allVisitsFiltered.value = groupByDay(allVisits);
      archiveVisitsFiltered.value = archiveVisits;
      myVisitsGrouped.value = groupByDay(myVisits);
      userNames([]);
      userId([]);
      var userData = await mainController.getUserData(lang.value, token.value);
      for (var element in userData) {
        if (lang.value == 'en') {
          userNames.add(element.name?.name ?? '');
        } else {
          userNames.add(element.name?.nameAr ?? '');
        }
        userId.add(element.id ?? -1);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to retrieve data");
    } finally {
      isLoadingInternal(false);
    }
  }

  void onBottomNavItemClicked(int index) {
    pageController.jumpToPage(index);
  }

  Future<void> getMoreDataAllVisits() async {
    if (isLoadingMore.value || lastPageAll.value) return;

    isLoadingMore.value = true;

    currentPageAll.value++; // Increment the page before fetching new data

    var data = await mainController.getAllVisitData(
        lang.value, token.value, {"page": currentPageAll.value});

    if (data.isNotEmpty) {
      allVisits.addAll(data); // Efficiently add new data to existing list
      allVisitsGrouped.value = groupByDay(allVisits); // Update grouped data
      allVisitsFiltered.assignAll(allVisitsGrouped); // Trigger UI update
    } else {
      lastPageAll.value = true;
    }

    isLoadingMore.value = false;
  }

  Future<void> getMoreDataMyVisits() async {
    if (isLoadingMore.value || lastPageMe.value) return;

    isLoadingMore.value = true;

    currentPageMy.value++; // Increment the page before fetching new data

    var data = await mainController.getMeVisitData(
        lang.value, token.value, {"me": 1, "page": currentPageMy.value});

    if (data.isNotEmpty) {
      myVisits.addAll(data);
      myVisitsGrouped.value = groupByDay(myVisits);
    } else {
      lastPageMe.value = true;
    }

    isLoadingMore.value = false;
  }

  Future<void> getMoreDataArchiveVisits() async {
    if (isLoadingMore.value || lastPageArchive.value) return;
    isLoadingMore.value = true;
    currentPageArchive.value++;

    var data = await mainController.getArchivesVisits(
        lang.value, token.value, {"page": currentPageArchive.value});

    if (data.isNotEmpty) {
      archiveVisits.addAll(data);
      archiveVisitsFiltered.value = archiveVisits;
    } else {
      lastPageMe.value = true;
    }

    isLoadingMore.value = false;
  }

  Future<void> getMoreDataReportsVisits(String user) async {
    if (isLoadingMore.value || lastPageReports.value) return;
    isLoadingMore.value = true;
    currentPageReports.value++;

    var data = await mainController.getReport(
        lang.value, token.value, userId[userNames.indexOf(user)], {
      'user_id': userId[userNames.indexOf(user)],
      'page': currentPageReports.value
    });
    print(data);
    if (data.isNotEmpty) {
      visitsReport.addAll(data);
    } else {
      lastPageMe.value = true;
    }
    isLoadingMore.value = false;
  }

  @override
  void onInit() async {
    isLoading(true);
    isDark.value = Get.arguments[1];
    lang.value = Get.arguments[0];
    token.value = Get.arguments[2];
    await getData();
    isLoading(false);
    super.onInit();
  }
}
