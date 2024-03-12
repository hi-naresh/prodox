import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
class AnalyzeScreen extends StatefulWidget {
  const AnalyzeScreen({super.key});

  @override
  _AnalyzeScreenState createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends State<AnalyzeScreen> {
  final TextEditingController _askEveryController = TextEditingController();
  final TextEditingController _numberOfDaysController = TextEditingController();
  TimeOfDay? sleepTime;
  void _addTask() {
    // TODO: Implement functionality to add a task.
  }

  // void _startAnalysis() {
  //   // TODO: Implement functionality to start analysis.
  //   startAnalyze(1 , 1, sleepTime!);
  // }

  // Future<void> cancelScheduledNotifications() async {
  //   await AwesomeNotifications().cancelAllSchedules();
  //   print('All scheduled notifications are cancelled');
  // }

  void _pickTime(BuildContext context, bool isWakeUp) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isWakeUp ? TimeOfDay(hour: 7, minute: 0) : TimeOfDay(hour: 22, minute: 0),
    );

    if (pickedTime != null) {
      setState(() {
        sleepTime = pickedTime;
      });
    }
  }


  @override
  void dispose() {
    _askEveryController.dispose();
    _numberOfDaysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analyze'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _askEveryController,
              decoration: InputDecoration(
                labelText: 'Ask me every',
                hintText: 'i.e 2 hours',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _numberOfDaysController,
              decoration: InputDecoration(
                labelText: 'No. of days',
                hintText: 'i.e 3 days',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () => _pickTime(context, false),
              child: InputDecorator(
                decoration: InputDecoration(labelText: "Sleep at", border: OutlineInputBorder()),
                child: Text(sleepTime != null ? sleepTime!.format(context) : 'Select time'),
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Add task when asked',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 16),
            // Expanded(
            //   child: ValueListenableBuilder(
            //     valueListenable: Hive.box<RoutineModelAdapter>('routines').listenable(),
            //     builder: (context, Box<RoutineModelAdapter> box, _) {
            //       final routine = box.get('current_routine');
            //       if (routine != null && routine.tasks.isNotEmpty) {
            //         return ListView.builder(
            //           itemCount: routine.tasks.length,
            //           itemBuilder: (context, index) {
            //             final task = routine.tasks[index];
            //             final startTimeFormatted = DateFormat.jm().format(task.startTime); // Format start time
            //             final endTimeFormatted = DateFormat.jm().format(task.endTime); // Format end time
            //             return ListTile(
            //               title: Text(task.name),
            //               subtitle: Text(task.description),
            //               trailing: Text('$startTimeFormatted - $endTimeFormatted'),
            //             );
            //           },
            //         );
            //       } else {
            //         return Center(child: Text('No tasks found for today'));
            //       }
            //     },
            //   ),
            // ),

            Center(
              child: ElevatedButton.icon(
                onPressed: _addTask,
                icon: Icon(Icons.add),
                label: Text('ADD TASK'),
              ),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: (){},
                child: Text('Start'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
