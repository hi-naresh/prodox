import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prodox/screens/Home/widgets/daily_chores.dart';
import 'package:prodox/screens/Routine/analyze_routine.dart';
import 'package:prodox/screens/shared/custom_header.dart';

import '../../model/routine_model.dart';
import '../../services/ProductivityModel.dart';
import '../../services/data_fetch.dart';
import '../../services/category_model.dart';
import '../../services/notify_service.dart';
import '../Routine/set_routine.dart';

class HomeScreen extends StatelessWidget {

  TaskCategory? getCategoryForTask(String taskName) {
    // Replace this with your logic to categorize tasks , use tag for categorization , ignoreCase
    if (taskName.toLowerCase().contains('work')) {
      return TaskCategory.work;
    } else if (taskName.toLowerCase().contains('education')) {
      return TaskCategory.education;
    } else if (taskName.toLowerCase().contains('exercise')) {
      return TaskCategory.exercise;
    } else if (taskName.toLowerCase().contains('time pass')) {
      return TaskCategory.timePass;
    } else if (taskName.toLowerCase().contains('meditation')) {
      return TaskCategory.meditation;
    } else if (taskName.toLowerCase().contains('personal care')) {
      return TaskCategory.personalCare;
    } else if (taskName.toLowerCase().contains('leisure')) {
      return TaskCategory.leisure;
    } else if (taskName.toLowerCase().contains('social')) {
      return TaskCategory.social;
    } else if (taskName.toLowerCase().contains('chores')) {
      return TaskCategory.chores;
    } else if (taskName.toLowerCase().contains('family')) {
      return TaskCategory.family;
    } else if (taskName.toLowerCase().contains('finance')) {
      return TaskCategory.finance;
    } else if (taskName.toLowerCase().contains('volunteer')) {
      return TaskCategory.volunteer;
    } else if (taskName.toLowerCase().contains('creative')) {
      return TaskCategory.creative;
    } else if (taskName.toLowerCase().contains('spiritual')) {
      return TaskCategory.spiritual;
    } else if (taskName.toLowerCase().contains('professional')) {
      return TaskCategory.professional;
    } else if (taskName.toLowerCase().contains('fitness')) {
      return TaskCategory.fitness;
    } else if (taskName.toLowerCase().contains('mindfulness')) {
      return TaskCategory.mindfulness;
    } else if (taskName.toLowerCase().contains('outdoor')) {
      return TaskCategory.outdoor;
    } else if (taskName.toLowerCase().contains('planning')) {
      return TaskCategory.planning;
    } else {
      return null;
    }
  }

  void calculateDailyProductivity(BuildContext context) {
    fetchTasks().then((value) {
      List<TaskModel> tasks = value;

      List<Task> calTasks = tasks.map((task) {
        TaskCategory? category = getCategoryForTask(task.tag);
        if (category != null) {
          return Task(
            name: task.name,
            duration: task.endTime.difference(task.startTime),
            category: category,
          );
        }
        return null;
      }).whereType<Task>().toList(); // Filter out nulls if any task couldn't be categorized

      Routine routine = Routine(tasks: calTasks);
      //print all tasks in the routine
      print(calTasks.length);


      ProductivityModel productivityModel = ProductivityModel(routine: routine);
      double dailyProductivity = productivityModel.calculateDailyProductivity();
      double overallProductivity = productivityModel.calculateOverallProductivity();

      print('Your daily productivity is $dailyProductivity hours');
      print('Your overall productivity is $overallProductivity%');
      // Displaying the result
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Daily Productivity'),
          content: Text('Your daily productivity is ${dailyProductivity.toStringAsFixed(2)} hours'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }).catchError((error) {
      print("Error calculating productivity: $error");
      // Optionally, display an error message to the user
    });
  }

  void pushNotification() {
    // Implement push notification here
    fetchTasks().then((tasks) {
      for (TaskModel task in tasks) {
        scheduleTaskNotification(task);
      }
    });
  }

  Future<void> cancelScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
    print('All scheduled notifications are cancelled');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CustomHeader(title: ""),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SetRoutineScreen())
                  );
                },
                child: Text('Set Routine'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Analyze Mode Screen
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AnalyzeScreen())
                  );
                },
                child: Text('Analyze Mode'),
              ),
            ],
          ),
          ElevatedButton(
              onPressed:() {
                calculateDailyProductivity(context);
              },
              child: Text("Calculate")),
          ElevatedButton(
              onPressed:() {
                pushNotification();
              },
              child: Text("Remind Routine")),
          ElevatedButton(
              onPressed:() {
                cancelScheduledNotifications();
              },
              child: Text("Stop Reminders")),
          // Upcoming Tasks from Firebase
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Upcoming Tasks',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<TaskModel>>(
                    future: fetchTasks(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No tasks found'));
                      }
                      List<TaskModel> tasks = snapshot.data!;
                      return ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return ListTile(
                            title: Text(task.name),
                            subtitle: Text(task.description??''),
                            trailing: Text('${DateFormat.jm().format(task.startTime)} - ${DateFormat.jm().format(task.endTime)}'),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Weekly Productivity Bar Chart
          Expanded(child: DailyWidget()),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Weekly Productivity',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          AspectRatio(
            aspectRatio: 1.7,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              color: const Color(0xff020227),
              // child: BarChart(
              //   // We'll define the BarChartData below
              //   BarChartData(),
              // ),
            ),
          ),
          SizedBox(height: 80,)
          // Other widgets...
        ],
      ),
    );
  }
}