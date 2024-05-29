import 'package:dio/dio.dart';

abstract class BaseService {
  Dio dio = Dio();
  String BaseURL = "http://10.0.2.2:8000/api/";
  dynamic get();
}
