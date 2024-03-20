import 'package:get/get.dart';
import 'package:prodox/common/extras/notification_screen.dart';
import 'features/master.dart';
import 'features/personalisation/screens/profile/profile_screen.dart';
import 'features/personalisation/screens/profile/profile_setup.dart';
import 'features/personalisation/screens/settings/setting_screen.dart';
import 'features/routine/screens/dashboard/dashboard_screen.dart';
import 'common/extras/splash_screen.dart';
import 'features/auth/screens/login/login_screen.dart';
import 'features/auth/screens/pass_reset/password_reset.dart';
import 'features/auth/screens/signup/signup_screen.dart';
import 'features/auth/screens/onboard/onboard.dart';
import 'features/routine/screens/tracker/analyze_routine.dart';
import 'features/routine/screens/tracker/set_routine.dart';

class PRoutes{
  static const String master = '/';
  static const String dashboard = '/home';
  static const String onLogged = '/onLogged';
  static const String splash = '/splash';
  static const String onBoarding = '/onBoarding';
  static const String register = '/register';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String passwordReset = '/passwordReset';
  static const String profileSetup = '/profile';

  static const String analytics = '/analytics';
  static const String notifications = '/notifications';
  static String setRoutine = '/setRoutine';
  static const String analyzeRoutine = '/analyzeRoutine';
  static const String addTask = '/addTask';
  static const String settings = '/settings';
  static const String about = '/about';
  static const String contact = '/contact';
  static const String help = '/help';
  static const String terms = '/terms';
  static const String privacy = '/privacy';
  static const String profileEdit = '/profileEdit';

  static String getMasterRoute() => master;
  static String getOnLoggedRoute() => onLogged;
  static String getSplashRoute() => splash;
  static String getSetRoutineRoute() => setRoutine;
  static String getAnalyzeRoutineRoute() => analyzeRoutine;
  static String getHomeRoute() => dashboard;
  static String getOnBoardingRoute() => onBoarding;
  static String getRegisterRoute() => register;
  static String getProfileEditRoute() => profileEdit;
  static String getLoginRoute() => login;
  static String getSignupRoute() => signup;
  static String getPasswordResetRoute() => passwordReset;
  static String getProfileRoute() => profileSetup;
  static String getAnalyticsRoute() => analytics;
  static String getNotificationsRoute() => notifications;
  static String getAddTaskRoute() => addTask;
  static String getSettingsRoute() => settings;
  static String getAboutRoute() => about;
  static String getContactRoute() => contact;
  static String getHelpRoute() => help;
  static String getTermsRoute() => terms;
  static String getPrivacyRoute() => privacy;

  static List<GetPage> routes =[
    GetPage(name: master, page: () =>  MasterScreen()),
    GetPage(name: splash, page: () => const SplashScreen(), transition: Transition.fadeIn),
    GetPage(name: onBoarding, page: () => const OnBoard()),
    GetPage(name: profileSetup, page: () => const ProfileSetupScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: signup, page: () => const SignUpScreen()),
    GetPage(name: passwordReset, page: () => const PasswordResetScreen()),
    GetPage(name: dashboard, page: () => const DashboardScreen()),
    GetPage(name: setRoutine, page: () => const SetRoutineScreen(),
        transition: Transition.circularReveal , transitionDuration: const Duration(milliseconds: 300)
    ),
    GetPage(name: analyzeRoutine, page: () =>  const AnalyzeScreen(),
        transition: Transition.circularReveal , transitionDuration: const Duration(milliseconds: 300)
    ),
    GetPage(name: settings, page: () => const SettingScreen()),
    GetPage(name: profileEdit, page: () => const ProfileEditScreen()),
    GetPage(name: notifications, page: () => const NotificationsScreen()),

  ];
}