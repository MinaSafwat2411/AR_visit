import 'package:ar_visiting_app/app/core/models/api_response/api_response.dart';
import 'package:ar_visiting_app/app/core/models/area/areamodel.dart';
import 'package:ar_visiting_app/app/core/models/login/loginmodel.dart';
import 'package:ar_visiting_app/app/core/models/oder/order_model.dart';
import 'package:ar_visiting_app/app/core/models/profile/profile_model.dart';
import 'package:ar_visiting_app/app/core/models/visits/visitmodel.dart';
import 'package:ar_visiting_app/app/core/services/cache_helper.dart';
import 'package:ar_visiting_app/app/core/services/dio_helper.dart';
import 'package:ar_visiting_app/app/core/utils/backend_endpoint.dart';
import 'package:get/get.dart';

import '../models/register/register_model.dart';

class MainController extends GetxController {
  String changeFormatDB(String date) {
    var newDate = '';
    try {
      newDate =
          '${date.substring(6, 10)}-${date.substring(3, 5)}-${date.substring(0, 2)}';
    } catch (e) {
      Get.snackbar('Error', 'Invalid date format');
    }
    return newDate;
  }

  String changeFormatView(String date) {
    var newDate = '';
    try {
      newDate =
          '${date.substring(0, 2)}-${date.substring(3, 5)}-${date.substring(6, 10)}';
    } catch (e) {
      Get.snackbar('Error', 'Invalid date format');
    }
    return newDate;
  }

  Future<VisitModel> getVisitData(
      String lang, String token, int id) async {
    try {
      final response = await DioHelper.getData(
          url: '${BackendEndpoint.visits}/${id.toString()}',
          token: token,
          lang: lang,
      );
      final apiResponse = ApiResponse<VisitModel>.fromJson(response.data,
          (json) => VisitModel.fromJson(json as Map<String, dynamic>));
      return apiResponse.data ?? VisitModel();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load visit data');
      return VisitModel();
    }
  }

  Future<void> addPatient(String lang, String token, User patient) async {
    try {
      await DioHelper.postData(
          url: BackendEndpoint.patient,
          token: token,
          lang: lang,
          data: patient.toJson());
      Get.snackbar('Success', 'Patient added successfully');
      Get.back(closeOverlays: true);
    } catch (e) {
      Get.snackbar('Error', 'couldn\'t add patient');
    }
  }

  Future<List<DropDown>> getUserData(String lang, String token) async {
    try {
      var responseUsers = await DioHelper.getData(
          url: BackendEndpoint.dropDown, lang: lang, token: token);
      final ApiResponse<List<DropDown>> apiResponseUsers =
          ApiResponse.fromJson(responseUsers.data, (json) {
        if (json == null) {
          return [];
        }
        return (json as List).map((e) => DropDown.fromJson(e)).toList();
      });
      return apiResponseUsers.data ?? [];
    } catch (e) {
      Get.snackbar("Error", "Failed to retrieve Users data");
      return [];
    }
  }
  Future<List<DropDown>> getFatherServantData(String lang, String token,int id) async {
    try {
      var responseUsers = await DioHelper.getData(
          url: BackendEndpoint.dropDown, lang: lang, token: token,
      query: {
            'type': id
      });
      final ApiResponse<List<DropDown>> apiResponseUsers =
      ApiResponse.fromJson(responseUsers.data, (json) {
        if (json == null) {
          return [];
        }
        return (json as List).map((e) => DropDown.fromJson(e)).toList();
      });
      return apiResponseUsers.data ?? [];
    } catch (e) {
      Get.snackbar("Error", "Failed to retrieve Users data");
      return [];
    }
  }

  Future<List<AreaModel>> getAreaData(String lang, String token) async {
    try {
      var responseArea = await DioHelper.getData(
          url: BackendEndpoint.areas, lang: lang, token: token);
      final ApiResponse<List<AreaModel>> apiResponseArea =
          ApiResponse.fromJson(responseArea.data, (json) {
        if (json == null) {
          return [];
        }
        return (json as List).map((e) => AreaModel.fromJson(e)).toList();
      });
      return apiResponseArea.data ?? [];
    } catch (e) {
      Get.snackbar("Error", "Failed to retrieve area details");
      return [];
    }
  }

