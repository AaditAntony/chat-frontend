import 'token_response.dart';

class LoginResponse extends TokenResponse {
  LoginResponse({required super.token});

  // Keep the fromJson factory
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] as String,
    );
  }
}