import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prodox/features/personalisation/controller/user_controller.dart';
import '../../../../features/routine/screens/dashboard/widgets/large_button.dart';
import '../../../../features/routine/screens/dashboard/widgets/routine_timeline.dart';
import '../../../../features/routine/screens/dashboard/widgets/weekly_chart.dart';

import '../../../../common/styles/styles.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../routes.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void initState() {
    // calculateDailyProductivity();
  }

  static double overAllProductivity = 0;
  //calculate daily productivity
  void pushNotification() {
    // Implement push notification here
  }

  Future<void> cancelScheduledNotifications() async {
    //cancel all scheduled notifications
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(
            horizontal: PSizes.defaultSpace, vertical: PSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Obx(
              () => Text(
                'Welcome, ${controller.user.value.fullName?.split(' ')[0].capitalizeFirst}!👋',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
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
            // const SizedBox(
            //   height: 200,
            //   width: double.infinity,
            //   child: RoutineTimeline(),
            // ),
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
                  onPressed: () {
                    // calculateDailyProductivity();
                  },
                  child: Text(
                    '$overAllProductivity%',
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
            // Container(
            //   height: 250,
            //   width: double.infinity,
            //   decoration: PStyles.lightToDark(PColors.primary),
            //   child: WeeklyChart(),
            // ),
            const SizedBox(height: PSizes.defaultSpace * 3),
          ],
        ),
      ),
    );
  }
}