  Future<VisitModel> editVisit(
      String lang, String token, VisitModel visit) async {
    try {
      final response = await DioHelper.putData(
          url: '${BackendEndpoint.visits}/${visit.id.toString()}',
          token: token,
          data: visit.toJsonEdit(),
          lang: lang);
      final apiResponse = ApiResponse<VisitModel>.fromJson(
        response.data,
        (json) => VisitModel.fromJson(json as Map<String, dynamic>),
      );
      Get.snackbar("Visits", "Visit add successfully");
      return apiResponse.data ?? VisitModel();
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return VisitModel();
    }
  }

  void logout(String lang, String token) async {
    try {
      await DioHelper.postData(
          url: BackendEndpoint.logout, token: token, lang: lang);
      Get.snackbar('Logout', 'logout successfully');
      CacheHelper.removeData(key: 'token');
      CacheHelper.removeData(key: 'order');
    } catch (e) {
      Get.snackbar('Error', 'check your connection');
    }
  }

  Future<ProfileModel> getProfile(String lang, String token) async {
    try {
      final response = await DioHelper.getData(
          url: BackendEndpoint.profile, token: token, lang: lang);
      final apiResponse = ApiResponse<ProfileModel>.fromJson(
        response.data,
        (json) => ProfileModel.fromJson(json as Map<String, dynamic>),
      );
      return apiResponse.data ?? ProfileModel();
    } catch (e) {
      Get.snackbar('Error', 'Failed to retrieve profile data');
      return ProfileModel();
    }
  }

  Future<List<VisitModel>> getMeVisitData(String lang, String token,Map<String,dynamic> q) async {
    try {
      final meResponse = await DioHelper.getData(
        query: q,
        url: BackendEndpoint.visits,
        token: token,
        lang: lang,
      );
      final meApiResponse = ApiResponse<List<VisitModel>>.fromJson(
        meResponse.data,
        (json) {
          if (json == null) {
            return [];
          }
          return (json as List).map((e) => VisitModel.fromJson(e)).toList();
        },
      );
      return meApiResponse.data ?? [];
    } catch (e) {
      Get.snackbar('Error', 'Failed to retrieve my visit data');
      return [];
    }
  }

