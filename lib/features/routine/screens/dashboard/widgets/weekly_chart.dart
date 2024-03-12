import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../../data/services/productivity/ProductivityModel.dart';
import '../../../../../utils/constants/colors.dart';

class WeeklyChart extends StatefulWidget {
  @override
  _WeeklyChartState createState() => _WeeklyChartState();
}

class _WeeklyChartState extends State<WeeklyChart> {
  //change dynmaic - routine
  late Future<List<dynamic>> futureWeeklyRoutines;

  @override
  void initState() {
    super.initState();
    // futureWeeklyRoutines = populateWeeklyRoutines();
  }

  static BarChartGroupData generateGroupData(
      //change dynamic -Routine , TaskCategory
      int x, dynamic routine,
      bool hasData,
      Map<dynamic, int> totalCategoryDurations,
      double totalRoutineDuration
      ) {
    final greyColor = Colors.grey;

    final spaceBetweenBars = 0.1;


    List<BarChartRodData> barRods = [];
    double cumulativeDuration = 0;

    if (hasData) {
      // Order categories if necessary
      var values;//values - task Category
      //dynamic - taskCategory
      List<dynamic> sortedCategories = values;
      for (var category in sortedCategories) {
        final categoryDuration = totalCategoryDurations[category] ?? 0.0;
        //only add if duration is greater than 0
        if (categoryDuration > 0) {
          barRods.add(
            BarChartRodData(
              fromY: cumulativeDuration ,
              toY: cumulativeDuration + categoryDuration,
              //category colors
              color: categoryColors[category] ?? greyColor,
              width: 10,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
          );
        }
        cumulativeDuration += categoryDuration ;
        cumulativeDuration += spaceBetweenBars;
      }
    } else {
      return BarChartGroupData(
        x: x,
        barRods: [
          BarChartRodData(
            toY: totalRoutineDuration,
            color: Colors.grey.shade200,
            width: 12, // Adjust width as needed
            borderRadius: BorderRadius.circular(5),
          )
        ],
      );
    }

    return BarChartGroupData(
      x: x,
      barRods: barRods,
      groupVertically: true,
    );
  }

  static List<BarChartGroupData> getChartGroups(
      //dynamic - Routine
      List<dynamic> weeklyRoutines, DateTime currentDate) {
    //dynmaic - TaskCategory
    Map<dynamic, int> totalCategoryDurations = ProductivityModel.calculateTotalCategoryDuration(weeklyRoutines.take(1).toList());
    double totalRoutineDuration = totalCategoryDurations.values.fold(0, (sum, duration) => sum + duration);

    return List.generate(7, (index) { // Assuming we want 7 bars for 7 days of the week
      DateTime routineDate = currentDate.subtract(Duration(days: currentDate.weekday - index - 1));
      bool isPastOrCurrentDay = routineDate.isBefore(DateTime(currentDate.year, currentDate.month, currentDate.day + 1));
      bool hasData = isPastOrCurrentDay && weeklyRoutines[index].tasks.isNotEmpty;
      return generateGroupData(index, weeklyRoutines[index], hasData, totalCategoryDurations,totalRoutineDuration);
    });
  }

  Widget buildChart(List<BarChartGroupData> barGroups) {
    // This function builds the actual chart widget using the BarChartGroupData
    return BarChart(BarChartData(
      barGroups: barGroups,
      alignment: BarChartAlignment.spaceBetween,
      titlesData: FlTitlesData(
        leftTitles: const AxisTitles(),
        rightTitles: const AxisTitles(),
        topTitles: const AxisTitles(),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: bottomTitles,
            reservedSize: 40,
          ),
        ),
      ),
      barTouchData: BarTouchData(enabled: false),
      borderData: FlBorderData(show: false),
      gridData: const FlGridData(show: false),
      maxY: 16, // Assuming 24 hours in a day
    ));
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 16);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'M';
        break;
      case 1:
        text = 'T';
        break;
      case 2:
        text = 'W';
        break;
      case 3:
        text = 'T';
        break;
      case 4:
        text = 'F';
        break;
      case 5:
        text = 'S';
        break;
      case 6:
        text = 'S';
        break;
      default:
        text = '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      //dynamic -routine
      child: FutureBuilder<List<dynamic>>(
        future: futureWeeklyRoutines,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            // Get bar groups for the chart from the fetched data
            DateTime currentDate = DateTime.now(); // Use the current date
            List<BarChartGroupData> barGroups = getChartGroups(snapshot.data!, currentDate);
            return buildChart(barGroups);
          } else {
            return Text('No data available');
          }
        },
      ),
    );
  }
}