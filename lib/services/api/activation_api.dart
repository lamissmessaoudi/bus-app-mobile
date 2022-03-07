import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:softun_bus_mobile/models/user_model.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/services/urls.dart';

class ActivationService extends GetxService {
  Future<ActivationService> init() async {
    dio = createDio();
    return this;
  }

  var dio = Dio();

  Dio createDio() {
    return Dio(BaseOptions(connectTimeout: 6000, receiveTimeout: 6000));
  }

  SharedPreferenceService sharedPreferenceService = Get.find();

  activateUser({required InactiveUser user}) async {
    try {
      print("**************** activateUser ********************");
      var path = AppUrls.activate;
      print('user to seeeend : ${jsonEncode(user.toJson())} ');

      var response = await dio.post(
        path,
        data: jsonEncode(user.toJson()),
        options: Options(
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Basic c29mdHVuLWJ1czpzZWNyZXQ='
          },
        ),
      );
      print("object");
      print("RESPOOOONSE  : ${response.statusCode}");

      if (response.statusCode == 200) {
        print("RESPOOOONSE  : ${response.data}");
        return response;
      }
    } catch (e) {
      print(e);
      if (e is DioError) throw (e.response?.data['error']);
    }
  }
}
