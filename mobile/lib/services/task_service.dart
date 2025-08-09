import 'package:flutter/material.dart';
import 'package:mobile/models/response.dart';
import 'package:mobile/models/task.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/storage.dart';

class TaskService {
  final ApiService _api = ApiService();

  Future<AllTaskResponse?> getTasks() async {
    final token = await Storage.getItemStorage("token");
    final response = await _api.get("/task", token);
    return AllTaskResponse.fromJson(response);
  }

  Future<TaskResponse?> createTask(Map<String, dynamic> body) async {
    final token = await Storage.getItemStorage("token");
    final response = await _api.post("/task", body, token);
    return TaskResponse.fromJson(response);
  }

  Future<TaskResponse?> updateTask(Map<String, dynamic> body, String id) async {
    final token = await Storage.getItemStorage("token");
    debugPrint('TaskService: $body');
    final response = await _api.put("/task/$id", body, token);
    return TaskResponse.fromJson(response);
  }

  Future<StatusResponse?> deleteTask(String id) async {
    final token = await Storage.getItemStorage("token");
    final response = await _api.delete("/task/delete/$id", token);
    return StatusResponse.fromJson(response);
  }

  Future<StatusResponse?> deleteSelectedTasks(Set<String> ids) async {
    // Convertimos el Set a List antes de enviarlo
    final body = {"ids": ids.toList()};
    final token = await Storage.getItemStorage("token");
    final response = await _api.delete("/task/delete-selected", token, body);
    return StatusResponse.fromJson(response);
  }
}
