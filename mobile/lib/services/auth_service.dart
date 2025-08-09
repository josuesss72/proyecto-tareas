import 'package:mobile/models/auth.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/storage.dart';

class AuthService {
  final ApiService _api = ApiService();

  Future<RegisterResponse?> register(User user) async {
    final data = await _api.post('/auth/register', user.toJson());

    return RegisterResponse.fromJson(data);
  }

  Future<LoginResponse?> login(String password, String email) async {
    final data = await _api.post('/auth/login', {
      'password': password,
      'email': email,
    });

    LoginResponse response = LoginResponse.fromJson(data);

    if (response.status.ok) {
      await Storage.saveItemStorage('token', response.token);
    }

    return response;
  }
}
