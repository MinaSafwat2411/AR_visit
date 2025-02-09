class BackendEndpoint {
  static const baseUrl = 'http://41.130.162.205:5500';
  static const api = '/api';
  static const auth = '$api/auth';
  static const login = '$auth/login';
  static const logout = '$auth/logout';
  static const visits = '$api/visits';
  static const order = '$visits/order';
  static const reports = '$visits/reports';
  static const inprogress = '$visits/inprogress';
  static const cancel = '$visits/cancel';
  static const delay = '$visits/delay';
  static const done = '$visits/done';
  static const archive = '$visits/archives';
  static const areas = '$api/areas';
  static const settings = '$api/settings';
  static const enums = '$settings/enums';
  static const users = '$api/users';
  static const patient = '$users/patient';
  static const dropDown = '$users/dropdown';
  static const profile = '$users/profile';
  static const servent ='$visits/servant';
  static const father ='$visits/father';
  static const register = '$users/register';
}
