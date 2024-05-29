import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medicine_app/Models/UserModel.dart';
import 'package:medicine_app/Service/BaseService.dart';
import 'package:medicine_app/config/get_it.dart';

class AuthService extends BaseService {
  @override
  get() async {
    try {
      Response response = await dio.get(BaseURL + "user",
          options: Options(headers: {
            'content-type': 'application/json',
            'accept': 'application/json',
          }));
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Response?> register(UserModel user) async {
    try {
      // Convert user to a map without id
      Map<String, dynamic> data = user.toMap();

      // Make the HTTP POST request
      Response response = await dio.post(
        '${BaseURL}register',
        data: data,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        // Store the access token securely
        await getIt<FlutterSecureStorage>()
            .write(key: 'token', value: response.data['access_token']);
        return response;
      } else {
        print('Failed to register. Status code: ${response.statusCode}');
        print('Response data: ${response.data}');
        return null;
      }
    } catch (error) {
      print('Error during registration: ${error.toString()}');
      return null;
    }
  }

  Future<Response?> login(UserModel user) async {
    try {
      // Convert user to a map without id
      Map<String, dynamic> data = user.toMap();

      Response response = await dio.post(
        '${BaseURL}login',
        data: data,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        await getIt<FlutterSecureStorage>()
            .write(key: "token", value: response.data['access_token']);
        return response;
      } else {
        print('Failed to login. Status code: ${response.statusCode}');
        print('Response data: ${response.data}');
        return null;
      }
    } catch (error) {
      print('Error during login: $error');
      return null;
    }
  }
}
