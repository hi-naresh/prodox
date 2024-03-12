// import 'dart:math';
// import 'dart:ui';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:prodox/provider/App_State/app_state_provider.dart';
import 'package:prodox/provider/Extras/user_data_provider.dart';
import 'package:prodox/screens/Extras/on_board.dart';
import 'package:prodox/screens/Main/main_screen.dart';
import 'package:prodox/utils/notification_controller.dart';
import 'package:prodox/utils/pref.dart';
import 'package:prodox/utils/routes.dart';
import 'package:path_provider/path_provider.dart';

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
  Hive.init(appDocumentDir.path);
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

class MyApp extends StatefulWidget {
  // final bool isUserSignedIn;
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // User? _user;

  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod,
        onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
    );
    super.initState();
    // checkUserLoggedIn();
  }

  // void checkUserLoggedIn() async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user = auth.currentUser;
  //   if (user != _user) {
  //     setState(() {
  //       _user = user;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppStateProvider>(
          create: (BuildContext context) {
            return AppStateProvider();
          },
        ),
        // ChangeNotifierProvider<TodoProvider>(
        //   create: (BuildContext context) {
        //     return TodoProvider();
        //   },
        // ),
        ChangeNotifierProvider<UserDataProvider>(
          create: (BuildContext context) {
            return UserDataProvider();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KYB',
        routes: routes,
        // initialRoute: '/',
        // themeMode: theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: onLoggedin(),
      ),
    );
  }
}

class onLoggedin extends StatelessWidget {
  const onLoggedin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MainScreen();
          } else {
            return  OnBoardingScreen();
          }
        }
    );
  }
}
