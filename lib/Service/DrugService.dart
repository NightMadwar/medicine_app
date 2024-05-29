import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medicine_app/Service/BaseService.dart';
import 'package:medicine_app/config/get_it.dart';

class DrugService extends BaseService {
  @override
  Future<Response?> get() async {
    try {
      final token = await getIt<FlutterSecureStorage>().read(key: "token");
      Response response = await dio.get(BaseURL + "drugs",
          options: Options(headers: {
            'content-type': 'application/json',
            'accept': 'application/json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
