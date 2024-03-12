import 'package:get/get.dart';
import 'package:prodox/app.dart';
import 'package:prodox/screens/Extras/onboard.dart';
import 'package:prodox/screens/Extras/splash_screen.dart';
import 'package:prodox/screens/Home/home_screen.dart';
import 'package:prodox/screens/Main/main_screen.dart';
import 'package:prodox/screens/Profile/Account%20Screen/account_screen.dart';
import 'package:prodox/screens/Profile/setup_profile.dart';
import 'package:prodox/screens/Register/register_screen.dart';
import 'package:prodox/screens/Routine/set_routine.dart';
import '../screens/Register/login_screen.dart';
import '../screens/Routine/analyze_routine.dart';

class PRoutes{
  static const String main = '/';
  static const String home = '/home';
  static const String onLogged = '/onLogged';
  static const String splash = '/splash';
  static const String onBoarding = '/onBoarding';
  static const String register = '/register';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String profile = '/profile';
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

  static String getMainRoute() => main;
  static String getOnLoggedRoute() => onLogged;
  static String getSplashRoute() => splash;
  static String getSetRoutineRoute() => setRoutine;
  static String getAnalyzeRoutineRoute() => analyzeRoutine;
  static String getHomeRoute() => home;
  static String getOnBoardingRoute() => onBoarding;
  static String getRegisterRoute() => register;
  static String getLoginRoute() => login;
  static String getSignupRoute() => signup;
  static String getProfileRoute() => profile;
  static String getAnalyticsRoute() => analytics;
  static String getNotificationsRoute() => notifications;
  static String getAddTaskRoute() => addTask;
  static String getSettingsRoute() => settings;
  static String getAboutRoute() => about;
  static String getContactRoute() => contact;
  static String getHelpRoute() => help;
  static String getTermsRoute() => terms;
  static String getPrivacyRoute() => privacy;


  static List<GetPage<dynamic>> routes = [
    GetPage(name: main, page: () => const MainScreen(),
        transition: Transition.fadeIn , transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage (name: onBoarding, page: () => const OnBoard(),
        transition: Transition.circularReveal , transitionDuration: const Duration(milliseconds: 800)
    ),
    GetPage(name: splash, page: () => const SplashScreen(), transition: Transition.fadeIn),
    GetPage (name: register, page: () =>  RegisterScreen(),
        transition: Transition.circularReveal , transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(name: login, page: () =>  const LoginScreen()),
    GetPage(name: setRoutine, page: () => const SetRoutineScreen(),
        transition: Transition.circularReveal , transitionDuration: const Duration(milliseconds: 300)
    ),
    GetPage(name: analyzeRoutine, page: () =>  const AnalyzeScreen(),
        transition: Transition.circularReveal , transitionDuration: const Duration(milliseconds: 300)
    ),
    GetPage(name: settings, page: () => const AccountScreen(),
        transition: Transition.circularReveal, transitionDuration: const Duration(milliseconds: 300)
    ),
    GetPage(name: profile, page: () => const SetupProfileScreen(),
        transition: Transition.circularReveal, transitionDuration: const Duration(milliseconds: 300)
    ),
  ];
}