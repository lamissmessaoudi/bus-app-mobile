import 'package:get/get.dart';
import 'package:dio/dio.dart';

class AuthService extends GetxService {
  Future<AuthService> init() async {
    dio = createDio();
    return this;
  }

  var dio = Dio();

  Dio createDio() {
    return Dio(BaseOptions(connectTimeout: 6000, receiveTimeout: 6000));
  }

  signIn({required String login, required String password}) async {
    try {
      print("signin");
    } catch (e) {
      print(e);
      if (e is DioError) throw (e.response?.data['error']);
    }
  }
}
