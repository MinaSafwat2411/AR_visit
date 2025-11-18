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

  Future<ApiResponse<VisitModel>> getVisitData(int id);

  Future<ApiResponse<void>> addPatient(User patient);

  Future<ApiResponse<List<DropDown>>> getUserData();

  Future<ApiResponse<List<DropDown>>> getFatherServantData(int id);

  Future<ApiResponse<List<AreaModel>>> getAreaData();

  Future<ApiResponse<VisitModel>> editVisit(VisitModel visit);

  Future<ApiResponse<LogoutModel>> logout();

  Future<ApiResponse<ProfileModel>> getProfile();

  Future<ApiResponse<List<VisitModel>>> getMeVisitData(int page);

  Future<ApiResponse<List<VisitModel>>> getReport(int id,int page);

  Future<ApiResponse<List<VisitModel>>> getAllVisitData(int page);

  Future<ApiResponse<VisitModel>> addVisit(VisitModel visit);

  Future<ApiResponse<void>> orderVisit(OrderModel order);

  Future<ApiResponse<List<VisitModel>>> getArchivesVisits(int page);

  Future<ApiResponse<VisitModel>> onDone(int id);

  Future<ApiResponse<VisitModel>> onInProgress(int id);

  Future<ApiResponse<VisitModel>> onCanceled(int id);

  Future<ApiResponse<VisitModel>> onDelayed(int id);

  Future<ApiResponse<List<User>>> getUserList(int type);

  Future<ApiResponse<void>> assignServant(int visitId,int servantId);

  Future<ApiResponse<void>> assignFather(int visitId,int fatherId);

  Future<ApiResponse<void>> register(RegisterModel register);

  Future<ApiResponse<UserModel>> login(LoginModel login);

  Future<ApiResponse<EnumsModel>> getEnums();

  bool getTheme();

  String getLang();

  Future<void> setLang(String lang);

  Future<void> setTheme(bool isDark);
}