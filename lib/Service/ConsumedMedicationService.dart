import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medicine_app/Models/ConsumedMedicationModel.dart';
import 'package:medicine_app/Models/DrugModel.dart';
import 'package:medicine_app/Service/BaseService.dart';
import 'package:medicine_app/config/get_it.dart';

class ConsumedMedicationService extends BaseService {
  final FlutterSecureStorage storage = getIt.get<FlutterSecureStorage>();

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  postMedication(DrugModel drug, ConsumedMedicationModel medication) async {
    try {
      final storage = getIt.get<FlutterSecureStorage>();
      final token = await storage.read(key: "token");

      if (token == null) {
        throw Exception("Token is null");
      }

      FormData formData = FormData.fromMap({
        'Drug_name': drug.Drug_name,
        'Effective_Material': drug.Effective_Material,
        'Side_Effects': drug.Side_Effects,
        'Other_Information': drug.Other_Information,
        'image': await MultipartFile.fromFile(drug.image,
            filename: 'drug_image.jpg'),
        'Doctor_Name': medication.Doctor_Name,
        'User_ID': medication.User_ID,
        'Date_Prescibed': medication.Date_Prescibed,
        'period': medication.period,
      });

      print(formData);
      Response response = await Dio().post(
        BaseURL + "medications",
        data: formData,
        options: Options(
          headers: {
            'content-type': 'multipart/form-data',
            'accept': 'application/json',
            'authorization': 'Bearer $token',
          },
        ),
      );

      print(response);

      if (response.statusCode == 201) {
        if (response.data != null) {
          return response;
        } else {
          throw Exception('Response data is null');
        }
      } else {
        throw Exception(
            'Failed to load medications: ${response.statusMessage}');
      }
    } catch (e) {
      print(e);
      throw Exception('Error posting medication: $e');
    }
  }

  Future<String> _convertImageToBase64(String imagePath) async {
    final bytes = File(imagePath).readAsBytesSync();
    return base64Encode(bytes);
  }

  Future<Response> updateMedication(
      int id, DrugModel drug, ConsumedMedicationModel medication) async {
    try {
      final token = await getToken();

      if (token == null) {
        throw Exception("Token is null");
      }

      String? imageBase64;
      if (drug.image != null) {
        imageBase64 = await _convertImageToBase64(drug.image);
      }

      Map<String, dynamic> data = {
        'Drug_name': drug.Drug_name,
        'Effective_Material': drug.Effective_Material,
        'Side_Effects': drug.Side_Effects,
        'Other_Information': drug.Other_Information,
        'Doctor_Name': medication.Doctor_Name,
        'Date_Prescibed': medication.Date_Prescibed,
        'period': medication.period,
        if (imageBase64 != null) 'image': imageBase64,
      };

      Response response = await Dio().put(
        BaseURL + "consumed_medications/$id",
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print("Request Data: $data");
      print("Response Status: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        if (response.data != null) {
          print(response.data);
          return response;
        } else {
          throw Exception('Response data is null');
        }
      } else if (response.statusCode == 404) {
        throw Exception(
            'Resource not found. Check the endpoint URL and the existence of the resource.');
      } else {
        throw Exception(
            'Failed to update medication: ${response.statusMessage}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error updating medication: $e');
    }
  }

  search(String name) async {
    try {
      final token = await getIt.get<FlutterSecureStorage>().read(key: "token");
      if (token == null) {
        throw Exception("Token is null");
      }
      print(name);
      Response response = await dio.get(BaseURL + "search",
          queryParameters: {'drug_name': name},
          options: Options(headers: {
            'content-type': 'application/json',
            'accept': 'application/json',
            'authorization': 'Bearer $token'
          }));
      print(response);

      if (response.statusCode == 200) {
        if (response.data != null) {
          return response;
        } else {
          throw Exception('Response data is null');
        }
      } else {
        throw Exception(
            'Failed to load medications: ${response.statusMessage}');
      }
    } catch (e) {
      print(e);
    }
  }

  get2() async {
    try {
      final token = await getIt.get<FlutterSecureStorage>().read(key: "token");
      if (token == null) {
        throw Exception("Token is null");
      }

      Response response = await dio.get(BaseURL + "consumed_medications2",
          options: Options(headers: {
            'content-type': 'application/json',
            'accept': 'application/json',
            'authorization': 'Bearer $token'
          }));
      print(response);
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  get3() async {
    try {
      final token = await getIt.get<FlutterSecureStorage>().read(key: "token");
      if (token == null) {
        throw Exception("Token is null");
      }

      Response response = await dio.get(BaseURL + "consumed_medications3",
          options: Options(headers: {
            'content-type': 'application/json',
            'accept': 'application/json',
            'authorization': 'Bearer $token'
          }));
      print(response);
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  get4() async {
    try {
      final token = await getIt.get<FlutterSecureStorage>().read(key: "token");
      if (token == null) {
        throw Exception("Token is null");
      }

      Response response = await dio.get(BaseURL + "consumed_medications4",
          options: Options(headers: {
            'content-type': 'application/json',
            'accept': 'application/json',
            'authorization': 'Bearer $token'
          }));
      print(response);
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  get() {
    // TODO: implement get
    throw UnimplementedError();
  }
}
