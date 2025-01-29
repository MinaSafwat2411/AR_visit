import 'package:ar_visiting_app/app/core/models/api_response/api_response.dart';
import 'package:ar_visiting_app/app/core/models/area/areamodel.dart';
import 'package:ar_visiting_app/app/core/models/login/loginmodel.dart';
import 'package:ar_visiting_app/app/core/models/profile/profile_model.dart';
import 'package:ar_visiting_app/app/core/models/visits/VisitsModel.dart';
import 'package:ar_visiting_app/app/core/models/visits/visitmodel.dart';
import 'package:ar_visiting_app/app/core/services/cache_helper.dart';
import 'package:ar_visiting_app/app/core/services/dio_helper.dart';
import 'package:ar_visiting_app/app/core/services/secure_cache_helper.dart';
import 'package:ar_visiting_app/app/core/utils/backend_endpoint.dart';
import 'package:ar_visiting_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  var token = ''.obs;
  var lang = ''.obs;

  String changeFormatDB(String date) {
    var newDate = '';
    try {
      newDate ='${date.substring(6,10)}-${date.substring(3,5)}-${date.substring(0,2)}';
    } catch (e) {
      Get.snackbar('Error', 'Invalid date format');
    }
    return newDate;
  }
  String changeFormatView(String date) {
    var newDate = '';
    try {
      newDate ='${date.substring(0,2)}-${date.substring(3,5)}-${date.substring(6,10)}';
    } catch (e) {
      Get.snackbar('Error', 'Invalid date format');
    }
    return newDate;
  }
  Future<VisitModel> getVisitData(int id)async{
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    try {
      final response = await DioHelper.getData(
          url: '${BackendEndpoint.visits}/${id.toString()}',
          token: token.value,
          lang: lang.value);
      final apiResponse = ApiResponse<VisitModel>.fromJson(response.data,
          (json) => VisitModel.fromJson(json as Map<String, dynamic>));
          return apiResponse.data ?? VisitModel();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load visit data');
      return VisitModel();
    } 
  }

  Future<void> addPatient(User patient)async{
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    try{
      await DioHelper.postData(url: BackendEndpoint.users,token: token.value,lang: lang.value, data: patient.toJson());
    }catch(e){
      Get.snackbar('Error', 'couldn\'t add patient' );
    }
  }

  Future<List<User>> getUserData() async {
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    try {
      var responseUsers = await DioHelper.getData(
          url: BackendEndpoint.dropDown, lang: lang.value, token: token.value);
      final ApiResponse<List<User>> apiResponseUsers =
          ApiResponse.fromJson(responseUsers.data, (json) {
        if (json == null) {
          return [];
        }
        return (json as List).map((e) => User.fromJson(e)).toList();
      });
      return apiResponseUsers.data ??[];
    } catch (e) {
      Get.snackbar("Error", "Failed to retrieve area details");
      return [];
    }
  }

  Future<List<AreaModel>> getAreaData() async {
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    try {
      var responseArea = await DioHelper.getData(
          url: BackendEndpoint.areas, lang: lang.value, token: token.value);
      final ApiResponse<List<AreaModel>> apiResponseArea =
          ApiResponse.fromJson(responseArea.data, (json) {
        if (json == null) {
          return [];
        }
        return (json as List).map((e) => AreaModel.fromJson(e)).toList();
      });
      return apiResponseArea.data ??[];
    } catch (e) {
      Get.snackbar("Error", "Failed to retrieve area details");
      return [];
    }

  }

  Future<void> editVisit(VisitModel visit, int id) async {
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    try {
      await DioHelper.putData(
          url: '${BackendEndpoint.visits}/${id.toString()}',
          token: token.value,
          data: visit.toJson(),
          lang: lang.value);
      Get.snackbar("Visits", "Visit add successfully");
      Get.offNamedUntil(
          Routes.VISITS, (route) => route.settings.name == Routes.VISITS);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
    void logout() async {
      token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
      lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    try {
      await DioHelper.postData(
        url: BackendEndpoint.logout,
        token: token.value,
        lang: lang.value
      );
      Get.snackbar('Logout', 'logout successfully');
      SecureCacheHelper.removeData(key: 'token');
      CacheHelper.removeData(key: 'order');
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar('Error', 'check your connection');
    }
  }

  Future<ProfileModel> getProfile()async{
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    try{
      final response =await DioHelper.getData(url: BackendEndpoint.profile,token: token.value,lang: lang.value);
      final apiResponse =ApiResponse<ProfileModel>.fromJson(response.data,(json) => ProfileModel.fromJson(json as Map<String,dynamic>),);
      return apiResponse.data ?? ProfileModel();
    } catch(e){
      Get.snackbar('Error', 'Failed to retrieve profile data');
      return ProfileModel();
    }  
  }
  Future<List<DayVisits>> getMeVisitData()async{
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    try{
    final meResponse = await DioHelper.getData(
        query: {'type': 'mine'},
        url: BackendEndpoint.visits,
        token: token.value,
        lang: lang.value,
      );
      final meApiResponse = ApiResponse<List<DayVisits>>.fromJson(
        meResponse.data,
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
      return meApiResponse.data?? [];
    }catch(e){
      Get.snackbar('Error', 'Failed to retrieve my visit data');
      return [];
    }
  }
  Future<List<DayVisits>> getAllVisitData(Map<String,dynamic> query)async{
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    try{
      final allResponse = await DioHelper.getData(
        query: query,
        url: BackendEndpoint.visits,
        token: token.value,
        lang: lang.value,
      );
      final allApiResponse = ApiResponse<List<DayVisits>>.fromJson(
        allResponse.data,
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
      return allApiResponse.data ?? [];
    }catch(e){
      Get.snackbar('Error', 'Failed to retrieve all visit data');
      return [];
    }
  }

  Future<int> addVisit(VisitModel visit) async {
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    try {
      var response = await DioHelper.postData(
          url: BackendEndpoint.visits,
          token: token.value,
          data: visit.toJson());
      final apiResponse = ApiResponse<VisitModel>.fromJson(response.data,
          (json) => VisitModel.fromJson(json as Map<String, dynamic>));
      return apiResponse.data?.id?? -1;
    } catch (e) {
      Get.snackbar("Error", 'Failed to add visit');
      return -1;
    }
  }

  Future<List<DayVisits>> getArchivesVisits()async{
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    try{
    final response = await DioHelper.getData(
        url: BackendEndpoint.archive,
        token: token.value,
        lang: lang.value,
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
      return apiResponse.data??[];
    }catch(e){
      Get.snackbar('Error', 'Failed to retrieve archive visits');
      return [];
    }
  }

  Future<void> onDone(int id) async {
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    try {
      await DioHelper.putData(url: '${BackendEndpoint.done}/${id.toString()}',token: token.value,lang: lang.value);
    } catch (e) {
      Get.snackbar('Error', 'Can\'t make visit done');
    }
  }

  Future<void> onInProgress(int id) async {
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    try {
      await DioHelper.putData(
          url: '${BackendEndpoint.inprogress}/${id.toString()}',token: token.value,lang: lang.value);
    } catch (e) {
      Get.snackbar('Error', 'Can\'t make visit inprogress');
    }
  }

  Future<void> onCanceled(int id) async {
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    try {
      await DioHelper.putData(
          url: '${BackendEndpoint.cancel}/${id.toString()}',token: token.value,lang: lang.value);
    } catch (e) {
      Get.snackbar('Error', 'Can\'t make visit inprogress');
    }
  }

  Future<void> onDeylayed(int id) async {
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    try {
      await DioHelper.putData(url: '${BackendEndpoint.delay}/${id.toString()}',token: token.value,lang: lang.value);
    } catch (e) {
      Get.snackbar('Error', 'Can\'t make visit inprogress');
    }
  }

  Map<String, dynamic> toJson(int id) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = id;
    return data;
  }
  
  Future<List<User>> getUserList(int type)async{
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    try{
      final response =await DioHelper.getData(url: BackendEndpoint.dropDown,token: token.value,lang: lang.value,query: toJson(type));
      final apiResponse = ApiResponse<List<User>>.fromJson(response.data,(json) {
        if (json == null) {
          return [];
        }
        return (json as List).map((e) => User.fromJson(e)).toList();
      });

      return apiResponse.data??[];
    }catch(e){
      Get.snackbar('Error', 'Failed to retrieve user list');
      return [];
    }
  }

  Future<void> assignServent(int visitId,int servantId)async{
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    try{
      await DioHelper.putData(url: '${BackendEndpoint.servent}/${visitId.toString()}',data: {'servant_id':servantId},lang: lang.value,token: token.value);
    }catch(e){
      Get.snackbar('Error', 'Failed to assign servant');
    }
  }

  Future<void> assignFather(int visitId,int fatherId)async{
    token.value = (await SecureCacheHelper.getData(key: 'token'))??'';
    lang.value = (await CacheHelper.getData(key: 'lang'))??'en';
    try{
      await DioHelper.putData(url: '${BackendEndpoint.father}/${visitId.toString()}',data: {'father_id':fatherId},lang: lang.value,token: token.value);
    }catch(e){
      Get.snackbar('Error', 'Failed to assign servant');
    }
  }
}
