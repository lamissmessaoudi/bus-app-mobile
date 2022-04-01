class AppUrls {
  static const String BASE_URL = "http://localhost:8080/softun-bus";
  // "http://10.241.106.190:8080/softun-bus";
  // "http://192.168.137.1:8080/softun-bus";

  static const String LOGIN = BASE_URL + "/oauth/token?grant_type=password";
  static const String profile = BASE_URL + "/user/";
  static const String updatePassword = profile + "updatepassword";
  static const String updatePerso = profile + "update";
  static const String allStations = BASE_URL + "/stations/all";
  static const String allCircuits = BASE_URL + "/circuits/";
  static const String availableCircuits = BASE_URL + "/circuits/available";
  static const String activate = BASE_URL + "/signup/activateAccountMobile";
  static const String reserveCircuit = BASE_URL + "/circuits/reserver";
  static const String sendRequest = BASE_URL + "/demandes/add";
  static const String allRequests = BASE_URL + "/demandes/";
  static const String userRequests = BASE_URL + "/demandes/user/";
}
