import 'package:ar_visiting_app/app/core/firebase/GetFatherFirebase.dart';
import 'package:ar_visiting_app/app/core/firebase/GetServantFirebase.dart';
import 'package:ar_visiting_app/app/core/models/father/fathermodel.dart';
import 'package:ar_visiting_app/app/core/models/servant/servantmodel.dart';
import 'package:get/get.dart';

import '../../../core/firebase/AddVisitFirebase.dart';
import '../../../core/firebase/GetVisitDetailsFirebase.dart';
import '../../../core/models/visits/addvisitmodel.dart';
import '../../../core/models/visits/visitsmodel.dart';
import '../../../core/sharedchache/cache_helper.dart';
import '../../../core/utils/app_string.dart';
import '../../../routes/app_pages.dart';

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
  var visitData=VisitModel(
      id: '',
      status: '',
      area: {},
      father: {},
      patient: {},
      assistant: {},
      servant: {},
      visitDate: '',
      visitTimeRangeFrom: '',
      visitTimeRangeTo: '',
      numberOfPeople: '',
      address: {},
      googleLink: '',
      note: ''
  ).obs;
  String lang=CacheHelper.getData(key: 'lang')??'en';

  String getServant(){
    return lang =='en'? AppStringsEn.servant : AppStringsAr.servant;
  }
  String getCancel(){
    return lang =='en'? AppStringsEn.cancel : AppStringsAr.cancel;
  }
  String getComfirmYes(){
    return lang =='en'? AppStringsEn.yes : AppStringsAr.yes;
  }
  String getComfirmNo(){
    return lang =='en'? AppStringsEn.no : AppStringsAr.no;
  }
  String getAssignPerson(){
    return lang =='en'? AppStringsEn.assignPerson : AppStringsAr.assignPerson;
  }


  Future<void> getVisitDetails() async {
    isLoading.value = true;
    try {
      VisitModel? visitDetails = await VisitsRetriever.retrieveVisitDetails(id);
      visitData.value=visitDetails!;
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
      Visit newVisit = Visit(
          area: visitData.value.area,
          father: visitData.value.father,
          patient: visitData.value.patient,
          servant: {
            "id":"",
            "name":"",
            "nameAr":"",
            "phoneNumber":"",
            "isFather":servant.value.isFather,
          },
          assistant: visitData.value.assistant,
          status: visitData.value.status,
          address: visitData.value.address,
          visitDate: visitData.value.visitDate,
          visitTimeRangeFrom: visitData.value.visitTimeRangeFrom,
          visitTimeRangeTo:visitData.value.visitTimeRangeTo,
          numberOfPeople: visitData.value.numberOfPeople,
          note: visitData.value.note,
          googleLink: visitData.value.googleLink
      );
      VisitSubmission.updateVisit(id,newVisit);
      Get.snackbar("Visits", "Visits has been Assigned");
      Get.offNamedUntil(
          Routes.VISIT_DETAILS,
              (route) => route.settings.name == Routes.HOME,
          arguments: id
      );
    }catch (e){
      Get.snackbar("Error", e.toString());
    }finally{
      isLoading(false);
    }
  }

  void onAssign(){
    isLoading(true);
    try{
      Visit newVisit = Visit(
          area: visitData.value.area,
          father: visitData.value.father,
          patient: visitData.value.patient,
          servant: {
            "id":servant.value.id,
            "isFather":servant.value.isFather,
            "phoneNumber":servant.value.phone,
            "name":servant.value.name,
            "nameAr":servant.value.nameAr,
          },
          assistant: visitData.value.assistant,
          status: visitData.value.status,
          address: visitData.value.address,
          visitDate: visitData.value.visitDate,
          visitTimeRangeFrom: visitData.value.visitTimeRangeFrom,
          visitTimeRangeTo:visitData.value.visitTimeRangeTo,
          numberOfPeople: visitData.value.numberOfPeople,
          note: visitData.value.note,
          googleLink: visitData.value.googleLink
      );
      VisitSubmission.updateVisit(id,newVisit);
      Get.snackbar("Visits", "Visits has been Assigned");
      Get.offNamedUntil(
          Routes.VISIT_DETAILS,
              (route) => route.settings.name == Routes.HOME,
          arguments: id
      );
    }catch (e){
      Get.snackbar("Error", e.toString());
    }finally{
      isLoading(false);
    }
  }
}