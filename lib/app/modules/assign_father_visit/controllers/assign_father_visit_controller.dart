
import 'package:ar_visiting_app/app/core/controller/main_controller.dart';
import 'package:ar_visiting_app/app/core/models/login/loginmodel.dart';
import 'package:ar_visiting_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../core/services/cache_helper.dart';


class AssignFatherVisitController extends GetxController{

var isLoading = false.obs;
  int visitId =Get.arguments;
  var father = <User>[].obs;
  var fatherNames =<String>[].obs;
  var fatherId =<int>[].obs;
  String lang=CacheHelper.getData(key: 'lang')??'en';
  var mainController =MainController();



  Future<void> getFatherNames() async {
    isLoading.value = true;
    father.value = (await mainController.getUserList(1));

    for (var father in father) {
      fatherNames.add(father.name!);
      fatherId.add(father.id!);
    }
    isLoading.value = false;
  }

  onFatherSelected(int index)async{
    isLoading(true);
    await mainController.assignFather(visitId, fatherId[index]);
    isLoading(false);
    Get.offNamedUntil(Routes.VISITS,(route) => false,);
  }
  @override
  void onInit() async{
    await getFatherNames();
    super.onInit();
  }
}