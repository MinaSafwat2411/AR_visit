import 'package:ar_visiting_app/app/data/repository/dio_helper_repository_interface.dart';
import 'package:dio/dio.dart';

import '../../core/services/cache_helper.dart';
import '../../core/services/dio_helper.dart';
import '../../core/utils/backend_endpoint.dart';
import '../models/api_response/api_response.dart';
import '../models/area/areamodel.dart';
import '../models/enums/enums.dart';
import '../models/login/loginmodel.dart';
import '../models/logout/logout_model.dart';
import '../models/oder/order_model.dart';
import '../models/profile/profile_model.dart';
import '../models/register/register_model.dart';
import '../models/visits/visitmodel.dart';

class DioHelperRepository extends DioHelperRepositoryInterface {

  static final DioHelperRepository _instance = DioHelperRepository();
  static DioHelperRepository get repository => _instance;



  @override
  Future<ApiResponse<VisitModel>> getVisitData(
      String lang, String token, int id) async {
    try {
      final response = await DioHelper.getData(
        url: '${BackendEndpoint.visits}/${id.toString()}',
        token: token,
        lang: lang,
      );
      final apiResponse = ApiResponse<VisitModel>.fromJson(
        response.data,
        (json) => VisitModel.fromJson(json as Map<String, dynamic>),
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<VisitModel>(e);
    }
  }

  @override
  Future<ApiResponse<void>> addPatient(
      String lang, String token, User patient) async {
    try {
      final response = await DioHelper.postData(
          url: BackendEndpoint.patient,
          token: token,
          lang: lang,
          data: patient.toJson());
      final apiResponse = ApiResponse<ProfileModel>.fromJson(
        response.data,
        (json) => ProfileModel.fromJson(json as Map<String, dynamic>),
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<ProfileModel>(e);
    }
  }

  @override
  Future<ApiResponse<List<DropDown>>> getUserData(
      String lang, String token) async {
    try {
      var response = await DioHelper.getData(
          url: BackendEndpoint.dropDown, lang: lang, token: token);
      final ApiResponse<List<DropDown>> apiResponse = ApiResponse.fromJson(
        response.data,
        (json) {
          if (json == null) {
            return [];
          }
          return (json as List).map((e) => DropDown.fromJson(e)).toList();
        },
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<List<DropDown>>(e);
    }
  }

  @override
  Future<ApiResponse<List<DropDown>>> getFatherServantData(
      String lang, String token, int id) async {
    try {
      var response = await DioHelper.getData(
          url: BackendEndpoint.dropDown,
          lang: lang,
          token: token,
          query: {'type': id});
      final ApiResponse<List<DropDown>> apiResponse = ApiResponse.fromJson(
        response.data,
        (json) {
          if (json == null) {
            return [];
          }
          return (json as List).map((e) => DropDown.fromJson(e)).toList();
        },
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<List<DropDown>>(e);
    }
  }

  @override
  Future<ApiResponse<List<AreaModel>>> getAreaData(
      String lang, String token) async {
    try {
      var response = await DioHelper.getData(
          url: BackendEndpoint.areas, lang: lang, token: token);
      final ApiResponse<List<AreaModel>> apiResponse = ApiResponse.fromJson(
        response.data,
        (json) {
          if (json == null) {
            return [];
          }
          return (json as List).map((e) => AreaModel.fromJson(e)).toList();
        },
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<List<AreaModel>>(e);
    }
  }

  @override
  Future<ApiResponse<VisitModel>> editVisit(
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
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<VisitModel>(e);
    }
  }

  @override
  Future<ApiResponse<LogoutModel>> logout(String lang, String token) async {
    try {
      final response = await DioHelper.postData(
          url: BackendEndpoint.logout, token: token, lang: lang);
      final apiResponse = ApiResponse<LogoutModel>.fromJson(
        response.data,
        (json) => LogoutModel.fromJson(json as Map<String, dynamic>),
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      CacheHelper.removeData(key: 'token');
      CacheHelper.removeData(key: 'order');
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<LogoutModel>(e);
    }
  }

  @override
  Future<ApiResponse<ProfileModel>> getProfile(
      String lang, String token) async {
    try {
      final response = await DioHelper.getData(
          url: BackendEndpoint.profile, token: token, lang: lang);
      final apiResponse = ApiResponse<ProfileModel>.fromJson(
        response.data,
        (json) => ProfileModel.fromJson(json as Map<String, dynamic>),
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<ProfileModel>(e);
    }
  }

  @override
  Future<ApiResponse<List<VisitModel>>> getMeVisitData(
      String lang, String token, int page) async {
    try {
      final response = await DioHelper.getData(
        query: {
          'page': page,
          'me': 1
        },
        url: BackendEndpoint.visits,
        token: token,
        lang: lang,
      );
      final apiResponse = ApiResponse<List<VisitModel>>.fromJson(
        response.data,
        (json) {
          if (json == null) {
            return [];
          }
          return (json as List).map((e) => VisitModel.fromJson(e)).toList();
        },
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<List<VisitModel>>(e);
    }
  }

  @override
  Future<ApiResponse<List<VisitModel>>> getReport(
      String lang, String token ,int userId,int page) async {
    try {
      final response = await DioHelper.getData(
          url: BackendEndpoint.reports, token: token, lang: lang, query: {'user_id': userId,
      'page': page});
      final apiResponse = ApiResponse<List<VisitModel>>.fromJson(
        response.data,
        (json) {
          if (json == null) {
            return [];
          }
          return (json as List).map((e) => VisitModel.fromJson(e)).toList();
        },
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<List<VisitModel>>(e);
    }
  }

  @override
  Future<ApiResponse<List<VisitModel>>> getAllVisitData(
      String lang, String token, int page) async {
    try {
      final response = await DioHelper.getData(
          url: BackendEndpoint.visits, token: token, lang: lang, query: {'page': page});
      final apiResponse = ApiResponse<List<VisitModel>>.fromJson(
        response.data,
        (json) {
          if (json == null) {
            return [];
          }
          return (json as List).map((e) => VisitModel.fromJson(e)).toList();
        },
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<List<VisitModel>>(e);
    }
  }

  @override
  Future<ApiResponse<VisitModel>> addVisit(
      String lang, String token, VisitModel visit) async {
    try {
      var response = await DioHelper.postData(
          url: BackendEndpoint.visits,
          token: token,
          lang: lang,
          data: visit.toJson());
      final apiResponse = ApiResponse<VisitModel>.fromJson(
        response.data,
        (json) => VisitModel.fromJson(json as Map<String, dynamic>),
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<VisitModel>(e);
    }
  }

  @override
  Future<ApiResponse<void>> orderVisit(
      String lang, String token, OrderModel order) async {
    try {
      final response = await DioHelper.putData(
        url: BackendEndpoint.order,
        lang: lang,
        data: order.toJson(),
        token: token,
      );
      final apiResponse = ApiResponse.fromJson(
        response.data,
        (json) => json,
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<void>(e);
    }
  }

  @override
  Future<ApiResponse<List<VisitModel>>> getArchivesVisits(
      String lang, String token, int page) async {
    try {
      final response = await DioHelper.getData(
          url: BackendEndpoint.archive, token: token, lang: lang, query: {'page': page});
      final apiResponse = ApiResponse<List<VisitModel>>.fromJson(
        response.data,
        (json) {
          if (json == null) {
            return [];
          }
          return (json as List).map((e) => VisitModel.fromJson(e)).toList();
        },
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<List<VisitModel>>(e);
    }
  }

  @override
  Future<ApiResponse<VisitModel>> onDone(
      String lang, String token, int id) async {
    try {
      final response = await DioHelper.putData(
          url: '${BackendEndpoint.done}/${id.toString()}',
          token: token,
          lang: lang);
      final apiResponse = ApiResponse<VisitModel>.fromJson(
        response.data,
        (json) => VisitModel.fromJson(json as Map<String, dynamic>),
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<VisitModel>(e);
    }
  }

  @override
  Future<ApiResponse<VisitModel>> onInProgress(
      String lang, String token, int id) async {
    try {
      final response = await DioHelper.putData(
          url: '${BackendEndpoint.inProgress}/${id.toString()}',
          token: token,
          lang: lang);
      final apiResponse = ApiResponse<VisitModel>.fromJson(
        response.data,
        (json) => VisitModel.fromJson(json as Map<String, dynamic>),
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<VisitModel>(e);
    }
  }

  @override
  Future<ApiResponse<VisitModel>> onCanceled(
      String lang, String token, int id) async {
    try {
      final response = await DioHelper.putData(
          url: '${BackendEndpoint.cancel}/${id.toString()}',
          token: token,
          lang: lang);
      final apiResponse = ApiResponse<VisitModel>.fromJson(
        response.data,
        (json) => VisitModel.fromJson(json as Map<String, dynamic>),
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<VisitModel>(e);
    }
  }

  @override
  Future<ApiResponse<VisitModel>> onDelayed(
      String lang, String token, int id) async {
    try {
      final response = await DioHelper.putData(
          url: '${BackendEndpoint.delay}/${id.toString()}',
          token: token,
          lang: lang);
      final apiResponse = ApiResponse<VisitModel>.fromJson(
        response.data,
        (json) => VisitModel.fromJson(json as Map<String, dynamic>),
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<VisitModel>(e);
    }
  }

  @override
  Future<ApiResponse<List<User>>> getUserList(
      String lang, String token, int type) async {
    try {
      final response = await DioHelper.getData(
          url: BackendEndpoint.dropDown,
          token: token,
          lang: lang,
          query: {'type': type});
      final apiResponse = ApiResponse<List<User>>.fromJson(
        response.data,
        (json) {
          if (json == null) {
            return [];
          }
          return (json as List).map((e) => User.fromJson(e)).toList();
        },
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );

      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<List<User>>(e);
    }
  }

  @override
  Future<ApiResponse<void>> assignServant(
      String lang, String token, int visitId, int servantId) async {
    try {
      final response = await DioHelper.putData(
          url: '${BackendEndpoint.servant}/${visitId.toString()}',
          data: {'servant_id': servantId},
          lang: lang,
          token: token);
      final apiResponse = ApiResponse.fromJson(
        response.data,
        (json) => json,
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<void>(e);
    }
  }

  @override
  Future<ApiResponse<void>> assignFather(
      String lang, String token, int visitId, int fatherId) async {
    try {
      final response = await DioHelper.putData(
          url: '${BackendEndpoint.father}/${visitId.toString()}',
          data: {'father_id': fatherId},
          lang: lang,
          token: token);
      final apiResponse = ApiResponse.fromJson(
        response.data,
        (json) => json,
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<void>(e);
    }
  }

  @override
  Future<ApiResponse<void>> register(
      String lang, RegisterModel register) async {
    try {
      final response = await DioHelper.postData(
          url: BackendEndpoint.register, lang: 'en', data: register.toJson());
      final apiResponse = ApiResponse.fromJson(
        response.data,
        (json) => json,
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<void>(e);
    }
  }

  @override
  Future<ApiResponse<UserModel>> login(String lang, LoginModel login) async {
    try {
      final response = await DioHelper.postData(
        url: BackendEndpoint.login,
        data: login.toJson(),
      );
      var apiResponse = ApiResponse<UserModel>.fromJson(
        response.data,
        (json) => UserModel.fromJson(json as Map<String, dynamic>),
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      CacheHelper.saveData(key: 'token', value: apiResponse.data?.token);
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<UserModel>(e);
    }
  }

  @override
  Future<ApiResponse<EnumsModel>> getEnums(String lang, String token) async {
    try {
      final response = await DioHelper.getData(
          url: BackendEndpoint.enums, token: token, lang: lang);
      final apiResponse = ApiResponse<EnumsModel>.fromJson(
        response.data,
        (json) => EnumsModel.fromJson(json as Map<String, dynamic>),
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<EnumsModel>(e);
    }
  }

  static ApiResponse<T> errorHandler<T>(DioException e) {
    return ApiResponse<T>(
      statusCode: e.response?.statusCode?? 0,
      message: e.response?.statusMessage?? '',
      data: null, // Ensure the data matches the expected type
    );
  }
}
