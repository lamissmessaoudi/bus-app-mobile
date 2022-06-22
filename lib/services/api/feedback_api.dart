import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:softun_bus_mobile/models/feedback_model.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/services/urls.dart';

class FeedbackService extends GetxService {
  Future<FeedbackService> init() async {
    dio = createDio();
    return this;
  }

  var dio = Dio();

  Dio createDio() {
    return Dio(BaseOptions(connectTimeout: 6000, receiveTimeout: 6000));
  }

  SharedPreferenceService sharedPreferenceService = Get.find();

  addFeedback({required String token, required Feedback feedBack}) async {
    try {
      var path = AppUrls.sendRequest;

      var response = await dio.post(
        path,
        data: jsonEncode(feedBack.toJson()),
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

  getUserFeedbacks({required String token}) async {
    try {
      var path = AppUrls.userRequests;

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
}
