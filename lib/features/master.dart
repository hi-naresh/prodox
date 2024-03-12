import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:prodox/features/routine/screens/analysis/analysis_screen.dart';
import 'package:prodox/features/routine/screens/dashboard/dashboard_screen.dart';
import 'package:prodox/utils/helpers/helper_functions.dart';

import '../../common/styles/styles.dart';
import '../../common/widgets/navbar/curved_navbar.dart';
import '../../utils/constants/colors.dart';

import '../common/widgets/appbar/appbar.dart';
import '../features/routine/screens/dailytask/daily_tasks.dart';
import '../utils/constants/image_strings.dart';

class MasterScreen extends StatelessWidget {
  const MasterScreen({super.key});
  Widget _buildFAB(BuildContext context) {
    return Container(
      decoration: PStyles.darkToLight(PColors.accent3),
      child: IconButton(
        icon: const Icon(
          Icons.add_rounded,
          size: 40,
          color: Colors.white
        ),
        onPressed: () {
          PHelper.showBottomSheet( DailyTaskScreen());
        },
      ),
    );
  }
  Widget bottomNavBar( MasterController controller) {
    return Obx(
          ()=> CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 500),
        index: controller.currentIndex.value,
        onTap: (index)=> controller.currentIndex.value = index,
        buttonBackgroundGradient: PColors.accent1Gradient,
        items:  [
          SvgPicture.asset(
            PImages.home,
            color: PColors.primaryWhite,
            height: 28, width: 28,),
          SvgPicture.asset(
            PImages.analysis,
            color: PColors.primaryWhite,
            height: 28, width: 28,),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MasterController());
    return Scaffold(
      appBar: const PAppBar(),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFAB(context),
      extendBody: true,
      body: Obx(()=> controller._screens[controller.currentIndex.value]),
      bottomNavigationBar: bottomNavBar( controller),
    );
  }

}

class MasterController extends GetxController {
  static MasterController get instance => Get.find();
  final RxInt currentIndex = 0.obs;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const AnalysisScreen()
  ];

}

