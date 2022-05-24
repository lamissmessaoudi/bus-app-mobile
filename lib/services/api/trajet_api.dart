import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:softun_bus_mobile/models/circuit_model.dart';
import 'package:softun_bus_mobile/services/shared-prefs.dart';
import 'package:softun_bus_mobile/services/urls.dart';

class TrajetService extends GetxService {
  Future<TrajetService> init() async {
    dio = createDio();
    return this;
  }

  var dio = Dio();

  Dio createDio() {
    return Dio(BaseOptions(connectTimeout: 6000, receiveTimeout: 6000));
  }

  SharedPreferenceService sharedPreferenceService = Get.find();

  getTrajet({required String token, required CircuitDto circuit}) async {
    try {
      var path = AppUrls.trajets;
      print("*** getTrajet");
      var response = await dio.post(
        path,
        data: jsonEncode(circuit.toJson()),
        options: Options(
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print("response de getTrajet $response");
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print("getTrajet error");
      print(e);
      if (e is DioError) throw (e.response?.data['error']);
    }
  }

//Checks if druver has selected circuit or not
  reservedCircuit({required String token}) async {
    try {
      var path = AppUrls.reservedCircuit;
      print("*** reservedCircuit");
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
      print("response de reservedCircuit $response");
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print("reservedCircuit error");
      print(e);
      print((e is DioError));
      if (e is DioError) {
        print(e.response?.data['error']);
        if (e.response?.data['error'] == "aucun circuit choisi") {
          return e.response;
        } else {
          throw (e.response?.data['error']);
        }
      }
    }
  }
}
