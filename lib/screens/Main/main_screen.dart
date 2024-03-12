import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prodox/screens/Main/widgets/Bottom%20Nav%20Bar/navbar.dart';
import 'package:prodox/screens/Main/widgets/Bottom%20Nav%20Bar/navbar_widget.dart';
import 'package:prodox/screens/tasks/daily_tasks.dart';

import '../../model/routine_model.dart';
import '../../services/data_fetch.dart';
import '../../services/notify_service.dart';
import '../../utils/ui_colors.dart';
import '../../provider/App_State/app_state_provider.dart';
import '../../utils/global_styles.dart';
import '../Home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
     HomeScreen(),
     HomeScreen(),
     HomeScreen(),
     HomeScreen(),

    // const ArticleScreen(),
    // const AnalysisScreen(),
    // const LearnScreen(),
    // MySpaceScreen(),
  ];


  @override
  void initState() {
    super.initState();
  }

  // Widget _buildFAB(BuildContext context) {
  //   return SizedBox(
  //     width: 50.h,
  //     height: 50.h,
  //     child: RawMaterialButton(
  //       fillColor: kApp4,
  //       shape: const CircleBorder(),
  //       elevation: 0.0,
  //       onPressed: () {
  //         Navigator.of(context)
  //             .push(MaterialPageRoute(builder: (BuildContext context) {
  //           return const AddJournalPageWidget();
  //         }));
  //       },
  //       child: Icon(
  //         Icons.add,
  //         size: 40.sp,
  //         color: kBackground1,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildFAB(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Container(
        decoration: Styles.containerDecoration(kPrimaryColor),
        child: IconButton(
          // icon: SvgPicture.asset(
          //   "assets/icons/add.svg",
          //   color: kBackground1,
          //   height: 20.h,
          //   width: 20.h,
          // ),
          icon: Icon(
            Icons.add,
            size: 40,
            color: Colors.white
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return DailyTaskScreen();
            }));
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<AppStateProvider>(context, listen: false)
        .pageController
        .dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton:
              value.pageState == 0 ? _buildFAB(context) : null,
          extendBody: true,
          body: _screens[value.pageState],
          bottomNavigationBar: NavBar(
            height: 70,
            items: [
              NavBarWidget(
                icon :"assets/icons/home.svg",
                iconSize: 30,
                selectedIconColor: kPrimaryColor,
                title: 'Home',
              ),
              NavBarWidget(
                icon : "assets/icons/analysis.svg",
                iconSize: 30,
                selectedIconColor: kPrimaryColor,
                title: 'Insights',
              ),
              NavBarWidget(
                icon : "assets/icons/learn.svg",
                iconSize: 30,
                selectedIconColor: kPrimaryColor,
                title: 'Learn',
              ),
              NavBarWidget(
                icon : "assets/icons/myspace.svg",
                iconSize: 30,
                selectedIconColor: kPrimaryColor,
                title: 'Space',
              ),
            ],
            currentIndex: value.pageState,
            onChanged: (int index) {
              value.updatePage(index);
            },
          ),
        );
      },
    );
  }
}

