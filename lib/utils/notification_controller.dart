import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hive/hive.dart';
import 'package:prodox/services/data_handle.dart';
import 'package:prodox/utils/pref.dart';

class NotificationController{
  final _mybox = Hive.box('routines');

  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    print('Notification created');
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    print('Notification displayed');
  }

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    print('Notification action');
    if (receivedAction.buttonKeyPressed == 'COMMENT_BUTTON_KEY') {
      String userResponse = receivedAction.buttonKeyInput;
      print('User response: $userResponse');
      saveResponse(userResponse);
    }
  }

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    print('Notification dismissed');
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationButtonPressed(ReceivedAction receivedAction) async {
    print('Notification button pressed');
  }
}