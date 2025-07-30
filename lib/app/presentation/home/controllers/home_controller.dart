import 'package:collection/collection.dart';
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
import '../screens/all_visits_screen.dart';
import '../screens/archive_visits_screen.dart';
import '../screens/my_visits_screen.dart';
import '../screens/report_screen.dart';

class HomeController extends GetxController {
  var screens = <Widget>[
    const MyVisitsScreen(),
    const AllVisitsScreen(),
    ReportScreen(),
    const ArchiveVisitsScreen(),
  ].obs;
  var pageController = PageController();
  var visitsPageController = PageController();
  var title = <RxString>[
    RxString('me'.tr),
    RxString('visits'.tr),
    RxString('reports'.tr),
    RxString('archives'.tr),
  ].obs;
  var currentScreen = 0.obs;
  var isLoading = false.obs;
  var isLoadingInternal = false.obs;
  var me = RxBool(true);
  var users = <DropDown>[].obs;
  var selectedUser = DropDown().obs;
  var tags = <TagsModel>[].obs;
  var isSubmitted = RxBool(false);
  var myVisitsGrouped = <DayVisits>[].obs;
  var allVisitsGrouped = <DayVisits>[].obs;
  var visitsReport = <VisitModel>[].obs;
  var patient = User().obs;
  var visitsArchives = <VisitModel>[].obs;
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
  var dataMap=<String,double>{};
  RxInt selectedStatus = 0.obs;
  TextEditingController searchController = TextEditingController();
  TextEditingController allSearchController = TextEditingController();
  TextEditingController archiveSearchController = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController familyId = TextEditingController();
  TextEditingController familyNumber = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController reportController = TextEditingController();

  final useCase = BaseUseCase(repository: DioHelperRepository.repository);

  var id = RxInt(-1);

  void changeVisitOrder() async {
    await useCase.orderVisit(OrderModel(ids: order));
  }

