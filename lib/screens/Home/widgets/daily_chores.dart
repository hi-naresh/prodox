import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../model/hive/daily_task.dart';

class DailyWidget extends StatefulWidget {
  @override
  _DailyWidgetState createState() => _DailyWidgetState();
}

class _DailyWidgetState extends State<DailyWidget> {
  Box<DailyTask>? tasksBox;

  @override
  void initState() {
    super.initState();
    tasksBox = Hive.box<DailyTask>('dailyTasks');
  }

  Future<void> toggleTaskCompletion(DailyTask task) async {
    task.completed = !task.completed;
    await task.save();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 200,
      child: Column(
        children: [
          Text('Daily Tasks'),
          // Use Expanded widget here
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: tasksBox!.listenable(),
              builder: (context, Box<DailyTask> box, _) {
                final tasks = box.values.toList();
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return CheckboxListTile(
                      title: Text(task.name),
                      subtitle: Text(task.tag),
                      value: task.completed,
                      onChanged: (_) => toggleTaskCompletion(task),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

