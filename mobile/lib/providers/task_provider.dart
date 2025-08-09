import 'package:flutter/material.dart';
import 'package:mobile/models/task.dart';
import 'package:mobile/services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  List<Task> _tasks = [];
  bool _isLoading = false;

  List<Task> get tasks => _tasks;

  bool get isLoading => _isLoading;

  Future<List<Task>?> getTasks() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _taskService.getTasks();
      _tasks = response?.tasks ?? [];
      return _tasks;
    } catch (e) {
      throw Exception(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<TaskResponse?> createTask(String title, String description) async {
    notifyListeners();
    if (title.isEmpty || description.isEmpty) return null;
    try {
      final response = await _taskService.createTask({
        "title": title,
        "description": description,
      });
      if (response != null) {
        _tasks.add(response.task);
      }
      notifyListeners();
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteTasksSelected(Set<String> selectedTasks) async {
    notifyListeners();
    if (selectedTasks.isEmpty) return;
    try {
      await _taskService.deleteSelectedTasks(selectedTasks);
      _tasks.removeWhere((task) => selectedTasks.contains(task.id));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateTask({
    required String title,
    required String description,
    required String id,
  }) async {
    try {
      await _taskService.updateTask({
        "title": title,
        "description": description,
      }, id);
      await getTasks();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateTaskComplete(String id) async {
    try {
      await _taskService.updateTask({"status": "DONE"}, id);
      await getTasks();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateTaskPending(String id) async {
    try {
      await _taskService.updateTask({"status": "IN_PROGRESS"}, id);
      await getTasks();
    } catch (e) {
      throw Exception(e);
    }
  }
}
