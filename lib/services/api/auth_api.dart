import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:softun_bus_mobile/models/req_res_model.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/services/urls.dart';
import 'package:softun_bus_mobile/widgets/snackbar.dart';

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

  SharedPreferenceService sharedPreferenceService = Get.find();

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

      if (e is DioError) {
        print(e.response?.data['error_description']);
        if (e.response?.data['error_description'] == "User account is locked") {
          Get.toNamed(Routes.roles);
          return e
              .response; // getErrorSnackBar(message: "User account is locked");
        } else {
          throw (e.response?.data['error']);
        }
      }
    }
  }
}
