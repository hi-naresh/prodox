

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:prodox/services/auth/auth_service.dart';

import '../model/routine_model.dart';

final _auth =AuthService();

Future<List<TaskModel>> fetchTasks() async {
  // Fetch the routine for the logged-in user.
  final userId = _auth.currentUser?.uid ?? ''; // Ensure there's a fallback for a null UID
  final userRoutine = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('routines')
      .get();

  if (userRoutine.docs.isNotEmpty) {
    // Directly access the 'tasks' array in the document, not a subcollection
    final tasksField = userRoutine.docs.first.data()['tasks'] as List;
    return tasksField.map((taskMap) => TaskModel.fromJson(taskMap)).toList();
  } else {
    return [];
  }
}
//fetch username from firestore
String fetchUsername() {
  return _auth.currentUser?.displayName ?? 'No User';
}