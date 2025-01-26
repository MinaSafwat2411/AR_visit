import 'package:ar_visiting_app/app/core/controller/main_controller.dart';
import 'package:ar_visiting_app/app/core/models/login/loginmodel.dart';
import 'package:ar_visiting_app/app/routes/app_pages.dart';
import 'package:get/get.dart';


import '../../../core/services/cache_helper.dart';

class AssignServantVisitController extends GetxController{
  var isLoading = false.obs;
  int visitId =Get.arguments;
  var servant = <User>[].obs;
  var servantNames =<String>[].obs;
  var servantId =<int>[].obs;
  String lang=CacheHelper.getData(key: 'lang')??'en';
  var mainController =MainController();



  Future<void> getServantNames() async {
    isLoading.value = true;
    servant.value = (await mainController.getUserList(2))!;
    for (var servant in servant) {
      servantNames.add(servant.name!);
      servantId.add(servant.id!);
    }
    isLoading.value = false;
  }

  onServantSelected(int index)async{
    isLoading(true);
    await mainController.assignServent(visitId, servantId[index]);
    isLoading(false);
    
    Get.offNamedUntil(Routes.VISITS,(route) => false,);
  }
  @override
  void onInit() async{
    await getServantNames();
    super.onInit();
  }

}