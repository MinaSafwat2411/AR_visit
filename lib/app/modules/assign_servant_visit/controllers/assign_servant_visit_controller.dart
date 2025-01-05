import 'package:ar_visiting_app/app/core/firebase/GetServantFirebase.dart';
import 'package:ar_visiting_app/app/core/models/servant/servantmodel.dart';
import 'package:get/get.dart';


import '../../../core/services/cache_helper.dart';

class AssignServantVisitController extends GetxController{
  var isLoading = false.obs;
  String id =Get.arguments;
  var servant =Servant(
    phone: "",
    id: "",
    isFather: false,
    name: ""
  ).obs;
  var servantList=<Servant>[].obs;
  String lang=CacheHelper.getData(key: 'lang')??'en';



  Future<void> getVisitDetails() async {
    isLoading.value = true;
    try {
    } catch (e) {
      Get.snackbar("Error", "Failed to retrieve visit details: $e");
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> getServantNames() async {
    isLoading.value = true;
    try {
      servantList.value = await GetServantFirebase.retrieveServant();
    }catch(e){
      Get.snackbar("Error", "Failed to retrieve servant details");
    }finally{
      isLoading.value=false;
    }
  }

  onServantSelected(Servant servant){
    this.servant.value =servant;
    onAssign();
  }
  @override
  void onInit() async{
    await getVisitDetails();
    await getServantNames();
    super.onInit();
  }

  onCanceledAssign(){
    isLoading(true);
    try{
    }catch (e){
      Get.snackbar("Error", e.toString());
    }finally{
      isLoading(false);
    }
  }

  void onAssign(){
    isLoading(true);
    try{

    }catch (e){
      Get.snackbar("Error", e.toString());
    }finally{
      isLoading(false);
    }
  }
}