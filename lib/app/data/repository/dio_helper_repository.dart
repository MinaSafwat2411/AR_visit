import 'package:ar_visiting_app/app/data/repository/dio_helper_repository_interface.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

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

@LazySingleton(as: DioHelperRepositoryInterface)
class DioHelperRepository extends DioHelperRepositoryInterface {

  String token = CacheHelper.getData(key: 'token') ?? '';
  String lang = CacheHelper.getData(key: 'lang') ?? 'ar';


  @override
  Future<ApiResponse<VisitModel>> getVisitData(int id) async {
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
  Future<ApiResponse<void>> addPatient(User patient) async {
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
  Future<ApiResponse<List<DropDown>>> getUserData() async {
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
  Future<ApiResponse<List<DropDown>>> getFatherServantData(int id) async {
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
  Future<ApiResponse<List<AreaModel>>> getAreaData() async {
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
  Future<ApiResponse<VisitModel>> editVisit(VisitModel visit) async {
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
  Future<ApiResponse<LogoutModel>> logout() async {
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
      this.token = '';
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<LogoutModel>(e);
    }
  }

  @override
  Future<ApiResponse<ProfileModel>> getProfile() async {
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
  Future<ApiResponse<List<VisitModel>>> getMeVisitData(int page) async {
    try {
      final response = await DioHelper.getData(
        query: {'page': page, 'me': 1},
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
  Future<ApiResponse<List<VisitModel>>> getReport(int userId, int page) async {
    try {
      final response = await DioHelper.getData(
          url: BackendEndpoint.reports,
          token: token,
          lang: lang,
          query: {'user_id': userId, 'page': page});
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
  Future<ApiResponse<List<VisitModel>>> getAllVisitData(int page) async {
    try {
      final response = await DioHelper.getData(
          url: BackendEndpoint.visits,
          token: token,
          lang: lang,
          query: {'page': page});
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
  Future<ApiResponse<VisitModel>> addVisit(VisitModel visit) async {
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
  Future<ApiResponse<void>> orderVisit(OrderModel order) async {
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
  Future<ApiResponse<List<VisitModel>>> getArchivesVisits(int page) async {
    try {
      final response = await DioHelper.getData(
          url: BackendEndpoint.archive,
          token: token,
          lang: lang,
          query: {'page': page});
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
  Future<ApiResponse<VisitModel>> onDone(int id) async {
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
  Future<ApiResponse<VisitModel>> onInProgress(int id) async {
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
  Future<ApiResponse<VisitModel>> onCanceled(int id) async {
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
  Future<ApiResponse<VisitModel>> onDelayed(int id) async {
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
  Future<ApiResponse<List<User>>> getUserList(int type) async {
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
  Future<ApiResponse<void>> assignServant(int visitId, int servantId) async {
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
  Future<ApiResponse<void>> assignFather(int visitId, int fatherId) async {
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
  Future<ApiResponse<void>> register(RegisterModel register) async {
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
  Future<ApiResponse<UserModel>> login(LoginModel login) async {
    try {
      final response = await DioHelper.postData(
        url: BackendEndpoint.login,
        data: login.toJson(),
      );
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 401) {
        return ApiResponse<UserModel>(
          statusCode: response.statusCode ?? 0,
          message: response.statusMessage ?? '',
          data: null,
        );
      }else{
        var apiResponse = ApiResponse<UserModel>.fromJson(
          response.data,
              (json) => UserModel.fromJson(json as Map<String, dynamic>),
          response.statusCode ?? 0,
          response.statusMessage ?? '',
        );
        CacheHelper.saveData(key: 'token', value: apiResponse.data?.token);
        token = apiResponse.data?.token ?? '';
        return apiResponse;
      }
    } on DioException catch (e) {
      return errorHandler<UserModel>(e);
    }
  }

  @override
  Future<ApiResponse<EnumsModel>> getEnums() async {
    try {
      final response = await DioHelper.getData(
          url: BackendEndpoint.enums, token: token, lang: lang);
      final apiResponse = ApiResponse<EnumsModel>.fromJson(
        response.data,
        (json) => EnumsModel.fromJson(json as Map<String, dynamic>),
        response.statusCode ?? 0,
        response.statusMessage ?? '',
      );
      await CacheHelper.saveEnums(apiResponse.data ?? EnumsModel());
      return apiResponse;
    } on DioException catch (e) {
      return errorHandler<EnumsModel>(e);
    }
  }

  static ApiResponse<T> errorHandler<T>(DioException e) {
    return ApiResponse<T>(
      statusCode: e.response?.statusCode ?? 0,
      message: e.response?.statusMessage ?? '',
      data: null, // Ensure the data matches the expected type
    );
  }

  @override
  String getLang() {
    return lang;
  }

  @override
  bool getTheme() {
    return CacheHelper.getData(key: 'isDark') ?? false;
  }

  @override
  Future<void> setLang(String lang) async{
    this.lang = lang;
    await CacheHelper.saveData(key: 'lang', value: lang);
  }

  @override
  Future<void> setTheme(bool isDark) async{
    await CacheHelper.saveData(key: 'isDark', value: isDark);
  }
}
