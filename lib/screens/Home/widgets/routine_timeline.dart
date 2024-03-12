import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../common/styles/styles.dart';
import '../../../model/routine_model.dart';
import '../../../services/data_fetch.dart';
import '../../../utils/constants/colors.dart';

class RoutineTimeline extends StatefulWidget {
  const RoutineTimeline({super.key});

  @override
  _RoutineTimelineState createState() => _RoutineTimelineState();
}

class _RoutineTimelineState extends State<RoutineTimeline> {
  late Future<List<TaskModel>> futureTasks;
  PageController? _pageController;
  int? _nearestTaskIndex;

  @override
  void initState() {
    super.initState();
    futureTasks = fetchTasks();
  }

  Future<void> updateTaskStatus(String taskId, String newStatus) async {
    // Implement this method to update the task status in your backend or database
  }

  int findNearestTaskIndex(List<TaskModel> tasks) {
    final now = DateTime.now();
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].endTime.isAfter(now)) return i;
    }
    return tasks.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TaskModel>>(
      future: futureTasks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No tasks found');
        }

        List<TaskModel> tasks = snapshot.data!;
        _nearestTaskIndex = findNearestTaskIndex(tasks);
        _pageController = PageController(initialPage: _nearestTaskIndex ?? 0);

        return Column(

          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskTile(
                      task: task, updateTaskStatus: updateTaskStatus);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    if (_nearestTaskIndex! > 0) {
                      _pageController!.animateToPage(_nearestTaskIndex! - 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOut);
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    if (_nearestTaskIndex! < tasks.length - 1) {
                      _pageController!.animateToPage(_nearestTaskIndex! + 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOut);
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final Function(String, String) updateTaskStatus;

  TaskTile({Key? key, required this.task, required this.updateTaskStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isCompleted = task.status.toLowerCase() == 'completed';
    bool isOverdue = DateTime.now().isAfter(task.endTime) && !isCompleted;

    return Container(
      margin: const EdgeInsets.all(18.0),
      alignment: Alignment.center,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(25),
      //   boxShadow: [
      //     BoxShadow(
      //       color: PColors.accent3Light.withOpacity(0.1),
      //       spreadRadius: 2,
      //       blurRadius: 10,
      //       blurStyle: BlurStyle.outer,
      //       offset: const Offset(10, 10),
      //     ),
      //   ],
      //   border: Border.all(
      //     color: isOverdue ? PColors.accent4: PColors.accent1,
      //     width: 2,
      //   ),
      // ),
      decoration: PStyles.lightToDark(
        isOverdue ? PColors.accent2 : PColors.accent1,
      ),
      child: ListTile(
        title: Text('${task.name} (${task.tag})'),
        subtitle: Text(
          '${DateFormat.jm().format(task.startTime)} - ${DateFormat.jm().format(task.endTime)}',
          style: TextStyle(
            // color: isOverdue ? PColors.accent2 : PColors.accent1,
            decoration:
                isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        leading: CircleAvatar(
          child: isCompleted
              ? Icon(Icons.check, color: Colors.white)
              : isOverdue
                  ? Icon(Icons.close, color: Colors.white)
                  : Icon(Icons.hourglass_empty, color: Colors.white),
          backgroundColor: isCompleted
              ? PColors.accent1
              : isOverdue
                  ? PColors.accent2
                  : Colors.grey,
        ),
        trailing: isOverdue
            ? IconButton(
                icon: Icon(Icons.update),
                onPressed: () => updateTaskStatus(task.id, 'overdue'),
              )
            : isCompleted
                ? IconButton(
                    icon: Icon(Icons.undo),
                    onPressed: () => updateTaskStatus(task.id, 'pending'),
                  )
                : IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () => updateTaskStatus(task.id, 'completed'),
                  ),
      ),
    );
  }
}
