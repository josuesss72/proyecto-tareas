import 'package:mobile/models/response.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final String status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description};
  }
}

class AllTaskResponse {
  final Response status;
  final List<Task> tasks;

  AllTaskResponse({required this.status, required this.tasks});

  factory AllTaskResponse.fromJson(Map<String, dynamic> json) {
    return AllTaskResponse(
      status: Response.fromJson(json['status']),
      tasks: (json['tasks'] as List)
          .map((task) => Task.fromJson(task))
          .toList(),
    );
  }
}

class TaskResponse {
  final Response status;
  final Task task;

  TaskResponse({required this.status, required this.task});

  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return TaskResponse(
      status: Response.fromJson(json['status']),
      task: Task.fromJson(json['task']),
    );
  }
}
