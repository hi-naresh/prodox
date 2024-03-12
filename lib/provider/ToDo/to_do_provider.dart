// import 'package:flutter/material.dart';
//
// import '../../model/To Do/daily_tasks.dart';
// import '../../utils/pref.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class TodoProvider extends ChangeNotifier {
//   final List<DailyTasks> _toDoList =
//   SharedPreferencesHelper.getTodoList(dateTime: DateTime.now());
//   bool _isAdding = false;
//   final TextEditingController _todoTextEditingController =
//   TextEditingController();
//
//   // Initialize FlutterLocalNotificationsPlugin
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   TodoProvider() {
//     _initializeNotifications();
//   }
//
//   Future<void> _initializeNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('app_icon');
//     final InitializationSettings initializationSettings =
//     const InitializationSettings(android: initializationSettingsAndroid);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   List<DailyTasks> get toDolist => _toDoList;
//   bool get isAdding => _isAdding;
//   TextEditingController get todoTextEditingController =>
//       _todoTextEditingController;
//
//   void updateIsAdding(bool isAdding) {
//     _isAdding = isAdding;
//     notifyListeners();
//   }
//
//   void addToDo(DailyTasks todo) {
//     _toDoList.add(todo);
//     SharedPreferencesHelper.saveToDoList(todos: _toDoList);
//     notifyListeners();
//     _todoTextEditingController.clear();
//   }
//
//   void updateTodo({required int index, required DailyTasks DailyTasks}) {
//     _toDoList.removeAt(index);
//     _toDoList.insert(index, DailyTasks);
//     SharedPreferencesHelper.saveToDoList(todos: _toDoList);
//     notifyListeners();
//
//     // Check if the task is completed
//     if (DailyTasks.isDone) {
//       _sendAppreciationNotification();
//     }
//   }
//
//   Future<void> _sendAppreciationNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'appreciation_channel',
//       'Channel for sending motivational appreciation notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     const NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Task Completed!',
//       'Great job! You completed a task from your to-do list.',
//       platformChannelSpecifics,
//       payload: 'appreciation',
//     );
//   }
//
//   int getUncompletedTasksCount() {
//     int tasks = 0;
//     for (DailyTasks d in _toDoList) {
//       if (!d.isDone) {
//         tasks += 1;
//       }
//     }
//     return tasks;
//   }
// }