  String formatDate(String dateString,String lang) {
    DateTime date = DateFormat('dd-MM-yyyy').parseStrict(dateString);
    String formattedDate =
        DateFormat('d-MMM', lang).format(date);
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

  Future<void> onUserSelected(DropDown user) async {
    isLoadingInternal(true);
    lastPageReports(false);
    currentPageReports(1);
    visitsReport(await useCase.getReport(user.id??0, 1));
    selectedUser(user);
    dataMap = <String,double>{
      'done'.tr:visitsReport.where((element) => element.status?.value == 5).length.toDouble(),
      'cancel'.tr:visitsReport.where((element) => element.status?.value == 6).length.toDouble(),
      'delayed'.tr:visitsReport.where((element) => element.status?.value == 4).length.toDouble(),
      'assign'.tr:visitsReport.where((element) => element.status?.value == 3).length.toDouble(),
      'new'.tr:visitsReport.where((element) => element.status?.value == 1).length.toDouble(),
      'inprogress'.tr:visitsReport.where((element) => element.status?.value == 2).length.toDouble(),
    };
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
    await useCase.addPatient(User(
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

  void onPageChange(int index){
    currentScreen.value = index;
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

  void onSearchMy(String value) {
    if (value.isEmpty) {
      myVisitsGrouped.value = groupByDay(myVisits);
    }
    myVisitsGrouped.value = groupByDay(myVisits
        .where((element) =>
            element.userName!.toLowerCase().contains(value.toLowerCase()))
        .toList());
  }

  void onSearch(String value) {
    switch (currentScreen.value) {
      case 0:
        onSearchMy(value);
        break;
      case 1:
        onSearchAll(value);
        break;
      case 2:
        break;
      case 3:
        onSearchArchive(value);
        break;
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

  void onTagsChanged(int index) {
    if(selectedStatus.value == index){
      selectedStatus.value = 0;
      allVisitsFiltered.value = groupByDay(allVisits);
    }else{
      selectedStatus.value = index;
      allVisitsFiltered.value = groupByDay(allVisits
          .where((element) => element.status?.value == tags[index].value)
          .toList());
    }
  }

  Future<void> getData() async {
    try {
      isLoadingInternal(true);
      myVisits.clear();
      allVisits.clear();
      archiveVisits.clear();
      visitsReport.clear();
      myVisits(await useCase.getMeVisitData(1));
      allVisits(await useCase.getAllVisitData(1));
      archiveVisits(await useCase.getArchivesVisits(1));
      profile(await useCase.getProfile());
      allVisitsGrouped.value = groupByDay(allVisits);
      allVisitsFiltered.value = groupByDay(allVisits);
      archiveVisitsFiltered.value = archiveVisits;
      myVisitsGrouped.value = groupByDay(myVisits);
      currentPageAll(2);
      currentPageArchive(2);
      currentPageReports(2);
      currentPageMy(2);
      users(await useCase.getUserData() ?? []);
    } catch (e) {
      Get.snackbar("Error", "Failed to retrieve data");
    } finally {
      isLoadingInternal(false);
    }
  }

  void onBottomNavItemClicked(int index) {
    searchController.text = '';
    pageController.jumpToPage(index);
  }

  Future<void> getMoreDataAllVisits() async {
    if (allLoadingMore.value) return;
    if(allVisits.length<15) return;
    try{
      allLoadingMore(true);
      var getMoreAll = await useCase.getAllVisitData(currentPageAll.value);
      if (getMoreAll == null || getMoreAll.isEmpty) {
        lastPageAll(true);
      } else {
        allVisits.addAll(getMoreAll);
        currentPageAll(currentPageAll.value + 1);
        allVisitsGrouped.value = groupByDay(allVisits);
        allVisitsFiltered(allVisitsGrouped);
      }
    }catch(e){
      Get.snackbar("Error", "Failed to retrieve data");
    }finally{
      allLoadingMore(false);
    }
  }

  Future<void> getMoreDataMyVisits() async {
    if (meLoadingMore.value) return;
    if(myVisits.length<15) return;
    try{
      meLoadingMore(true);
      var getMoreMe = await useCase.getMeVisitData(currentPageMy.value);
      if (getMoreMe == null || getMoreMe.isEmpty) {
        lastPageMe(true);
      } else {
        myVisits.addAll(getMoreMe);
        currentPageMy(currentPageMy.value + 1);
        myVisitsGrouped.value = groupByDay(myVisits);
      }
    }catch(e){
      Get.snackbar("Error", "Failed to retrieve data");
    }finally{
      meLoadingMore(false);
    }
  }

  Future<void> getMoreDataArchiveVisits() async {
    if (archiveLoadingMore.value) return;
    if(archiveVisits.length<15) return;
    try{
      archiveLoadingMore(true);
      var getMoreArchive =
      await useCase.getArchivesVisits(currentPageArchive.value);
      if (getMoreArchive == null || getMoreArchive.isEmpty) {
        lastPageArchive(true);
      } else {
        archiveVisits.addAll(getMoreArchive);
        currentPageArchive(currentPageArchive.value + 1);
        archiveVisitsFiltered.value = archiveVisits;
      }
    }catch(e){
      Get.snackbar("Error", "Failed to retrieve data");
    }finally {
      archiveLoadingMore(false);
    }
  }

  Future<void> getMoreDataReportsVisits() async {
    if (reportsLoadingMore.value) return;
    if(visitsReport.length<15) return;
    try{
      reportsLoadingMore(true);
      var getMoreReports = await useCase.getReport(selectedUser.value.id??0, currentPageReports.value);

      if (getMoreReports == null || getMoreReports.isEmpty) {
        lastPageReports(true);
      } else {
        visitsReport.addAll(getMoreReports);
        currentPageReports(currentPageReports.value + 1);
      }
    }catch(e){
      Get.snackbar("Error", "Failed to retrieve data");
    }finally {
      reportsLoadingMore(false);
    }
  }

  void onDone(int id) async {
    await useCase.onDone(id);
    getData();
  }

  void onCanceled(int id) async {
    await useCase.onCanceled(id);
    getData();
  }

  @override
  void onInit() async {
    isLoading(true);
    var cache = await CacheHelper.getEnums();
    if (cache != null) {
      for (var element in cache.visitsStatus!) {
        tags.add(TagsModel(
            name: element.name ?? '',
            value: element.value ?? -1,
            type: element.name));
      }
    }
    await getData();
    isLoading(false);
    super.onInit();
  }
}
