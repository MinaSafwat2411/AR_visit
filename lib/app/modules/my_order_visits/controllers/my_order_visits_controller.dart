import 'dart:ui';

import 'package:ar_visiting_app/app/core/controller/main_controller.dart';
import 'package:ar_visiting_app/app/core/models/visits/visitmodel.dart';
import 'package:ar_visiting_app/app/core/services/cache_helper.dart';
import 'package:ar_visiting_app/app/core/services/secure_cache_helper.dart';
import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:get/get.dart';

class MyOrderVisitsController extends GetxController{
  var isLoading =RxBool(false);
  var orderList = <int>[].obs;
  var newVisitOrderList = <VisitModel>[].obs;
  var visitList = <VisitModel>[].obs;
  var mainController =MainController();
  var lang = ''.obs;
  var token = ''.obs;

  void getVisitData()async{
    isLoading(true);
    // ignore: avoid_function_literals_in_foreach_calls
    orderList.forEach((element) async {
      visitList.add(await mainController.getVisitData(element));
    },
    );
    isLoading(false);
    
  }
    void reorderList(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = orderList.removeAt(oldIndex);
    orderList.insert(newIndex, item);
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


  @override
  void onInit() async{
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    orderList.value =  CacheHelper.getIntList(key: 'order')??[];
    getVisitData();
    super.onInit();
  }
}