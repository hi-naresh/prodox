import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimelineScreen extends StatefulWidget {
  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  List<String> activities = [];

  @override
  void initState() {
    super.initState();
    loadActivities();
  }

  Future<void> loadActivities() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Assuming your activities are stored as a list of strings
    List<String>? storedActivities = prefs.getStringList('activities');
    if (storedActivities != null) {
      setState(() {
        activities = storedActivities;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(activities[index]),
            // Here you can format the title string to display it nicely
          );
        },
      ),
    );
  }
}
