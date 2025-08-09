import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/config/env.dart';

class ApiService {
  final String baseUrl = Env.apiUrl;

  // Método genérico para POST
  Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> body, [
    String? token,
  ]) async {
    final headers = {"Content-Type": "application/json"};
    if (token != null) {
      headers["Authorization"] = "Bearer $token";
    }
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
        body: jsonEncode(body),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception(e);
    }
  }

  // Método genérico para GET
  Future<dynamic> get(String endpoint, [String? token]) async {
    final headers = <String, String>{"Content-Type": "application/json"};
    if (token != null) {
      headers["Authorization"] = "Bearer $token";
    }
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception(e);
    }
  }

  // Método genérico para PUT
  Future<dynamic> put(
    String endpoint,
    Map<String, dynamic> body, [
    String? token,
  ]) async {
    final headers = {"Content-Type": "application/json"};
    if (token != null) {
      headers["Authorization"] = "Bearer $token";
    }
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception(e);
    }
  }

  // Método genérico para DELETE
  Future<dynamic> delete(
    String endpoint, [
    String? token,
    Map<String, dynamic>? body,
  ]) async {
    final headers = <String, String>{};
    if (token != null) {
      headers["Authorization"] = "Bearer $token";
    }
    if (body != null) {
      headers["Content-Type"] = "application/json";
    }
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception(e);
    }
  }

  // Manejo centralizado de la respuesta
  dynamic _handleResponse(http.Response response) {
    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    } else {
      throw Exception(data["message"] ?? "Error desconocido");
    }
  }
}
