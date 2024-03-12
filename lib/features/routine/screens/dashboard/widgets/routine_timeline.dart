import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prodox/features/routine/screens/dashboard/widgets/task_tile.dart';
class RoutineTimeline extends StatefulWidget {
  const RoutineTimeline({super.key});

  @override
  _RoutineTimelineState createState() => _RoutineTimelineState();
}

class _RoutineTimelineState extends State<RoutineTimeline> {
  //dynamic - TaskModel
  late Future<List<dynamic>> futureTasks;
  PageController? _pageController;
  int? _nearestTaskIndex;

  @override
  void initState() {
    super.initState();
    // futureTasks = fetchTasks();
  }

  Future<void> updateTaskStatus(String taskId, String newStatus) async {
    // Implement this method to update the task status in your backend or database
  }

  //dynamic - TaskModel
  int findNearestTaskIndex(List<dynamic> tasks) {
    final now = DateTime.now();
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].endTime.isAfter(now)) return i;
    }
    return tasks.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
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

        //dynamic - TaskModel
        List<dynamic> tasks = snapshot.data!;
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
