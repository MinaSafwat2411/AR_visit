import '../../data/models/area/areamodel.dart';
import '../../data/models/enums/enums.dart';
import '../../data/models/login/loginmodel.dart';
import '../../data/models/oder/order_model.dart';
import '../../data/models/profile/profile_model.dart';
import '../../data/models/register/register_model.dart';
import '../../data/models/visits/visitmodel.dart';

abstract class BaseUseCaseInterface {
  Future<VisitModel?> getVisitData( int id);

  Future<void> addPatient( User patient);

  Future<List<DropDown>?> getUserData();

  Future<List<DropDown>?> getFatherServantData(int id);

  Future<List<AreaModel>?> getAreaData();

  Future<VisitModel?> editVisit( VisitModel visit);

  Future<void> logout();

  Future<ProfileModel?> getProfile();

  Future<List<VisitModel>?> getMeVisitData(int page);

  Future<List<VisitModel>?> getReport( int id,int page);

  Future<List<VisitModel>?> getAllVisitData(int page);

  Future<VisitModel?> addVisit( VisitModel visit);

  Future<void> orderVisit( OrderModel order);

  Future<List<VisitModel>?> getArchivesVisits(int page);

  Future<VisitModel?> onDone( int id);

  Future<VisitModel?> onInProgress( int id);

  Future<VisitModel?> onCanceled( int id);

  Future<VisitModel?> onDelayed( int id);

  Future<List<User>?> getUserList( int type);

  Future<void> assignServant( int visitId, int servantId);

  Future<void> assignFather( int visitId, int fatherId);

  Future<void> register( RegisterModel register);

  Future<UserModel?> login( LoginModel login);

  Future<EnumsModel?> getEnums();

  String changeFormatDB(String date);

  String changeFormatView(String date);
}