  Future<List<VisitModel>> getReport(String lang, String token, int id,Map<String,dynamic> q) async {
    try {
      final response = await DioHelper.getData(
          url: BackendEndpoint.reports,
          token: token,
          lang: lang,
          query: q);
      final apiResponse = ApiResponse<List<VisitModel>>.fromJson(
        response.data,
        (json) {
          if (json == null) {
            return [];
          }
          return (json as List).map((e) => VisitModel.fromJson(e)).toList();
        },
      );
      return apiResponse.data ?? [];
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'Failed to retrieve report data');
      return [];
    }
  }

  Future<List<VisitModel>> getAllVisitData(String lang, String token,Map<String, dynamic> q) async {
    try {
      final allResponse = await DioHelper.getData(
        url: BackendEndpoint.visits,
        token: token,
        lang: lang,
        query: q
      );
      final allApiResponse = ApiResponse<List<VisitModel>>.fromJson(
        allResponse.data,
        (json) {
          if (json == null) {
            return [];
          }
          return (json as List).map((e) => VisitModel.fromJson(e)).toList();
        },
      );
      return allApiResponse.data ?? [];
    } catch (e) {
      Get.snackbar('Error', 'Failed to retrieve all visit data');
      return [];
    }
  }

  Future<VisitModel> addVisit(
      String lang, String token, VisitModel visit) async {
    visit.date = changeFormatDB(visit.date ?? '');
    try {
      var response = await DioHelper.postData(
          url: BackendEndpoint.visits,
          token: token,
          lang: lang,
          data: visit.toJson());
      final apiResponse = ApiResponse<VisitModel>.fromJson(response.data,
          (json) => VisitModel.fromJson(json as Map<String, dynamic>));
      return apiResponse.data ?? VisitModel();
    } catch (e) {
      Get.snackbar("Error", 'Failed to add visit');
      return VisitModel();
    }
  }

  Future<void> orderVisit(String lang, String token, OrderModel order) async {
    try {
      await DioHelper.putData(
        url: BackendEndpoint.order,
        lang: lang,
        data: order.toJson(),
        token: token,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to order visits');
    }
  }

  Future<List<VisitModel>> getArchivesVisits(String lang, String token,Map<String, dynamic> q) async {
    try {
      final response = await DioHelper.getData(
        url: BackendEndpoint.archive,
        token: token,
        lang: lang,
        query: q
      );
      final apiResponse = ApiResponse<List<VisitModel>>.fromJson(
        response.data,
        (json) {
          if (json == null) {
            return [];
          }
          return (json as List).map((e) => VisitModel.fromJson(e)).toList();
        },
      );
      return apiResponse.data ?? [];
    } catch (e) {
      Get.snackbar('Error', 'Failed to retrieve archive visits');
      return [];
    }
  }

  Future<void> onDone(String lang, String token, int id) async {
    try {
      await DioHelper.putData(
          url: '${BackendEndpoint.done}/${id.toString()}',
          token: token,
          lang: lang);
    } catch (e) {
      Get.snackbar('Error', 'Can\'t make visit done');
    }
  }

  Future<void> onInProgress(String lang, String token, int id) async {
    try {
      await DioHelper.putData(
          url: '${BackendEndpoint.inprogress}/${id.toString()}',
          token: token,
          lang: lang);
    } catch (e) {
      Get.snackbar('Error', 'Can\'t make visit inprogress');
    }
  }

  Future<void> onCanceled(String lang, String token, int id) async {
    try {
      await DioHelper.putData(
          url: '${BackendEndpoint.cancel}/${id.toString()}',
          token: token,
          lang: lang);
    } catch (e) {
      Get.snackbar('Error', 'Can\'t make visit inprogress');
    }
  }

  Future<void> onDelayed(String lang, String token, int id) async {
    try {
      await DioHelper.putData(
          url: '${BackendEndpoint.delay}/${id.toString()}',
          token: token,
          lang: lang);
    } catch (e) {
      Get.snackbar('Error', 'Can\'t make visit inprogress');
    }
  }

  Map<String, dynamic> toJson(int id) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = id;
    return data;
  }

  Future<List<User>> getUserList(String lang, String token, int type) async {
    try {
      final response = await DioHelper.getData(
          url: BackendEndpoint.dropDown,
          token: token,
          lang: lang,
          query: toJson(type));
      final apiResponse =
          ApiResponse<List<User>>.fromJson(response.data, (json) {
        if (json == null) {
          return [];
        }
        return (json as List).map((e) => User.fromJson(e)).toList();
      });

      return apiResponse.data ?? [];
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'Failed to retrieve user list');
      return [];
    }
  }

  Future<void> assignServant(
      String lang, String token, int visitId, int servantId) async {
    try {
      await DioHelper.putData(
          url: '${BackendEndpoint.servent}/${visitId.toString()}',
          data: {'servant_id': servantId},
          lang: lang,
          token: token);
    } catch (e) {
      Get.snackbar('Error', 'Failed to assign servant');
    }
  }

  Future<void> assignFather(
      String lang, String token, int visitId, int fatherId) async {
    try {
      await DioHelper.putData(
          url: '${BackendEndpoint.father}/${visitId.toString()}',
          data: {'father_id': fatherId},
          lang: lang,
          token: token);
    } catch (e) {
      Get.snackbar('Error', 'Failed to assign servant');
    }
  }

  Future<void> register(String lang, RegisterModel register) async {
    try {
      await DioHelper.postData(
          url: BackendEndpoint.register, lang: 'en', data: register.toJson());
    } catch (e) {
      Get.snackbar('Error', 'Failed to register');
    }
  }
}
