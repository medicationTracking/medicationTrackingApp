import 'dart:io';

import 'package:dio/dio.dart';
import 'package:medication_app_v0/views/Inventory/model/inventory_model.dart';

class MedicationService {
  final Dio _dio = Dio(BaseOptions(responseType: ResponseType.json));
  final String _medicationURL =
      'https://medicationapi.herokuapp.com/medications';

  Future<Response> getMedicationFromBarcode(String barcode) async {
    print(barcode);
    Response response = await _dio.get(_medicationURL,
        queryParameters: {
          'barcode': barcode,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
    if (response.statusCode == HttpStatus.ok) {
      print(response.toString());
    } else {
      print("Something wrong in medication service");
    }

    return response;
  }
}
