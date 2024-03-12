import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:prodox/bindings/general_bindings.dart';
import 'package:prodox/features/auth/screens/login/login_screen.dart';
import 'routes.dart';
import 'package:get/get.dart';
import '../utils/theme/theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // AwesomeNotifications().setListeners(
    //   onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    //   onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
    //   onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod,
    //   onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProdoX',
      theme: PAppTheme.lightTheme,
      darkTheme: PAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      // themeMode: theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: PRoutes.getSplashRoute(),
      getPages: PRoutes.routes,
    );
  }
}