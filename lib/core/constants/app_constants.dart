// class AppConstants {
//   static const String baseUrl = 'http://10.0.2.2:8080'; // Android emulator
//   // static const String baseUrl = 'http://localhost:8080'; // iOS simulator
//   // static const String baseUrl = 'http://192.168.x.x:8080'; // Physical device
//
//   static const String wsUrl = '$baseUrl/ws';
//   static const int connectionTimeout = 30000;
//   static const int receiveTimeout = 30000;
//
//   // API Endpoints
//   static const String registerEndpoint = '/api/auth/register';
//   static const String loginEndpoint = '/api/auth/login';
//   static const String testEndpoint = '/api/test/echo';
// }

// class AppConstants {
//   // USE YOUR MAC'S IP
//   static const String baseUrl = 'http://192.168.18.56:8080';
//
//   static const String wsUrl = '$baseUrl/ws';
//   static const int connectionTimeout = 30000; // 30 seconds
//   static const int receiveTimeout = 30000;    // 30 seconds
//
//   // API Endpoints
//   static const String registerEndpoint = '/api/auth/register';
//   static const String loginEndpoint = '/api/auth/login';
//   static const String testEndpoint = '/api/test/echo';
// }

// class AppConstants {
//   // Use your Mac's actual IP
//   static const String baseUrl = 'http://192.168.18.56:8080';
//
//   static const String wsUrl = '$baseUrl/ws';
//   static const int connectionTimeout = 30000;
//   static const int receiveTimeout = 30000;
//
//   static const String registerEndpoint = '/api/auth/register';
//   static const String loginEndpoint = '/api/auth/login';
//   static const String testEndpoint = '/api/test/echo';
// }
class AppConstants {
  // For Android Emulator - HTTP requests use http://
  //static const String baseUrl = 'http://10.0.2.2:8080';

  // Plain WebSocket (NOT SockJS)
  //static const String wsUrl = 'ws://10.0.2.2:8080/ws';

  // For iOS Simulator (uncomment if needed)
  static const String baseUrl = 'http://localhost:8080';
  static const String wsUrl = 'ws://localhost:8080/ws';

  // For Physical Device (use your Mac's actual IP)
  // static const String baseUrl = 'http://192.168.18.56:8080';
  // static const String wsUrl = 'ws://192.168.18.56:8080/ws';

  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;

  // API Endpoints
  static const String registerEndpoint = '/api/auth/register';
  static const String loginEndpoint = '/api/auth/login';
  static const String testEndpoint = '/api/test/echo';
}
abcd