class AppUrls {
  static const String BASE_URL = "http://localhost:8080/softun-bus";
  // "http://10.0.2.2:8000/softun-bus";
  // "http://192.168.137.1:8080/softun-bus";

  static const String LOGIN = BASE_URL + "/oauth/token?grant_type=password";
  static const String profile = BASE_URL + "/user/";
  static const String updatePassword = profile + "updatepassword";
  static const String updatePerso = profile + "update";
  static const String allStations = BASE_URL + "/stations/all";
  static const String allCircuits = BASE_URL + "/circuits/";
  static const String addStation = BASE_URL + "666666";
  static const String activate = BASE_URL + "/signup/activateAccountMobile";
}
