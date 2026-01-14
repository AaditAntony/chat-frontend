class RegisterResponse {
  final int? id;
  final String username;
  final String? password;

  RegisterResponse({
    this.id,
    required this.username,
    this.password,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      id: json['id'] as int?,
      username: json['username'] as String,
      password: json['password'] as String?,
    );
  }
}