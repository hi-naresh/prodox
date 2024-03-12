import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import '../model/routine_model.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

void scheduleTaskNotification(TaskModel task) {
  DateTime now = DateTime.now();
  DateTime taskDateTime = DateTime(
    now.year,
    now.month,
    now.day,
    task.startTime.hour,
    task.startTime.minute,
  );

  // Schedule the notification if the task time is in the future
  if (taskDateTime.isAfter(now)) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'scheduled_channel',
        title: task.name,
        body: task.description,
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar.fromDate(date: taskDateTime),
    );
  }
}

void scheduleNotification(String title, String description, DateTime reminderTime) {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title: title,
      body: description,
      notificationLayout: NotificationLayout.Default,
    ),
    schedule: NotificationCalendar.fromDate(date: reminderTime),
  );
}



void startAnalyze(int frequencyInMinutes, int durationInDays, TimeOfDay sleepTime) {
  DateTime now = DateTime.now();
  for (int dayOffset = 0; dayOffset < durationInDays; dayOffset++) {
    DateTime day = now.add(Duration(days: dayOffset));
    // Calculate the total number of minutes in the day for looping
    int totalMinutesInDay = sleepTime.hour * 60 + sleepTime.minute;

    for (int minuteOffset = 0; minuteOffset < totalMinutesInDay; minuteOffset += frequencyInMinutes) {
      // Calculate the scheduled hour and minute
      int scheduledHour = minuteOffset ~/ 60;
      int scheduledMinute = minuteOffset % 60;

      DateTime scheduledTime = DateTime(day.year, day.month, day.day, scheduledHour, scheduledMinute);

      // Make sure we don't schedule notifications for the past
      if (scheduledTime.isAfter(now)) {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: createUniqueId(),
            channelKey: 'scheduled_channel',
            title: 'What have you done?',
            body: 'What did you do in the last ${frequencyInMinutes} minute(s)? Input here.',
            notificationLayout: NotificationLayout.Messaging,
          ),
          actionButtons: [
            NotificationActionButton(
              key: 'COMMENT_BUTTON_KEY',
              label: 'I did',
              requireInputText: true,
              actionType: ActionType.Default, // Modified to input field for direct reply
            ),
          ],
          schedule: NotificationCalendar.fromDate(date: scheduledTime),
        );
      }
    }
  }
}


