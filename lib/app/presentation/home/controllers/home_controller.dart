
import 'package:ar_visiting_app/app/data/models/logout/logout_model.dart';
import 'package:ar_visiting_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/services/cache_helper.dart';
import '../../../core/utils/app_colors.dart';
import '../../../data/models/login/loginmodel.dart';
import '../../../data/models/oder/order_model.dart';
import '../../../data/models/profile/profile_model.dart';
import '../../../data/models/tags/tags_model.dart';
import '../../../data/models/visits/VisitsModel.dart';
import '../../../data/models/visits/visitmodel.dart';
import '../../../data/repository/dio_helper_repository.dart';
import '../../../domain/usecase/base_use_case.dart';
import '../../../routes/app_pages.dart';
import '../screens/archive_visits_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/report_screen.dart';
import 'package:collection/collection.dart';

import '../screens/visits_screen.dart';

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
  var me = RxBool(true);
  var token = ''.obs;
  var lang = ''.obs;
  var userNames = <String>[].obs;
  var userId = <int>[].obs;
  var tags =<TagsModel>[].obs;
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
  var currentPageAll = 2.obs;
  var currentPageArchive = 2.obs;
  var currentPageReports = 2.obs;
  var currentPageMy = 2.obs;
  var isLoadingMore = false.obs;
  var userRx = ''.obs;
  var meLoadingMore = RxBool(false);
  var archiveLoadingMore = RxBool(false);
  var allLoadingMore = RxBool(false);
  var reportsLoadingMore = RxBool(false);
  var lastPageAll = RxBool(false);
  var lastPageMe = RxBool(false);
  var lastPageArchive = RxBool(false);
  var lastPageReports = RxBool(false);
  TextEditingController searchController = TextEditingController();
  TextEditingController allSearchController = TextEditingController();
  TextEditingController archiveSearchController = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController familyId = TextEditingController();
  TextEditingController familyNumber = TextEditingController();
  TextEditingController phone = TextEditingController();

  final useCase = BaseUseCase(repository: DioHelperRepository.repository);

  var id = RxInt(-1);

  void changeVisitOrder() async {
    await useCase.orderVisit(
        lang.value, token.value, OrderModel(ids: order));
  }

  void changeLanguage(String languageCode) async {
    Get.back(closeOverlays: true);
    if (languageCode != lang.value) {
      CacheHelper.saveData(key: 'lang', value: languageCode);
      Get.offAllNamed(Routes.SPLASH, arguments: true);
    }
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
    LogoutModel? logout = await useCase.logout(lang.value, token.value);
    if (logout != null) {
      Get.offAllNamed(Routes.LOGIN, arguments: [lang.value, isDark.value]);
    }
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
    visitsReport(await useCase.getReport(lang.value, token.value, userId[userNames.indexOf(user)]));
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
    await useCase.addPatient(
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
    Get.back(closeOverlays: true);
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
      myVisits(await useCase.getMeVisitData(lang.value, token.value, 1));
      allVisits(await useCase.getAllVisitData(lang.value, token.value, 1));
      archiveVisits(await useCase.getArchivesVisits(lang.value, token.value, 1));
      profile(await useCase.getProfile(lang.value, token.value));
      allVisitsGrouped.value = groupByDay(allVisits);
      allVisitsFiltered.value = groupByDay(allVisits);
      archiveVisitsFiltered.value = archiveVisits;
      myVisitsGrouped.value = groupByDay(myVisits);
      userNames([]);
      userId([]);
      var userData = await useCase.getUserData(lang.value, token.value)??[];
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
    if (allLoadingMore.value) return;
    allLoadingMore(true);
    var getMoreAll = await useCase.getAllVisitData(lang.value, token.value, currentPageAll.value);
    if (getMoreAll == null || getMoreAll.isEmpty) {
      lastPageAll(true);
    } else {
      allVisits.addAll(getMoreAll);
      currentPageAll(currentPageAll.value + 1);
      allVisitsGrouped.value = groupByDay(allVisits);
      allVisitsFiltered(allVisitsGrouped);
    }
    allLoadingMore(false);
  }

  Future<void> getMoreDataMyVisits() async {
    if (meLoadingMore.value) return;
    meLoadingMore(true);
    var getMoreMe = await useCase.getMeVisitData(lang.value, token.value, currentPageMy.value);
    if (getMoreMe == null || getMoreMe.isEmpty) {
      lastPageMe(true);
    } else {
      myVisits.addAll(getMoreMe);
      currentPageMy(currentPageMy.value + 1);
      myVisitsGrouped.value = groupByDay(myVisits);
    }
    meLoadingMore(false);
  }

  Future<void> getMoreDataArchiveVisits() async {
    if (archiveLoadingMore.value) return;
    archiveLoadingMore(true);
    var getMoreArchive = await useCase.getArchivesVisits(lang.value, token.value, currentPageArchive.value);
    if (getMoreArchive == null || getMoreArchive.isEmpty) {
      lastPageArchive(true);
    } else {
      archiveVisits.addAll(getMoreArchive);
      currentPageArchive(currentPageArchive.value + 1);
      archiveVisitsFiltered.value = archiveVisits;
    }
    archiveLoadingMore(false);
  }

  Future<void> getMoreDataReportsVisits(String user) async {
    if (reportsLoadingMore.value) return;
    reportsLoadingMore(true);
    var getMoreReports = await useCase.getReport(
        lang.value, token.value, userId[userNames.indexOf(user)]);

    if (getMoreReports == null || getMoreReports.isEmpty) {
      lastPageReports(true);
    } else {
      visitsReport.addAll(getMoreReports);
      currentPageReports(currentPageReports.value + 1);
    }
    reportsLoadingMore(false);
  }

  @override
  void onInit() async {
    isLoading(true);
    isDark.value = Get.arguments[1];
    lang.value = Get.arguments[0];
    token.value = Get.arguments[2];
    var cache = await CacheHelper.getEnums();
    if (cache != null) {
      for (var element in cache.visitsStatus!) {
        tags.add(TagsModel(name: element.name ?? '', isSelected: RxBool(false), value: element.value?? -1,type: element.name));
      }
    }
    await getData();
    isLoading(false);
    super.onInit();
  }
}
