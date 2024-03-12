import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:prodox/utils/pref.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';
import 'model/hive/daily_task.dart';
import 'model/hive/routine_hive.dart';
import 'model/hive/task_hive.dart';
import 'model/routine_model.dart';

//
// @pragma('vm:entry-point')
// callbackDispatcher() {
//   DartPluginRegistrant.ensureInitialized();
//   Workmanager().executeTask((task, inputData) async {
//     final now = DateTime.now();
//     final start = DateTime(now.year, now.month, now.day, 9);
//     final end = DateTime(now.year, now.month, now.day, 21); // 9 pm
//     await SharedPreferencesHelper.init();
//
//     if (now.isAfter(start) &&
//         now.isBefore(end) &&
//         SharedPreferencesHelper.getNotificationPermission()) {
//       final random = Random();
//       final quoteIndex = random.nextInt(affirmations.length);
//       String quote = affirmations[quoteIndex];
//       final titleIndex = random.nextInt(quotesTitle.length);
//       String title = quotesTitle[titleIndex];
//       NotificationManager.showNotification(title: title, body: quote);
//     }
//
//     return Future.value(true);
//   });
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

    Hive.registerAdapter(RoutineModelAdapterAdapter());
    Hive.registerAdapter(TaskModelAdapterAdapter());
    Hive.registerAdapter(DailyTaskAdapter());



  await Hive.openBox<RoutineModel>('routines');
  await Hive.openBox<DailyTask>('dailyTasks');
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Task Notifications',
        channelDescription: 'Notifications when a task is due',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        // channelShowBadge: true,
        // enableVibration: true,
        // locked: true,
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'Basic Channel Group',),
    ],
  );
  bool isNotificationAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isNotificationAllowed) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  // final authService = AuthService();
  // bool isUserSignedIn = await authService.isUserSignedIn();
  // initializeTimeZones();
  await SharedPreferencesHelper.init();
  runApp( const MyApp(
    // isUserSignedIn: isUserSignedIn
  ));
}
