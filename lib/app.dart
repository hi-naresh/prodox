import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prodox/utils/p_routes.dart';
import 'package:prodox/utils/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:prodox/provider/App_State/app_state_provider.dart';
import 'package:prodox/provider/Extras/user_data_provider.dart';
import 'package:prodox/utils/notification_controller.dart';
import 'package:get/get.dart';

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
  }

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
        ChangeNotifierProvider<UserDataProvider>(
          create: (BuildContext context) {
            return UserDataProvider();
          },
        ),
      ],
      child: Consumer<AppStateProvider>(
        builder: (context, theme, child)
          => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ProdoX',
          theme: PAppTheme.lightTheme,
          darkTheme: PAppTheme.darkTheme,
          themeMode: theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: PRoutes.getSplashRoute(),
          getPages: PRoutes.routes,
        ),
      ),
    );
  }
}