import '../models/api_response/api_response.dart';
import '../models/area/areamodel.dart';
import '../models/enums/enums.dart';
import '../models/login/loginmodel.dart';
import '../models/logout/logout_model.dart';
import '../models/oder/order_model.dart';
import '../models/profile/profile_model.dart';
import '../models/register/register_model.dart';
import '../models/visits/visitmodel.dart';

abstract class DioHelperRepositoryInterface {

  Future<ApiResponse<VisitModel>> getVisitData(String lang, String token, int id);

  Future<ApiResponse<void>> addPatient(String lang, String token, User patient);

  Future<ApiResponse<List<DropDown>>> getUserData(String lang, String token);

  Future<ApiResponse<List<DropDown>>> getFatherServantData(String lang, String token,int id);

  Future<ApiResponse<List<AreaModel>>> getAreaData(String lang, String token);

  Future<ApiResponse<VisitModel>> editVisit(String lang, String token, VisitModel visit);

  Future<ApiResponse<LogoutModel>> logout(String lang, String token);

  Future<ApiResponse<ProfileModel>> getProfile(String lang, String token);

  Future<ApiResponse<List<VisitModel>>> getMeVisitData(String lang, String token,int page);

  Future<ApiResponse<List<VisitModel>>> getReport(String lang, String token, int id,int page);

  Future<ApiResponse<List<VisitModel>>> getAllVisitData(String lang, String token,int page);

  Future<ApiResponse<VisitModel>> addVisit(String lang, String token, VisitModel visit);

  Future<ApiResponse<void>> orderVisit(String lang, String token, OrderModel order);

  Future<ApiResponse<List<VisitModel>>> getArchivesVisits(String lang, String token,int page);

  Future<ApiResponse<VisitModel>> onDone(String lang, String token, int id);

  Future<ApiResponse<VisitModel>> onInProgress(String lang, String token, int id);

  Future<ApiResponse<VisitModel>> onCanceled(String lang, String token, int id);

  Future<ApiResponse<VisitModel>> onDelayed(String lang, String token, int id);

  Future<ApiResponse<List<User>>> getUserList(String lang, String token, int type);

  Future<ApiResponse<void>> assignServant(String lang, String token, int visitId, int servantId);

  Future<ApiResponse<void>> assignFather(String lang, String token, int visitId, int fatherId);

  Future<ApiResponse<void>> register(String lang, RegisterModel register);

  Future<ApiResponse<UserModel>> login(String lang, LoginModel login);

  Future<ApiResponse<EnumsModel>> getEnums(String lang, String token);
}