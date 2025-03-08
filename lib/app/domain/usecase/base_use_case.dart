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
import '../../data/repository/dio_helper_repository.dart';
import '../../routes/app_pages.dart';

class BaseUseCase extends BaseUseCaseInterface {
  final DioHelperRepository repository;

  BaseUseCase({required this.repository});

  @override
  Future<void> addPatient(
      String lang, String token, User patient) async {
    final useCase = await repository.addPatient(lang, token, patient);
    errorHandle(useCase.statusCode, useCase.message);
  }

  @override
  Future<VisitModel?> addVisit(
      String lang, String token, VisitModel visit) async {
    final useCase = await repository.addVisit(lang, token, visit);
    errorHandle(useCase.statusCode, useCase.message);
    return useCase.data;
  }

  @override
  Future<void> assignFather(
      String lang, String token, int visitId, int fatherId) async {
    final useCase =
        await repository.assignFather(lang, token, visitId, fatherId);
    errorHandle(useCase.statusCode, useCase.message);
  }

  @override
  Future<void> assignServant(
      String lang, String token, int visitId, int servantId) async {
    final useCase =
        await repository.assignServant(lang, token, visitId, servantId);
    errorHandle(useCase.statusCode, useCase.message);
  }

  @override
  Future<VisitModel?> editVisit(
      String lang, String token, VisitModel visit) async {
    final useCase = await repository.editVisit(lang, token, visit);
    errorHandle(useCase.statusCode, useCase.message);
    return useCase.data;
  }

  @override
  Future<List<VisitModel>?> getAllVisitData(
      String lang, String token, int page) async {
    final useCase = await repository.getAllVisitData(lang, token, page);
    errorHandle(useCase.statusCode, useCase.message);
    return useCase.data;
  }

  @override
  Future<List<VisitModel>?> getArchivesVisits(
      String lang, String token, int page) async {
    final useCase = await repository.getArchivesVisits(lang, token, page);
    errorHandle(useCase.statusCode, useCase.message);
    return useCase.data;
  }

  @override
  Future<List<AreaModel>?> getAreaData(String lang, String token) async {
    final useCase = await repository.getAreaData(lang, token);
    errorHandle(useCase.statusCode, useCase.message);
    return useCase.data;
  }

  @override
  Future<EnumsModel?> getEnums(String lang, String token) async {
    final useCase = await repository.getEnums(lang, token);
    errorHandle(useCase.statusCode, useCase.message);
    return useCase.data;
  }

  @override
  Future<List<DropDown>?> getFatherServantData(
      String lang, String token, int id) async {
    final useCase = await repository.getFatherServantData(lang, token, id);
    errorHandle(useCase.statusCode, useCase.message);
    return useCase.data;
  }

  @override
  Future<List<VisitModel>?> getMeVisitData(
      String lang, String token, int page) async {
    final useCase = await repository.getMeVisitData(lang, token, page);
    errorHandle(useCase.statusCode, useCase.message);
    return useCase.data;
  }

  @override
  Future<ProfileModel?> getProfile(String lang, String token) async {
    final useCase = await repository.getProfile(lang, token);
    errorHandle(useCase.statusCode, useCase.message);
    return useCase.data;
  }

  @override
  Future<List<VisitModel>?> getReport(
      String lang, String token, int userId,int page) async {
    final useCase = await repository.getReport(lang, token, userId,page);
    errorHandle(useCase.statusCode, useCase.message);
    return useCase.data;
  }

  @override
  Future<List<DropDown>?> getUserData(String lang, String token) async {
    final useCase = await repository.getUserData(lang, token);
    errorHandle(useCase.statusCode, useCase.message);
    return useCase.data;
  }

  @override
  Future<List<User>?> getUserList(String lang, String token, int type) async {
    final useCase = await repository.getUserList(lang, token, type);
    errorHandle(useCase.statusCode, useCase.message);
    return useCase.data;
  }

  @override
  Future<VisitModel?> getVisitData(String lang, String token, int id) async {
    final useCase = await repository.getVisitData(lang, token, id);
    errorHandle(useCase.statusCode, useCase.message);
    return useCase.data;
  }

  @override
  Future<UserModel?> login(String lang, LoginModel login) async {
    final useCase = await repository.login(lang, login);
    errorHandle(useCase.statusCode, useCase.message);
    return useCase.data;
  }

  @override
  Future<LogoutModel?> logout(String lang, String token) async {
    final useCase = await repository.logout(lang, token);
    errorHandle(useCase.statusCode, useCase.message);
    return useCase.data;
  }

  @override
  Future<VisitModel?> onCanceled(String lang, String token, int id) async {
    final useCase = await repository.onCanceled(lang, token, id);
    errorHandle(useCase.statusCode, useCase.message);
    return useCase.data;
  }

  @override
  Future<VisitModel?> onDelayed(String lang, String token, int id) async {
    final useCase = await repository.onDelayed(lang, token, id);
    errorHandle(useCase.statusCode, useCase.message);
    return useCase.data;
  }

  @override
  Future<VisitModel?> onDone(String lang, String token, int id) async {
    final useCase = await repository.onDone(lang, token, id);
    errorHandle(useCase.statusCode, useCase.message);
    return useCase.data;
  }

  @override
  Future<VisitModel?> onInProgress(String lang, String token, int id) async {
    final useCase = await repository.onInProgress(lang, token, id);
    errorHandle(useCase.statusCode, useCase.message);
    return useCase.data;
  }

  @override
  Future<void> orderVisit(String lang, String token, OrderModel order) async {
    final useCase = await repository.orderVisit(lang, token, order);
    errorHandle(useCase.statusCode, useCase.message);
  }

  @override
  Future<void> register(String lang, RegisterModel register) async {
    final useCase = await repository.register(lang, register);
    errorHandle(useCase.statusCode, useCase.message);
  }

  void errorHandle(int statusCode, String message) {
    switch (statusCode) {
      case 401:
        Get.offNamedUntil(Routes.LOGIN, (route) => false);
        break;
      case 200:
        break;
      case 201:
        Get.snackbar("Success", message);
        break;
      default:
        Get.snackbar("Error", "$statusCode: $message");
    }
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
}
