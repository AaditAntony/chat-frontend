class UserModel {
  final String username;
  final String? token; // JWT token for authentication
  final int? id;

  UserModel({
    required this.username,
    this.token,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      if (token != null) 'token': token,
      if (id != null) 'id': id,
    };
  }

  factory UserModel.fromLocalJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] as String,
      token: json['token'] as String?,
      id: json['id'] as int?,
    );
  }
}