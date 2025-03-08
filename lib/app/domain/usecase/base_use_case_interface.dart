import '../../data/models/area/areamodel.dart';
import '../../data/models/enums/enums.dart';
import '../../data/models/login/loginmodel.dart';
import '../../data/models/oder/order_model.dart';
import '../../data/models/profile/profile_model.dart';
import '../../data/models/register/register_model.dart';
import '../../data/models/visits/visitmodel.dart';

abstract class BaseUseCaseInterface {
  Future<VisitModel?> getVisitData(String lang, String token, int id);

  Future<void> addPatient(String lang, String token, User patient);

  Future<List<DropDown>?> getUserData(String lang, String token);

  Future<List<DropDown>?> getFatherServantData(String lang, String token,int id);

  Future<List<AreaModel>?> getAreaData(String lang, String token);

  Future<VisitModel?> editVisit(String lang, String token, VisitModel visit);

  Future<void> logout(String lang, String token);

  Future<ProfileModel?> getProfile(String lang, String token);

  Future<List<VisitModel>?> getMeVisitData(String lang, String token,int page);

  Future<List<VisitModel>?> getReport(String lang, String token, int id);

  Future<List<VisitModel>?> getAllVisitData(String lang, String token,int page);

  Future<VisitModel?> addVisit(String lang, String token, VisitModel visit);

  Future<void> orderVisit(String lang, String token, OrderModel order);

  Future<List<VisitModel>?> getArchivesVisits(String lang, String token,int page);

  Future<VisitModel?> onDone(String lang, String token, int id);

  Future<VisitModel?> onInProgress(String lang, String token, int id);

  Future<VisitModel?> onCanceled(String lang, String token, int id);

  Future<VisitModel?> onDelayed(String lang, String token, int id);

  Future<List<User>?> getUserList(String lang, String token, int type);

  Future<void> assignServant(String lang, String token, int visitId, int servantId);

  Future<void> assignFather(String lang, String token, int visitId, int fatherId);

  Future<void> register(String lang, RegisterModel register);

  Future<UserModel?> login(String lang, LoginModel login);

  Future<EnumsModel?> getEnums(String lang, String token);

  String changeFormatDB(String date);

  String changeFormatView(String date);
}