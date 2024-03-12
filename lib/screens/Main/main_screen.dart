import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prodox/common/widgets/appbar/appbar.dart';
import 'package:prodox/screens/analysis/analysis_screen.dart';
import 'package:prodox/utils/constants/image_strings.dart';
import 'package:provider/provider.dart';
import 'package:prodox/screens/tasks/daily_tasks.dart';

import '../../common/styles/styles.dart';
import '../../common/widgets/navbar/curved_navbar.dart';
import '../../utils/constants/colors.dart';
import '../../provider/App_State/app_state_provider.dart';
import '../../utils/constants/sizes.dart';
import '../Home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with AutomaticKeepAliveClientMixin {
  final List<Widget> _screens = [
    HomeScreen(),
    const AnalysisScreen()
  ];


  void bottomSheet(BuildContext context,Widget child) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(PSizes.borderRadiusXl),
        ),
      ),
      builder: (BuildContext context) {
        return child;
      },
    );
  }

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
          bottomSheet(context, DailyTaskScreen());
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // Provider.of<AppStateProvider>(context, listen: false)
    //     .pageController
    //     .dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<AppStateProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          appBar: const PAppBar(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _buildFAB(context),
          extendBody: true,
          body: _screens[value.pageState],
          bottomNavigationBar: bottomNavBar(context, value),
        );
      },
    );
  }

  Widget bottomNavBar(BuildContext context, value) {
    return CurvedNavigationBar(
      animationDuration: const Duration(milliseconds: 500),
      index: value.pageState,
      onTap: (int index) {
        value.updatePage(index);
      },
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
    );
  }

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  bool get wantKeepAlive => true;
}
