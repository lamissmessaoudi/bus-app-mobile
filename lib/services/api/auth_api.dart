import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:softun_bus_mobile/models/login_request.dart';
import 'package:softun_bus_mobile/services/urls.dart';

class AuthService extends GetxService {
  Future<AuthService> init() async {
    dio = createDio();
    return this;
  }

  late LoginRequest login;
  var dio = Dio();

  Dio createDio() {
    return Dio(BaseOptions(connectTimeout: 6000, receiveTimeout: 6000));
  }

// (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//     (HttpClient client) {
//   client.badCertificateCallback =
//       (X509Certificate cert, String host, int port) => true;
//   return client;
// };
  signIn({required String username, required String password}) async {
    print(username + "  " + password);

    login = LoginRequest(password: password, username: username);

    Map<String, dynamic> data = login.toJson();
    String request = '&username=$username&password=$password';

    try {
      print("**************** sign in ********************");
      var path = AppUrls.LOGIN + request;
      print(path);
      print(jsonEncode(data));
      var response = await dio.post(
        path,
        options: Options(
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Basic c29mdHVuLWJ1czpzZWNyZXQ='
          },
        ),
      );
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e);
      if (e is DioError) throw (e.response?.data['error']);
    }
  }
}
