import 'package:ar_visiting_app/app/core/firebase/GetFatherFirebase.dart';
import 'package:ar_visiting_app/app/core/models/father/fathermodel.dart';
import 'package:get/get.dart';

import '../../../core/services/cache_helper.dart';


class AssignFatherVisitController extends GetxController{
  var isLoading = false.obs;
  String id =Get.arguments;
  var father =Father(
    name: "",
    isFather: true,
    id: "",
    phone: ""
  ).obs;
  var fatherList=<Father>[].obs;
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
  Future<void> getFathersNames() async {
    isLoading.value = true;
    try {
      fatherList.value = await GetFatherFirebase.retrieveFather();
    }catch(e){
      Get.snackbar("Error", "Failed to retrieve fathers details");
    }finally{
      isLoading.value=false;
    }
  }

  onFatherSelected(Father father){
    this.father.value =father;
    onAssign();
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
  @override
  void onInit() async{
    await getVisitDetails();
    await getFathersNames();
    super.onInit();
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