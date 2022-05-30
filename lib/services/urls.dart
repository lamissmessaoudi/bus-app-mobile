class AppUrls {
  static const String BASE_URL =
      // "http://localhost:8080/softun-bus";
      // "http://10.241.106.20:8080/softun-bus"; //Sofrecomn LAN
      "http://192.168.1.16:8080/softun-bus"; // Galaxy point accés
  // "http://10.241.106.20:8080/softun-bus"; //VM

  static const String LOGIN = BASE_URL + "/oauth/token?grant_type=password";
  static const String profile = BASE_URL + "/user/";
  static const String updatePassword = profile + "updatepassword";
  static const String updatePerso = profile + "update";
  static const String updateDevice = profile + "updateD evice";
  static const String activate = BASE_URL + "/signup/activateAccountMobile";
  static const String allStations = BASE_URL + "/stations/all";
  static const String allCircuits = BASE_URL + "/circuits/";
  static const String circuitById = BASE_URL + "/circuits/getById/";
  static const String availableCircuits = BASE_URL + "/circuits/available";
  static const String reserveCircuit = BASE_URL + "/circuits/reserver";
  static const String sendRequest = BASE_URL + "/demandes/add";
  static const String allRequests = BASE_URL + "/demandes/";
  static const String userRequests = BASE_URL + "/demandes/user/";
  static const String trajets = BASE_URL + "/trajet/";
  static const String reservedCircuit = BASE_URL + "/trajet/reservedCircuit";
  static const String addTransport = BASE_URL + "/transport/addTransport";
  static const String getLocations = BASE_URL + "/transport/locations";
}
