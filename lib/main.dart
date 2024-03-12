import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';
import 'data/repo/auth/auth_repo.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  )
      .then((FirebaseApp value) => Get.put(AuthRepo()));

  // await AwesomeNotifications().initialize(
  //   null,
  //   [
  //     NotificationChannel(
  //       channelKey: 'scheduled_channel',
  //       channelName: 'Task Notifications',
  //       channelDescription: 'Notifications when a task is due',
  //       defaultColor: Color(0xFF9D50DD),
  //       ledColor: Colors.white,
  //       importance: NotificationImportance.High,
  //       // channelShowBadge: true,
  //       // enableVibration: true,
  //       // locked: true,
  //     ),
  //   ],
  //   channelGroups: [
  //     NotificationChannelGroup(
  //       channelGroupKey: 'basic_channel_group',
  //       channelGroupName: 'Basic Channel Group',),
  //   ],
  // );
  // bool isNotificationAllowed = await AwesomeNotifications().isNotificationAllowed();
  // if (!isNotificationAllowed) {
  //   AwesomeNotifications().requestPermissionToSendNotifications();
  // }
  // await SharedPreferencesHelper.init();
  runApp(const MyApp());
}
