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

void testAuthEndpoints() async {
  print('🔐 Testing auth endpoints...');

  final dio = Dio();
  final baseUrl = 'http://192.168.18.56:8080'; // Your working IP

  try {
    // Test Registration
    print('1. Testing registration...');
    final registerResponse = await dio.post(
      '$baseUrl/api/auth/register',
      data: {
        'username': 'testuser23',
        'password': 'testpass123'
      },
    );
    print('✅ Registration response: ${registerResponse.data}');

    // Test Login
    print('2. Testing login...');
    final loginResponse = await dio.post(
      '$baseUrl/api/auth/login',
      data: {
        'username': 'testuser23',
        'password': 'testpass123'
      },
    );
    print('✅ Login response: ${loginResponse.data}');

    // Extract JWT token
    final token = loginResponse.data['token'];
    print('🔑 Token received: ${token != null ? "YES" : "NO"}');

    // Test authenticated endpoint with token
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';

      print('3. Testing authenticated endpoint...');
      final testResponse = await dio.get('$baseUrl/api/test/echo');
      print('✅ Authenticated test: ${testResponse.data}');
    }

  } catch (e) {
    print('❌ Error: $e');
    if (e is DioException) {
      print('Response: ${e.response?.data}');
    }
  }
}