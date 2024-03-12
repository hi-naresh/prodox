import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prodox/services/category_model.dart';
import 'package:prodox/services/auth/auth_service.dart';

import '../../model/routine_model.dart';

class SetRoutineScreen extends StatefulWidget {
  const SetRoutineScreen({super.key});

  @override
  _SetRoutineScreenState createState() => _SetRoutineScreenState();
}

class _SetRoutineScreenState extends State<SetRoutineScreen> {
  TimeOfDay? wakeUpTime;
  TimeOfDay? sleepTime;
  List<bool> daysSelected = List.generate(7, (index) => false);
  late String _selectedCategory ;
  List<TaskModel> tasks = [];
  List<String> taskCategories = [
    'Work',
    'Education',
    'Exercise',
    'Time Pass',
    'Meditation',
    'Personal Care',
    'Leisure',
    'Social',
    'Chores',
    'Family',
    'Finance',
    'Volunteer',
    'Creative',
    'Spiritual',
    'Professional',
    'Fitness',
    'Mindfulness',
    'Outdoor',
    'Planning',
  ];
  final _auth = AuthService();

  @override
  void initState() {
    super.initState();
    // _fetchLastRoutine();
  }

  void _pickTime(BuildContext context, bool isWakeUp) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isWakeUp ? TimeOfDay(hour: 7, minute: 0) : TimeOfDay(hour: 22, minute: 0),
    );

    if (pickedTime != null) {
      setState(() {
        if (isWakeUp) {
          wakeUpTime = pickedTime;
        } else {
          sleepTime = pickedTime;
        }
      });
    }
  }

  Future<void> _showAddTaskDialog(BuildContext context) async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController durationController = TextEditingController(); // Duration controller
    TimeOfDay? startTime = tasks.isNotEmpty
        ? TimeOfDay(hour: tasks.last.endTime.hour, minute: tasks.last.endTime.minute)
        : wakeUpTime;
    TimeOfDay endTime; // Will be set after duration is entered

    if (startTime == null || sleepTime == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please select wake up and sleep times first.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        if (startTime.hour > (sleepTime?.hour ?? 24) || (startTime.hour == sleepTime?.hour && startTime.minute >= sleepTime!.minute)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('End of routine reached. No more tasks can be added.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        // Adjust endTime if it goes beyond sleepTime with no errors
        // if (endTime.hour > (sleepTime?.hour ?? 24) || (endTime.hour == sleepTime?.hour && endTime.minute > sleepTime!.minute)) {
        //   endTime = sleepTime!;
        // }

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Add New Task'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: "Task Title"),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(hintText: "Description"),
                ),
                TextField(
                  controller: durationController,
                  decoration: InputDecoration(hintText: "Duration in minutes"),
                  keyboardType: TextInputType.number, // Ensure numeric input
                ),
                //create me list option for TaskCategory
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  value: 'Work',
                  onChanged: (String? value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                  //items from enum taskCategory into the list of dropdown items
                  items : taskCategories.map((String category){
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (titleController.text.isEmpty || durationController.text.isEmpty) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    SnackBar(
                      content: Text('Title, description, and duration cannot be empty.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                final int durationInMinutes = int.tryParse(durationController.text) ?? 0;
                final DateTime now = DateTime.now();
                final DateTime startDateTime = DateTime(now.year, now.month, now.day, startTime.hour, startTime.minute);
                final DateTime endDateTime = startDateTime.add(Duration(minutes: durationInMinutes));

                // Here we check if the end time is within the wake-up and sleep time limits
                // If it's not, display an error or adjust the end time to match the sleep time.

                setState(() {
                  tasks.add(TaskModel(
                    id: DateTime.now().toIso8601String(), // Assuming id is generated based on the current time
                    name: titleController.text,
                    description: descriptionController.text,
                    tag: _selectedCategory,
                    startTime: startDateTime,
                    endTime: endDateTime,
                    status: 'pending', // Assuming the task is pending when added
                  ));
                });
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  TimeOfDay addDuration(TimeOfDay startTime, Duration duration) {
    final int totalMinutes = startTime.hour * 60 + startTime.minute + duration.inMinutes;
    final int endHour = totalMinutes ~/ 60;
    final int endMinute = totalMinutes % 60;
    return TimeOfDay(hour: endHour % 24, minute: endMinute); // Mod 24 to prevent invalid hour
  }

  void _saveRoutine() {
    // Ensure wakeUpTime and sleepTime are set
    if (wakeUpTime == null || sleepTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please set both wake up and sleep times.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Check that the last task ends at or after sleepTime
    if (tasks.isNotEmpty) {
      final lastTask = tasks.last;
      final lastTaskEnd = TimeOfDay(hour: lastTask.endTime.hour, minute: lastTask.endTime.minute);
      if (lastTaskEnd.hour < sleepTime!.hour ||
          (lastTaskEnd.hour == sleepTime!.hour && lastTaskEnd.minute < sleepTime!.minute)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The routine does not cover all time slots until sleep time.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    // Convert TimeOfDay to DateTime for comparison
    final now = DateTime.now();
    final wakeUpDateTime = DateTime(now.year, now.month, now.day, wakeUpTime!.hour, wakeUpTime!.minute);
    final sleepDateTime = DateTime(now.year, now.month, now.day, sleepTime!.hour, sleepTime!.minute);

    // Check for gaps between tasks
    DateTime previousEndTime = wakeUpDateTime;
    for (var task in tasks) {
      if (task.startTime.isAfter(previousEndTime)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('There is a gap between tasks. Please fill all time slots.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      previousEndTime = task.endTime;
    }

    if (previousEndTime.isBefore(sleepDateTime)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('The routine does not cover all time slots until sleep time.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // All checks passed, proceed with saving the routine
    final userId = _auth.currentUser?.uid ?? ''; // Ensure there's a fallback for a null UID

    RoutineModel routine = RoutineModel(
      id: DateTime.now().toIso8601String(), // Generating a new ID for the routine
      userId: userId,
      tasks: tasks,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('routines')
        .add(routine.toJson())
        .then((docRef) {
      print('Routine saved with ID: ${docRef.id}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Routine saved successfully.'),
          backgroundColor: Colors.green,
        ),
      );
    }).catchError((error) {
      print('Failed to save routine: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save routine.'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  // void _saveRoutine() {
  //   if (tasks.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Please add at least one task.'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }
  //
  //   // Assuming we have a logged in user and we have their userId
  //   String userId = 'replace_with_actual_user_id'; // Replace with actual user ID logic
  //
  //   RoutineModel routine = RoutineModel(
  //     id: DateTime.now().toIso8601String(), // Generating a new ID for the routine
  //     userId: userId,
  //     tasks: tasks,
  //   );
  //
  //   // Here you would call Firestore to save the routine
  //   FirebaseFirestore.instance.collection('routines').add(routine.toJson()).then((docRef) {
  //     print('Routine saved with ID: ${docRef.id}');
  //   }).catchError((error) {
  //     print('Failed to save routine: $error');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Failed to save routine.'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Routine'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => _pickTime(context, true),
                child: InputDecorator(
                  decoration: InputDecoration(labelText: "Wake up", border: OutlineInputBorder()),
                  child: Text(wakeUpTime != null ? wakeUpTime!.format(context) : 'Select time'),
                ),
              ),
              SizedBox(height: 16),
              InkWell(
                onTap: () => _pickTime(context, false),
                child: InputDecorator(
                  decoration: InputDecoration(labelText: "Sleep at", border: OutlineInputBorder()),
                  child: Text(sleepTime != null ? sleepTime!.format(context) : 'Select time'),
                ),
              ),
              SizedBox(height: 16),
              Wrap(
                spacing: 8.0,
                children: List<Widget>.generate(7, (int index) {
                  return ChoiceChip(
                    label: Text(['M', 'T', 'W', 'T', 'F', 'S', 'S'][index]),
                    selected: daysSelected[index],
                    onSelected: (bool selected) {
                      setState(() {
                        daysSelected[index] = selected;
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Text(
                'Add your routine (without any skip)',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 16),
              for (var task in tasks) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(task.name),
                    Text( '${DateFormat.jm().format(task.startTime)} - ${DateFormat.jm().format(task.endTime)}'),
                  ],
                ),
                SizedBox(height: 8),
              ],
              SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () => _showAddTaskDialog(context),
                  icon: Icon(Icons.add),
                  label: Text('Add Task'),
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: (){
                    _saveRoutine();
                  },
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
