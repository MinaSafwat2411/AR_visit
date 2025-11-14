class BackendEndpoint {
  static const baseUrl = 'http://41.130.162.205:5000/api/';
  static const auth = 'auth';
  static const login = '$auth/login';
  static const logout = '$auth/logout';
  static const visits = 'visits';
  static const order = '$visits/order';
  static const reports = '$visits/reports';
  static const inProgress = '$visits/inprogress';
  static const cancel = '$visits/cancel';
  static const delay = '$visits/delay';
  static const done = '$visits/done';
  static const archive = '$visits/archives';
  static const areas = 'areas';
  static const settings = 'settings';
  static const enums = '$settings/enums';
  static const users = 'users';
  static const patient = '$users/patient';
  static const dropDown = '$users/dropdown';
  static const profile = '$users/profile';
  static const servant ='$visits/servant';
  static const father ='$visits/father';
  static const register = '$auth/register';
}
