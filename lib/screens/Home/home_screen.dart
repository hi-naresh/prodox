import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prodox/utils/helpers/helper.dart';
import '../../common/styles/styles.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/p_routes.dart';
import '../Home/widgets/routine_timeline.dart';
import 'package:prodox/screens/Home/widgets/weekly_chart.dart';
import 'package:prodox/utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';

import '../../common/widgets/large_button.dart';
import '../../model/routine_model.dart';
import '../../services/ProductivityModel.dart';
import '../../services/data_fetch.dart';
import '../../services/category_model.dart';
import '../../services/notify_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void initState() {
    calculateDailyProductivity();
  }

  static double overAllProductivity =0;

  void calculateDailyProductivity() {
    fetchTasks().then((value) {
      List<TaskModel> tasks = value;

      List<Task> calTasks = tasks
          .map((task) {
            TaskCategory? category = Task.getCategoryForTask(task.tag);
            if (category != null) {
              return Task(
                name: task.name,
                duration: task.endTime.difference(task.startTime),
                category: category,
              );
            }
            return null;
          })
          .whereType<Task>()
          .toList(); // Filter out nulls if any task couldn't be categorized

      Routine routine = Routine(tasks: calTasks);

      ProductivityModel productivityModel = ProductivityModel(routine: routine);
      double dailyProductivity = productivityModel.calculateDailyProductivity();
      double overallProductivity =
          productivityModel.calculateOverallProductivity();

      overAllProductivity = overallProductivity.toPrecision(1);

      Helper.showSnackBar("Re-Calculated Productivity",
          "Your daily productivity is ${dailyProductivity.toStringAsFixed(2)} hours"
              "\n Your Overall productivity is $overAllProductivity %" );
    }).catchError((error) {
      Helper.showSnackBar("Error", "Error calculating productivity: $error");
    });
  }

  void pushNotification() {
    // Implement push notification here
    fetchTasks().then((tasks) {
      for (TaskModel task in tasks) {
        scheduleTaskNotification(task);
      }
    });
    Helper.showSnackBar('Routine Started','All scheduled notifications have been set');
  }

  Future<void> cancelScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
    Helper.showSnackBar('Routine Stopped','All scheduled notifications have been cancelled');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal:  PSizes.defaultSpace, vertical: PSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome, ${fetchUsername().capitalizeFirst}!👋',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: PSizes.defaultSpace),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              child: Row(
                children: [
                  LargeButton(
                    height: PSizes.defaultSpace * 5,
                    width: PSizes.defaultSpace * 9,
                    text: PTexts.setRoutine,
                    color: PColors.accent3,
                    imagePath: PImages.setRoutine,
                    onTap: () {
                      Get.toNamed(PRoutes.getSetRoutineRoute());
                    },
                  ),
                  const SizedBox(
                    width: PSizes.defaultSpace,
                  ),
                  LargeButton(
                    height: PSizes.defaultSpace * 5,
                    width: PSizes.defaultSpace * 9,
                    text: PTexts.analyzeMode,
                    imagePath: PImages.setAnalyze,
                    // color: PColors.accent3,
                    onTap: () {
                      Get.toNamed(PRoutes.getAnalyzeRoutineRoute());
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: PSizes.defaultSpace),
            Row(children: [
              Text(
                PTexts.yourRoutine,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    pushNotification();
                  },
                  child: const Text(PTexts.follow)),
              const SizedBox(width: PSizes.sm),
              ElevatedButton(
                  onPressed: () {
                    cancelScheduledNotifications();
                  },
                  // style:  ButtonStyle(),
                  child: const Text(PTexts.stop))
            ]),
            // Upcoming Tasks from Firebase
             const SizedBox(
              height: 200,
              width: double.infinity,
              child: RoutineTimeline(),
            ),
            Row(children: [
              Text(
                PTexts.yourDailyTasks,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {},
                  child: Text(PTexts.viewAll,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            decoration: TextDecoration.underline,
                          )))
            ]),
            // DailyWidget(),
            const SizedBox(height: PSizes.defaultSpace),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  PTexts.weeklyAnalysis,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                TextButton(
                    onPressed: (){
                      calculateDailyProductivity();
                    },
                    child: Text('$overAllProductivity%',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        // color: PColors.accent3,
                        fontWeight: FontWeight.bold,
                        fontSize: PSizes.md,
                      ),
                    ),
                )
              ],
            ),
            const SizedBox(height: PSizes.defaultSpace),
            Container(
              height: 250,
              width: double.infinity,
              decoration: PStyles.lightToDark(PColors.primary),
              child: WeeklyChart(),
            ),
            const SizedBox(height: PSizes.defaultSpace * 3),
          ],
        ),
      ),
    );
  }

}