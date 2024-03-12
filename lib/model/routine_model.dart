
import 'package:prodox/services/category_model.dart';

class RoutineModel {
  String id;
  String userId;
  List<TaskModel> tasks;

  RoutineModel({
    required this.id,
    required this.userId,
    required this.tasks,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'tasks': tasks.map((task) => task.toJson()).toList(),
    };
  }

  static RoutineModel fromJson(Map<String, dynamic> json) {
    return RoutineModel(
      id: json['id'],
      userId: json['userId'],
      tasks: (json['tasks'] as List).map((taskJson) => TaskModel.fromJson(taskJson)).toList(),
    );
  }
}

class TaskModel {
  String id;
  String name;
  String? description;
  DateTime startTime;
  DateTime endTime;
  String status; // For example: "pending", "completed"
  DateTime? deadline;
  String tag;

  TaskModel({
    required this.id,
    required this.name,
    this.description,
    required this.startTime,
    required this.endTime,
    required this.status,
    this.deadline,
    required this.tag,
  });

  //getter and setter for the status
  String get getStatus => status;
  set setStatus(String status) => this.status = status;


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description??'',
      'tag': tag??'',
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'status': status,
      'deadline': deadline?.toIso8601String(),
    };
  }

  static TaskModel fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      tag: json['tag'] ?? '',
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      status: json['status'],
      deadline: json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
    );
  }
}