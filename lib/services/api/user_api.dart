import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:softun_bus_mobile/models/req_res_model.dart';
import 'package:softun_bus_mobile/models/user_model.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/services/urls.dart';

class UserService extends GetxService {
  Future<UserService> init() async {
    dio = createDio();
    return this;
  }

  late ChangePasswordRequest req;
  var dio = Dio();

  Dio createDio() {
    return Dio(BaseOptions(connectTimeout: 6000, receiveTimeout: 6000));
  }

  SharedPreferenceService sharedPreferenceService = Get.find();

  getUserSharedPrefs({required String token}) async {
    try {
      print("**************** getUserSharedPrefs ********************");
      var path = AppUrls.profile;
      var response = await dio.post(
        path,
        options: Options(
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
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

  getUserFromApi({required String token}) async {
    try {
      print("**************** getUserFromApi ********************");
      var path = AppUrls.profile;

      var response = await dio.get(
        path,
        options: Options(
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
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

  updateUserPerso({required String token, required User user}) async {
    try {
      print("**************** updateUserPerso ********************");
      var data = jsonEncode(user.toJson());
      var path = AppUrls.updatePerso;

      var response = await dio.post(
        path,
        data: data,
        options: Options(
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
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

  updatePassword(
      {required String token,
      required String newPassword,
      required String oldPassword}) async {
    try {
      req = ChangePasswordRequest(
          newPassword: newPassword, oldPassword: oldPassword);
      var data = jsonEncode(req.toJson());
      var path = AppUrls.updatePassword;

      dynamic response = await dio.post(
        path,
        data: data,
        options: Options(
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
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

  setDeviceId({required String deviceId, required String token}) async {
    try {
      print("**************** setDeviceId ********************");
      var path = AppUrls.updateDevice;

      var response = await dio.post(
        path,
        data: deviceId,
        options: Options(
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
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
