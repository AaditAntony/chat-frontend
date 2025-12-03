class AppConstants {
  static const String baseUrl = 'http://10.0.2.2:8080'; // Android emulator
  // static const String baseUrl = 'http://localhost:8080'; // iOS simulator
  // static const String baseUrl = 'http://192.168.x.x:8080'; // Physical device

  static const String wsUrl = '$baseUrl/ws';
  static const int connectionTimeout = 5000;
  static const int receiveTimeout = 30000;

  // API Endpoints
  static const String registerEndpoint = '/api/auth/register';
  static const String loginEndpoint = '/api/auth/login';
  static const String testEndpoint = '/api/test/echo';
}