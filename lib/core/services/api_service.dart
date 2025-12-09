import 'package:dio/dio.dart';
import '../constants/app_constants.dart';

class ApiService {
  late Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(milliseconds: AppConstants.connectionTimeout),
        receiveTimeout: const Duration(milliseconds: AppConstants.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  // Add authentication token to requests
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Clear authentication token
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  // Generic GET request
  Future<Response<Map<String, dynamic>>> get(
      String endpoint, {
        Map<String, dynamic>? queryParams,
      }) async {
    try {
      return await _dio.get<Map<String, dynamic>>(
        endpoint,
        queryParameters: queryParams,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Generic POST request
  Future<Response<Map<String, dynamic>>> post(
      String endpoint, {
        dynamic data,
      }) async {
    try {
      return await _dio.post<Map<String, dynamic>>(
        endpoint,
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }
}