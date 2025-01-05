import 'dart:async';

import 'package:ar_visiting_app/app/core/models/visits/VisitsModel.dart';
import 'package:ar_visiting_app/app/core/services/cache_helper.dart';
import 'package:ar_visiting_app/app/core/services/dio_helper.dart';
import 'package:ar_visiting_app/app/core/utils/backend_endpoint.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/models/api_response/api_response.dart';
import '../../../core/models/visits/visitmodel.dart';
import '../../../core/services/secure_cache_helper.dart';
import '../../../routes/app_pages.dart';


class ALLVisitController extends GetxController {
  var visitsDates = <String>[].obs;
  var tagsStatusList = [true ,false ,false, false, false, false].obs;
  var isLoading=RxBool(false);
  var sortedDates = <DateTime>[].obs;
  var token = ''.obs;
  var condition = ''.obs;
  String lang=CacheHelper.getData(key: 'lang')??'en';
  var tags= ["mine","all","new","assigned","done","cancelled"];
  var tagsAr= ["أنا","الكل", "جديد", "تم تعيينه", "تم", "تم إلغاؤه"];
  var visits = <DayVisits>[].obs;



  String getStatus(String status){
    if(lang =='en'){
      return status;
    }else{
      switch(status){
        case "NEW":
          return 'جديد';
        case "Assigned":
          return 'تم تعيينه';
        case "Done":
          return 'تم';
        case "Canceled":
          return 'تم الغاؤه';
      }
      return status;
    }
  }



  @override
  void onInit() async{
    super.onInit();
    token.value=(await SecureCacheHelper.getData(key: 'token'))!;
    await getVisitsData();
    // _startRefreshTimer();
  }



  void _startRefreshTimer() {
    Timer.periodic(const Duration(seconds: 30), (timer) {
      getVisitsData();
    });
  }
  void onCanceled(int id)async{
  }
  void onClone(int id)async{
  }


  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString.replaceAll('/', '-'));
    String formattedDate = DateFormat('d-MMM').format(date);
    return formattedDate;
  }
  void onDone(int id)async{
  }
  Future<void> getVisitsData() async {
    isLoading.value = true;
    getVisitCondition();
    try {
      visits.value=[];
      final  response = await DioHelper.getData(
        query: {
          if(condition.value!='')'condition':condition.value
        },
        url: condition.value == 'cancelled'? BackendEndpoint.cancelled :BackendEndpoint.visits,
        token: token.value,
      );
      final apiResponse = ApiResponse<List<DayVisits>>.fromJson(
        response.data,
            (json) {
          if (json == null) {
            return [];
          }
          return (json as List<dynamic>)
              .map((dayJson) {
            if (dayJson == null) {
              return DayVisits(day: 'Unknown', visits: []);
            } else {
              return DayVisits.fromJson(dayJson as Map<String, dynamic>);
            }
          })
              .toList();
        },
      );
      visits.value=apiResponse.data ?? <DayVisits>[];
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }finally{
      isLoading.value = false;
    }
  }
  String getVisitCondition(){
    for(int i =0;i<tags.length;i++){
      if(tagsStatusList[i]){
        condition.value=tags[i];
      }
    }
    if(condition.value=="all"){
      condition.value='';
    }
    return condition.value;
  }

}

