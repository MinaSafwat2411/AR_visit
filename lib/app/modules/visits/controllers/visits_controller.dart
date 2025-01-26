import 'dart:async';

import 'package:ar_visiting_app/app/core/controller/main_controller.dart';
import 'package:ar_visiting_app/app/core/models/visits/VisitsModel.dart';
import 'package:ar_visiting_app/app/core/models/visits/visitmodel.dart';
import 'package:ar_visiting_app/app/core/services/cache_helper.dart';
import 'package:ar_visiting_app/app/core/services/dio_helper.dart';
import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:ar_visiting_app/app/core/utils/backend_endpoint.dart';
import 'package:ar_visiting_app/app/modules/visits/di/tags/tags_model.dart';
import 'package:ar_visiting_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/models/api_response/api_response.dart';
import '../../../core/services/secure_cache_helper.dart';

class VisitController extends GetxController {
  var mainController = MainController();
  var isLoading = RxBool(false);
  var me = RxBool(true);
  var onSearch = RxBool(false);
  var token = ''.obs;
  var searchQuery = ''.obs;
  String lang = CacheHelper.getData(key: 'lang') ?? 'en';
  var tags = <TagsModel>[].obs;
  var visits = <DayVisits>[].obs;
  var searchResults = <DayVisits>[].obs;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchTags();
    searchController.addListener(search);
    _loadTokenAndVisits();
  }

  void onSearchClicked() {
    if (!me.value) {
      onSearch.value = !onSearch.value;
    }
  }

  void getAllVisits() async {
    me.value = false;
    await getVisitsData();
  }

  void getMyVisits() async {
    me.value = true;
    await getVisitsData();
  }

  Future<void> _loadTokenAndVisits() async {
    token.value = (await SecureCacheHelper.getData(key: 'token'))!;
    await getVisitsData();
  }

  void search() {
    searchQuery.value = searchController.text;
    if (searchQuery.value.isEmpty) {
      searchResults.value = visits;
    } else {
      searchResults.value = visits
          .map((day) => DayVisits(
              day: day.day,
              visits: day.visits
                  .where((visit) => visit.userName!
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()))
                  .toList()))
          .where((day) => day.visits.isNotEmpty)
          .toList();
    }
  }

  void fetchTags() {
    tags.value = [
      TagsModel(
          name: 'New',
          value: 1,
          type: null,
          nameAr: 'جديد',
          isSelected: RxBool(false)),
      TagsModel(
          name: 'assigned',
          value: null,
          type: 'assigned',
          nameAr: 'تم تعيينه',
          isSelected: RxBool(false)),
      TagsModel(
          name: 'inprogress',
          value: 2,
          type: null,
          nameAr: 'قيد التنفيذ',
          isSelected: RxBool(false)),
      TagsModel(
          name: 'Delayed',
          value: 3,
          type: null,
          nameAr: 'متأخر',
          isSelected: RxBool(false)),
      TagsModel(
          name: 'done',
          value: 4,
          type: null,
          nameAr: 'تم',
          isSelected: RxBool(false)),
      TagsModel(
          name: 'cancelled',
          value: 5,
          type: null,
          nameAr: 'تم إلغاؤه',
          isSelected: RxBool(false)),
    ];
  }

  void onCanceled(int id) async {
    Get.back(closeOverlays: true);
    isLoading(true);
    try {
      await DioHelper.putData(
          url: '${BackendEndpoint.cancel}/${id.toString()}',
          token: token.value);
    } catch (e) {
      Get.snackbar('Error', 'Can\'t make visit canceled');
    } finally {
      isLoading(false);
      getVisitsData();
    }
  }

  Color statusColor(int status){
    var color = Color(0xffffffff);
    switch(status){
       case 1: color= AppColors.violetPurple;
       case 2 : color = AppColors.blue;
       case 3 : color = AppColors.orange;
       case 4 : color = AppColors.green;
       case 5 : color = AppColors.red;
    }
    return color;
  }

  void onClone(VisitModel visit) async {
    try{
      var visitId =mainController.addVisit(visit);
      Get.toNamed(Routes.EDIT_VISIT,arguments: visitId);
    }catch(e){
      Get.snackbar('Error', 'Can\'t make visit clone');
    }
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
    getVisitsData();
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString.replaceAll('/', '-'));
    String formattedDate;
    if (lang == 'en') {
      formattedDate = DateFormat('d-MMM').format(date);
    } else {
      formattedDate = DateFormat('d-MMM', 'ar').format(date);
    }
    return formattedDate;
  }

  void onDone(int id, int status) async {
    Get.back(closeOverlays: true);
    if (status == 2) {
      isLoading(true);
      await mainController.onDone(id);
    } else {
      Get.snackbar('Visit', 'visit must be inprogress');
    }
  }

  Future<void> getVisitsData() async {
    int index = tags.indexWhere((element) => element.isSelected.value == true);
    isLoading.value = true;
    Map<String, dynamic> query = {};
    if (me.value) {
      query = {'type': 'mine'};
    } else if (index != -1) {
      if (tags[index].value != null) {
        query = {'status': tags[index].value};
      } else if (tags[index].type != null) {
        query = {'type': tags[index].type};
      } else {
        query = {};
      }
    }

    try {
      visits.value = [];
      final response = await DioHelper.getData(
        query: query,
        url: BackendEndpoint.visits,
        token: token.value,
        lang: lang,
      );
      final apiResponse = ApiResponse<List<DayVisits>>.fromJson(
        response.data,
        (json) {
          if (json == null) {
            return [];
          }
          return (json as List<dynamic>).map((dayJson) {
            if (dayJson == null) {
              return DayVisits(day: 'Unknown', visits: []);
            } else {
              return DayVisits.fromJson(dayJson as Map<String, dynamic>);
            }
          }).toList();
        },
      );
      visits.value = apiResponse.data ?? <DayVisits>[];
      searchResults.value = visits;
      search();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
