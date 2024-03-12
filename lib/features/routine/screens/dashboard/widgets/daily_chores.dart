import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/adapters.dart';

class DailyWidget extends StatefulWidget {
  const DailyWidget({super.key});

  @override
  _DailyWidgetState createState() => _DailyWidgetState();
}

class _DailyWidgetState extends State<DailyWidget> {
  //dynamic - dailyTask
  // List<dynamic>? tasksBox;

  @override
  void initState() {
    super.initState();
    // tasksBox = Hive.box<DailyTask>('dailyTasks');
  }

  // Future<void> toggleTaskCompletion(DailyTask task) async {
  //   task.completed = !task.completed;
  //   await task.save();
  // }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      height: 200,
      child: const Text('Daily Widget'),
      // child: ValueListenableBuilder(
      //   valueListenable: tasksBox!.listenable(),
      //   //dynamic - dailyTask
      //   builder: (context, Box<dynamic> box, _) {
      //     final tasks = box.values.toList();
      //     return ListView.builder(
      //       itemCount: tasks.length,
      //       itemBuilder: (context, index) {
      //         final task = tasks[index];
      //         return CheckboxListTile(
      //           title: Text(task.name),
      //           subtitle: Text(task.tag),
      //           value: task.completed,
      //           onChanged: (_) => {
      //             // toggleTaskCompletion(task)
      //           },
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}

