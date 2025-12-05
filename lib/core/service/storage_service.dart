import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Secure storage for JWT token
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'auth_token', value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: 'auth_token');
  }

  // Shared preferences for username
  Future<void> saveUsername(String username) async {
    await _prefs.setString('username', username);
  }

  Future<String?> getUsername() async {
    return _prefs.getString('username');
  }

  Future<void> deleteUsername() async {
    await _prefs.remove('username');
  }

  // Clear all data (logout)
  Future<void> clearAll() async {
    await deleteToken();
    await deleteUsername();
  }
}