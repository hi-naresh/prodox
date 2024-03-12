import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:prodox/model/hive/daily_task.dart'; // Adjust the import path to where your DailyTask model is located
import 'package:prodox/services/notify_service.dart';

class DailyTaskScreen extends StatefulWidget {
  @override
  _DailyTaskScreenState createState() => _DailyTaskScreenState();
}

class _DailyTaskScreenState extends State<DailyTaskScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  DateTime? _reminderTime;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  Future<void> _pickReminderTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _reminderTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  void _saveTask() async {
    final box = Hive.box<DailyTask>('dailyTasks');
    final newTask = DailyTask(
      name: _nameController.text,
      description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
      tag: _tagController.text,
      reminderTime: _reminderTime!,
      completed: false,
    );

    await box.add(newTask); // Using add to let Hive auto-generate a key

    // Schedule notification
    if (_reminderTime != null) {
      scheduleNotification(_nameController.text, _descriptionController.text, _reminderTime!);
    }

    // Optionally clear the form fields after saving
    _clearFormFields();
  }

  void _clearFormFields() {
    setState(() {
      _nameController.clear();
      _descriptionController.clear();
      _tagController.clear();
      _reminderTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Daily Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Task Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description (Optional)'),
            ),
            TextField(
              controller: _tagController,
              decoration: InputDecoration(labelText: 'Tag'),
            ),
            ListTile(
              title: Text(_reminderTime == null ? 'Pick Reminder Time' : 'Reminder: ${DateFormat('yyyy-MM-dd – kk:mm').format(_reminderTime!)}'),
              onTap: () => _pickReminderTime(context),
            ),
            ElevatedButton(
              onPressed: _saveTask,
              child: Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
