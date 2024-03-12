import 'package:hive/hive.dart';
import 'task_hive.dart';

part 'routine_hive.g.dart'; // Hive generator will create this file

@HiveType(typeId: 1)
class RoutineModelAdapter extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  List<TaskModelAdapter> tasks;

  RoutineModelAdapter({
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

  static RoutineModelAdapter fromJson(Map<String, dynamic> json) {
    return RoutineModelAdapter(
      id: json['id'],
      userId: json['userId'],
      tasks: (json['tasks'] as List).map((taskJson) => TaskModelAdapter.fromJson(taskJson)).toList(),
    );
  }
}
