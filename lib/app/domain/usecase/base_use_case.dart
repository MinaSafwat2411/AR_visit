import 'package:ar_visiting_app/app/data/models/area/areamodel.dart';
import 'package:ar_visiting_app/app/data/models/enums/enums.dart';
import 'package:ar_visiting_app/app/data/models/login/loginmodel.dart';
import 'package:ar_visiting_app/app/data/models/logout/logout_model.dart';
import 'package:ar_visiting_app/app/data/models/oder/order_model.dart';
import 'package:ar_visiting_app/app/data/models/profile/profile_model.dart';
import 'package:ar_visiting_app/app/data/models/register/register_model.dart';
import 'package:ar_visiting_app/app/data/models/visits/visitmodel.dart';
import 'package:ar_visiting_app/app/domain/usecase/base_use_case_interface.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import '../../data/repository/dio_helper_repository_interface.dart';
import '../../routes/app_pages.dart';

@LazySingleton(as: BaseUseCaseInterface)
class BaseUseCase implements BaseUseCaseInterface {
  final DioHelperRepositoryInterface repository;

  BaseUseCase({required this.repository});

  @override
  Future<void> addPatient(User patient) async {
    final useCase = await repository.addPatient(patient);
  }

  @override
  Future<VisitModel?> addVisit(
      VisitModel visit) async {
    final useCase = await repository.addVisit(visit);
    return useCase.data;
  }

  @override
  Future<void> assignFather(
      int visitId, int fatherId) async {
    final useCase =
        await repository.assignFather(visitId, fatherId);
  }

  @override
  Future<void> assignServant(
      int visitId, int servantId) async {
    final useCase =
        await repository.assignServant(visitId, servantId);
  }

  @override
  Future<VisitModel?> editVisit(
      VisitModel visit) async {
    final useCase = await repository.editVisit(visit);
    return useCase.data;
  }

  @override
  Future<List<VisitModel>?> getAllVisitData(
      int page) async {
    final useCase = await repository.getAllVisitData(page);
    return useCase.data;
  }

  @override
  Future<List<VisitModel>?> getArchivesVisits(
      int page) async {
    final useCase = await repository.getArchivesVisits(page);
    return useCase.data;
  }

  @override
  Future<List<AreaModel>?> getAreaData() async {
    final useCase = await repository.getAreaData();
    return useCase.data;
  }

  @override
  Future<EnumsModel?> getEnums() async {
    final useCase = await repository.getEnums();
    return useCase.data;
  }

  @override
  Future<List<DropDown>?> getFatherServantData(
      int id) async {
    final useCase = await repository.getFatherServantData(id);
    return useCase.data;
  }

  @override
  Future<List<VisitModel>?> getMeVisitData(
      int page) async {
    final useCase = await repository.getMeVisitData(page);
    return useCase.data;
  }

  @override
  Future<ProfileModel?> getProfile() async {
    final useCase = await repository.getProfile();
    return useCase.data;
  }

  @override
  Future<List<VisitModel>?> getReport(
      int userId, int page) async {
    final useCase = await repository.getReport(userId, page);
    return useCase.data;
  }

  @override
  Future<List<DropDown>?> getUserData() async {
    final useCase = await repository.getUserData();
    return useCase.data;
  }

  @override
  Future<List<User>?> getUserList(int type) async {
    final useCase = await repository.getUserList(type);
    return useCase.data;
  }

  @override
  Future<VisitModel?> getVisitData(int id) async {
    final useCase = await repository.getVisitData(id);
    return useCase.data;
  }

  @override
  Future<UserModel?> login(LoginModel login) async {
    final useCase = await repository.login(login);
    return useCase.data;
  }

  @override
  Future<LogoutModel?> logout() async {
    final useCase = await repository.logout();
    return useCase.data;
  }

  @override
  Future<VisitModel?> onCanceled(int id) async {
    final useCase = await repository.onCanceled(id);
    return useCase.data;
  }

  @override
  Future<VisitModel?> onDelayed(int id) async {
    final useCase = await repository.onDelayed(id);
    return useCase.data;
  }

  @override
  Future<VisitModel?> onDone(int id) async {
    final useCase = await repository.onDone(id);
    return useCase.data;
  }

  @override
  Future<VisitModel?> onInProgress(int id) async {
    final useCase = await repository.onInProgress(id);
    return useCase.data;
  }

  @override
  Future<void> orderVisit(OrderModel order) async {
    final useCase = await repository.orderVisit(order);
  }

  @override
  Future<void> register(RegisterModel register) async {
    final useCase = await repository.register(register);
  }


  @override
  String changeFormatDB(String date) {
    var newDate = '';
    try {
      newDate =
          '${date.substring(6, 10)}-${date.substring(3, 5)}-${date.substring(0, 2)}';
    } catch (e) {
      throw Exception('Invalid date format');
    }
    return newDate;
  }

  @override
  String changeFormatView(String date) {
    var newDate = '';
    try {
      newDate =
          '${date.substring(0, 2)}-${date.substring(3, 5)}-${date.substring(6, 10)}';
    } catch (e) {
      throw Exception('Invalid date format');
    }
    return newDate;
  }

  @override
  String getLang() {
    return repository.getLang();
  }

  @override
  bool getTheme() {
    return repository.getTheme();
  }

  @override
  Future<void> setLang(String lang) async{
    await repository.setLang(lang);
  }

  @override
  Future<void> setTheme(bool isDark) async{
    await repository.setTheme(isDark);
  }
}
