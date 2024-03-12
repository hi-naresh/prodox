import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:prodox/model/hive/routine_hive.dart';
import 'package:prodox/model/hive/task_hive.dart';

import '../model/routine_model.dart';
import 'auth/auth_service.dart';

void startEndOfDayUploadChecker(TimeOfDay sleepTime) {
  Timer.periodic(Duration(minutes: 1), (Timer timer) async {
    final currentTime = TimeOfDay.now();
    if (currentTime.hour == sleepTime.hour && currentTime.minute >= sleepTime.minute) {
      await uploadRoutineData();
      timer.cancel(); // Stop the timer if the day is over
    }
  });
}

final _auth = AuthService();

Future<void> uploadRoutineData() async {
  final routinesBox = Hive.box<RoutineModel>('routines');
  final routine = routinesBox.get('current_routine');

  final userId = _auth.currentUser?.uid ?? ''; // Ensure there's a fallback for a null UID

  if (routine != null) {
    // Perform the upload logic here, possibly converting the RoutineModel to a Map or JSON
    // For example:
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('analyze_routines').add(routine.toJson());

    // After successful upload, clear the current routine
    routinesBox.delete('current_routine');
  }
}
Future<void> saveResponse(String response) async {
  Hive.registerAdapter(RoutineModelAdapterAdapter());
  Hive.registerAdapter(TaskModelAdapterAdapter());
  Box<RoutineModel>? routinesBox;
  try {
    if (!Hive.isBoxOpen('routines')) {
      routinesBox = await Hive.openBox<RoutineModel>('routines');

    } else {
      routinesBox = Hive.box<RoutineModel>('routines');
    }
  } catch (e) {
    print('Error opening routines box: $e');
  }


  const routineKey = 'current_routine';
  final routine = routinesBox?.get(routineKey);
  final taskId = Random().nextInt(1000000); // Replace with your logic to generate unique ID
  final currentTime = DateTime.now();

  if (routine == null) {
    final newRoutine = RoutineModel(
      id: routineKey,
      userId: _auth.currentUser?.uid ?? 'default_user',
      tasks: [
        TaskModel(
          id: taskId.toString(),
          name: response,
          description: 'Completed task',
          tag: 'default_tag',
          startTime: currentTime,
          endTime: currentTime.add(Duration(hours: 1)),
          status: 'pending',
        ),
      ],
    );
    await routinesBox?.put(routineKey, newRoutine);
  } else {
    final updatedTasks =
        TaskModel(
          id: taskId.toString(),
          name: response,
          description: 'Completed task',
          tag: 'default_tag',
          startTime: currentTime,
          endTime: currentTime.add(Duration(minutes: 1)),
          status: 'pending',
        )
      ;
    routine.tasks.add(updatedTasks);
    await routinesBox?.put(routineKey, routine);
  }
}



//needs correction
Future<void> updateTaskStatusInFirestore(String taskId, String status) async {
  try {
    final userId = _auth.currentUser?.uid ?? 'No_User';

    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection('routines')
        .doc()
        .collection('tasks') // Adjust this path to match your Firestore structure
        .doc(taskId)
        .update({'status': status});
    print('Task status updated to $status successfully');
  } catch (e) {
    print('Error updating task status: $e');
  }
}



