import '../../data/dto/login_response.dart';
import '../../data/dto/register_response.dart';
import '../../data/models/user_model.dart';
import '../constants/app_constants.dart';
import 'api_service.dart';
import 'storage_service.dart';

class AuthService {
  final ApiService _apiService;
  final StorageService _storageService;
  ApiService get apiService => _apiService;
  AuthService({
    required ApiService apiService,
    required StorageService storageService,
  }) : _apiService = apiService,
        _storageService = storageService;

  // Register new user
  Future<RegisterResponse> register(String username, String password) async {
    final response = await _apiService.post(
      AppConstants.registerEndpoint,
      data: {
        'username': username,
        'password': password,
      },
    );

    final registerResponse = RegisterResponse.fromJson(response.data!);

    // Save username to storage
    await _storageService.saveUsername(username);

    return registerResponse;
  }

  // Login existing user
  Future<UserModel> login(String username, String password) async {
    final response = await _apiService.post(
      AppConstants.loginEndpoint,
      data: {
        'username': username,
        'password': password,
      },
    );

    final loginResponse = LoginResponse.fromJson(response.data!);

    // Save token and username
    await _storageService.saveToken(loginResponse.token);
    await _storageService.saveUsername(username);

    // Set auth token for future API calls
    _apiService.setAuthToken(loginResponse.token);

    return UserModel(
      username: username,
      token: loginResponse.token,
    );
  }

  // Logout
  Future<void> logout() async {
    await _storageService.clearAll();
    _apiService.clearAuthToken();
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await _storageService.getToken();
    final username = await _storageService.getUsername();
    return token != null && username != null;
  }

  // Get current user from storage
  Future<UserModel?> getCurrentUser() async {
    final token = await _storageService.getToken();
    final username = await _storageService.getUsername();

    if (token != null && username != null) {
      return UserModel(username: username, token: token);
    }
    return null;
  }
}