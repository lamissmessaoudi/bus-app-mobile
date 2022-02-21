import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:softun_bus_mobile/models/login_request.dart';
import 'package:softun_bus_mobile/models/user.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/services/urls.dart';

class UserService extends GetxService {
  Future<UserService> init() async {
    dio = createDio();
    return this;
  }

  late User user;
  var dio = Dio();

  Dio createDio() {
    return Dio(BaseOptions(connectTimeout: 6000, receiveTimeout: 6000));
  }

  SharedPreferenceService sharedPreferenceService = Get.find();

  // getUser() async {
  //   try {
  //     print("**************** getUser ********************");
  //     var path = AppUrls.profile;
  //     print(path);

  //     var s = await sharedPreferenceService.getString("token");
  //     print("s =   ==== $s");
  //     var token = jsonDecode(s)["access-token"];
  //     print("token");
  //     print(token);
  //     var response = await dio.post(
  //       path,
  //       options: Options(
  //         headers: {
  //           'content-type': 'application/json',
  //           'Accept': 'application/json',
  //           'Authorization': 'Bearer $token',
  //         },
  //       ),
  //     );
  //     if (response.statusCode == 200) {
  //       return response;
  //     }
  //   } catch (e) {
  //     print(e);
  //     if (e is DioError) throw (e.response?.data['error']);
  //   }
  // }

}
