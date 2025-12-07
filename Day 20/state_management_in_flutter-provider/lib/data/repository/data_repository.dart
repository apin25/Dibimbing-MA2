import 'package:day_21_state_management/data/model/province_response.dart';
import 'package:dio/dio.dart';

class DataRepository {
  static const String _baseUrl = 'https://open-api.my.id/api/wilayah';
  final Dio _dio;

  DataRepository({Dio? dio})
      : _dio = dio ?? Dio(BaseOptions(baseUrl: _baseUrl));

  Future<List<ProvinceResponse>> fetchProvinces() async {
    try {
      final response = await _dio.get('/provinces');
      if (response.statusCode == 200 && response.data is List) {
        final data = response.data as List;
        return data
            .map((item) => ProvinceResponse.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      throw Exception('Failed to load provinces');
    } catch (e) {
      throw Exception('Error fetching provinces: $e');
    }
  }
}
