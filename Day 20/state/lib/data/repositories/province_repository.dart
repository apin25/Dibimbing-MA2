import 'package:dio/dio.dart';
import 'package:state/data/models/province_response.dart';

class ProvinceRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://open-api.my.id/api/wilayah',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<ProvinceResponse>> getProvince() async {
    try {
      final response = await _dio.get('/provinces');

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is List) {
          final list = data
              .whereType<Map<String, dynamic>>()
              .map((item) => ProvinceResponse.fromJson(item))
              .toList();

          if (list.isEmpty) {
            throw Exception("Province list is empty");
          }

          return list;
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching province: $e");
    }
  }
}
