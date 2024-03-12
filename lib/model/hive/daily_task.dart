import 'package:hive/hive.dart';

part 'daily_task.g.dart'; // This file is generated by running the build_runner command

@HiveType(typeId: 2) // Ensure the typeId is unique if you have other Hive models
class DailyTask extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String? description;

  @HiveField(2)
  final String tag;

  @HiveField(3)
  final DateTime reminderTime;

  @HiveField(4)
  bool completed;

  DailyTask({
    required this.name,
    this.description,
    required this.tag,
    required this.reminderTime,
    this.completed = false,
  });
}
