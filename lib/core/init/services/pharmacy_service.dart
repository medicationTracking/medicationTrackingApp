import 'package:dio/dio.dart';
import 'package:medication_app_v0/views/Inventory/model/inventory_model.dart';

class PharmacyService{
  final Dio _dio = Dio(BaseOptions(responseType: ResponseType.json));
  final String _pharmacyURL = 'https://api.collectapi.com/health/dutyPharmacy';

  PharmacyService(){
    _dio.options.headers['authorization'] = 'apikey 5VQAoUaRhJodLQx7WLPRyl:35asmUQsCCZlVArCnYD5Jd';
  }

  Future<Response> getPharmacyByPlace(String district, String city) async {
    Response response = await _dio.get(
        _pharmacyURL,
        queryParameters: {
          'ilce' : district,
          'il': city,
        },
        options: Options(contentType:Headers.formUrlEncodedContentType)
    );
    return response;
  }


}