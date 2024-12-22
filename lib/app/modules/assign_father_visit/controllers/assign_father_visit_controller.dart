import 'package:ar_visiting_app/app/core/firebase/GetFatherFirebase.dart';
import 'package:ar_visiting_app/app/core/firebase/GetServantFirebase.dart';
import 'package:ar_visiting_app/app/core/models/father/fathermodel.dart';
import 'package:ar_visiting_app/app/core/models/servant/servantmodel.dart';
import 'package:get/get.dart';

import '../../../core/firebase/AddVisitFirebase.dart';
import '../../../core/firebase/GetVisitDetailsFirebase.dart';
import '../../../core/models/visits/addvisitmodel.dart';
import '../../../core/models/visits/visitsmodel.dart';
import '../../../core/services/cache_helper.dart';
import '../../../core/utils/app_string.dart';
import '../../../routes/app_pages.dart';

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
      Visit newVisit = Visit(
          area: visitData.value.area,
          father: {
            "id":"",
            "name":"",
            "nameAr":"",
            "phoneNumber":"",
            "isFather":father.value.isFather,
          },
          patient: visitData.value.patient,
          servant: visitData.value.servant,
          assistant: visitData.value.assistant,
          status: 'NEW',
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
              (route) => route.settings.name == Routes.VISITS,
          arguments: id
      );
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
      Visit newVisit = Visit(
          area: visitData.value.area,
          father: {
            "id":father.value.id,
            "name":father.value.name,
            "nameAr":father.value.nameAr,
            "phoneNumber":father.value.phone,
            "isFather":father.value.isFather,
          },
          patient: visitData.value.patient,
          servant: visitData.value.servant,
          assistant: visitData.value.assistant,
          status: 'Assigned',
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
              (route) => route.settings.name == Routes.VISITS,
          arguments: id
      );
    }catch (e){
      Get.snackbar("Error", e.toString());
    }finally{
      isLoading(false);
    }
  }
}