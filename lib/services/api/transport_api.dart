import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:softun_bus_mobile/models/circuit_model.dart';
import 'package:softun_bus_mobile/models/transport_model.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/services/urls.dart';

class TransportService extends GetxService {
  Future<TransportService> init() async {
    dio = createDio();
    return this;
  }

  var dio = Dio();

  Dio createDio() {
    return Dio(BaseOptions(connectTimeout: 6000, receiveTimeout: 6000));
  }

  SharedPreferenceService sharedPreferenceService = Get.find();

  addUserToTransport({
    required String token,
    required Transport transport,
  }) async {
    try {
      var path = AppUrls.addTransport;
      print("addUserToTransport");
      var response = await dio.post(
        path,
        data: jsonEncode(transport.toJson()),
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

  getLocations({
    required String token,
    required CircuitResDto? circuit,
  }) async {
    try {
      var path = AppUrls.getLocations;
      print("getLocations");
      var response = await dio.post(
        path,
        data: jsonEncode(circuit!.toJson()),
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
