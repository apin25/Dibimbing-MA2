import 'package:dio/dio.dart';
import '../state/remote_state.dart';

class DioApiClient {
  static final DioApiClient _instance = DioApiClient._internal();
  factory DioApiClient() => _instance;

  DioApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOTY5MjI2MGE3N2Y3ZjdlYTYxM2I5MDQzMzJlNjk3YSIsIm5iZiI6MTc2NDU2MzA4OS4yMjMsInN1YiI6IjY5MmQxODkxYTFmZDc4NWQyYjI4NjQzNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.frRdsYx4eRrwV8WgqDdayrspe2b8JYL0AayDNXg6pUs',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        responseType: ResponseType.json,
        validateStatus: (status) {
          return status != null && status >= 200 && status < 400;
        },
        receiveDataWhenStatusError: true,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          _dioErrorHandler(error);
          return handler.next(error);
        },
      ),
    );
  }

  RemoteStateError _dioErrorHandler(DioException error) {
    return RemoteStateError('${error.message}');
  }

  late final Dio _dio;
  Dio get dio => _dio;
}
