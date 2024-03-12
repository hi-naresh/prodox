
import 'package:hive/hive.dart';

part 'task_hive.g.dart'; // Hive generator will create this file


@HiveType(typeId: 0)
class TaskModelAdapter extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime startTime;

  @HiveField(4)
  final DateTime endTime;

  @HiveField(5)
  final String status; // For example: "pending", "completed"

  @HiveField(6)
  final DateTime? deadline;

  TaskModelAdapter({
    required this.id,
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.status,
    this.deadline,
  });

// Add toJson method if you need it for uploading to Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'status': status,
      'deadline': deadline?.toIso8601String(),
    };
  }

  static TaskModelAdapter fromJson(Map<String, dynamic> json) {
    return TaskModelAdapter(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      status: json['status'],
      deadline: json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
    );
  }

}