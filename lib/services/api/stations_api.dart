import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:softun_bus_mobile/models/demande_model.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/services/urls.dart';

class StationService extends GetxService {
  Future<StationService> init() async {
    dio = createDio();
    return this;
  }

  var dio = Dio();

  Dio createDio() {
    return Dio(BaseOptions(connectTimeout: 6000, receiveTimeout: 6000));
  }

  SharedPreferenceService sharedPreferenceService = Get.find();

  getAllStations() async {
    try {
      var path = AppUrls.allStations;

      var response = await dio.get(
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

  getStationById({required int id}) async {
    try {
      var path = AppUrls.stationById + "$id";
      print(path);
      var response = await dio.get(
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

  addStation({required String token, required Demande demande}) async {
    try {
      var path = AppUrls.sendRequest;

      var response = await dio.post(
        path,
        data: jsonEncode(demande.toJson()),
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

  getAllRequests() async {
    try {
      var path = AppUrls.allRequests;

      var response = await dio.get(
        path,
        options: Options(
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Basic c29mdHVuLWJ1czpzZWNyZXQ='
          },
        ),
      );
      print(response);
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e);
      if (e is DioError) throw (e.response?.data['error']);
    }
  }

  getUserRequests({required String token}) async {
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
