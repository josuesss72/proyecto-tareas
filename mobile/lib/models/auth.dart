import 'package:mobile/models/response.dart';

class UserResponseAuth {
  final String id;
  final String email;

  UserResponseAuth({required this.id, required this.email});

  factory UserResponseAuth.fromJson(Map<String, dynamic> json) {
    return UserResponseAuth(id: json['id'], email: json['email']);
  }
}

class RegisterResponse {
  final Response status;
  final UserResponseAuth user;

  RegisterResponse({required this.status, required this.user});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      status: Response.fromJson(json['status']),
      user: UserResponseAuth.fromJson(json['user']),
    );
  }
}

class LoginResponse {
  final Response status;
  final String token;

  LoginResponse({required this.status, required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: Response.fromJson(json['status']),
      token: json['token'],
    );
  }
}
