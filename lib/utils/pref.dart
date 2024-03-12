import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }
  static void saveHasOnboarded(bool canAuth) {
    int permissionIndex = 0;
    if (canAuth == true) {
      permissionIndex = 1;
    }
    preferences!.setInt("hasonboarded", permissionIndex);
  }

  static bool hasOnboarded() {
    final index = preferences!.getInt("hasonboarded");

    if (index == null) {
      return false;
    }

    return index == 1 ? true : false;
  }

  static Future<void> saveUserName({required String name}) async {
    await preferences?.setString("alias", name);
  }

  static String getUserName() {
    String? userName = preferences!.getString("alias");
    if (userName == null) {
      return "";
    }
    return userName;
  }

  static Future<void> saveAvatar({required String avatar}) async {
    await preferences?.setString("avatar", avatar);
  }

  static String getAvatar() {
    String? avatar = preferences!.getString("avatar");
    if (avatar == null) {
      return "avatar1";
    }
    return avatar;
  }

  // static Future<void> saveToDoList({required List<DailyTasks> todos}) async {
  //   List<String> todoList = [];
  //   for (DailyTasks task in todos) {
  //     todoList.add(jsonEncode(task));
  //   }
  //   await preferences?.setStringList(
  //       DateFormat.yMd().format(DateTime.now()), todoList);
  // }
  //
  // static List<DailyTasks> getTodoList({required DateTime dateTime}) {
  //   List<DailyTasks> tasks = [];
  //   final taskMap = preferences!.getStringList(
  //     DateFormat.yMd().format(dateTime),
  //   );
  //
  //   if (taskMap == null) {
  //     return tasks;
  //   }
  //
  //   for (String task in taskMap) {
  //     tasks.add(
  //       DailyTasks.fromMap(jsonDecode(jsonDecode(task)) as Map<String, dynamic>),
  //     );
  //   }
  //   return tasks;
  // }

  static void saveTheme(bool isDark) {
    int themeIndex = 0;
    if (isDark == true) {
      themeIndex = 1;
    }
    preferences!.setInt("themeindex", themeIndex);
  }

  static int getSavedTheme() {
    final index = preferences!.getInt("themeindex");

    if (index == null) {
      return 0;
    }

    return index;
  }

  static void saveScores(int point) {
    int points = getPoints();
    preferences!.setInt("points", point + points);
  }

  static int getPoints() {
    final scores = preferences!.getInt("points");

    if (scores == null) {
      return 0;
    }

    return scores;
  }

  static void saveAuthPermission(bool canAuth) {
    int permissionIndex = 0;
    if (canAuth == true) {
      permissionIndex = 1;
    }
    preferences!.setInt("authpermission", permissionIndex);
  }

  static void saveReminderNotificationPermission(bool canNotify) {
    int permissionIndex = 0;
    if (canNotify == true) {
      permissionIndex = 1;
    }
    preferences!.setInt("notifypermission", permissionIndex);
  }

  static void saveNotificationTime(Duration duration) {
    List<String> time = [
      duration.inHours.toString(),
      duration.inMinutes.remainder(60).toString()
    ];

    preferences!.setStringList("notifytime", time);
  }

  static Duration getNotificationTime() {
    List<String>? time = preferences!.getStringList("notifytime");
    if (time == null) {
      return const Duration(hours: 20, minutes: 00);
    }

    return Duration(hours: int.parse(time[0]), minutes: int.parse(time[1]));
  }

  static bool getReminderNotificationPermission() {
    final index = preferences!.getInt("notifypermission");

    if (index == null) {
      return false;
    }

    return index == 1 ? true : false;
  }

  static void saveNotificationPermission(bool canNotify) {
    int permissionIndex = 0;
    if (canNotify == true) {
      permissionIndex = 1;
    }
    preferences!.setInt("notification", permissionIndex);
  }

  static bool getNotificationPermission() {
    final index = preferences!.getInt("notification");

    if (index == null) {
      return false;
    }

    return index == 1 ? true : false;
  }

  static bool getAuthPermission() {
    final index = preferences!.getInt("authpermission");

    if (index == null) {
      return false;
    }

    return index == 1 ? true : false;
  }

  static void saveUserResponse({required String response}) {
    preferences!.setString("userresponse", response);
  }
  //
  // static void saveDate(DateTime date) async {
  //   final String dateNow = DateFormat('dd-MM-yyyy').format(date);
  //   preferences!.setString("currentDate", dateNow);
  // }
  //
  // static String getDate() {
  //   final String? date = preferences!.getString("currentDate");
  //   if (date == null) {
  //     SharedPreferencesHelper.saveDate(DateTime.now());
  //     return DateFormat('dd-MM-yyyy').format(DateTime.now());
  //   }
  //   return date;
  // }
}
