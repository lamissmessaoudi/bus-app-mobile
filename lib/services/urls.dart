class AppUrls {
  static const String BASE_URL = "http://localhost:8080/softun-bus";
  static const String LOGIN =
      // "http://192.168.137.1:8080/softun-bus/oauth/token?grant_type=password";
      BASE_URL + "/oauth/token?grant_type=password";
  static const String profile = BASE_URL + "/user/";
  static const String updatePassword = profile + "updatepassword";
  static const String updatePerso = profile + "update";
}
