import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:prodox/screens/Register/login_screen.dart';
import 'package:prodox/screens/Register/signup_screen.dart';
import 'package:prodox/utils/constants/colors.dart';

import '../../common/styles/styles.dart';
import '../../utils/constants/sizes.dart';
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  get onPressed => null;
  late TabController _tabController;

  final _selectedColor = PColors.accent3;
  // final _unselectedColor = Color(0xff5f6368);
  final _tabs = const [
    Tab(text: 'Login'),
    Tab(text: 'Sign Up'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Adjust the length for the number of tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    // _resetSavedData();
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                dividerHeight: 0,
                indicator: PStyles.darkToLight(_selectedColor),
                labelColor: Colors.white,
                isScrollable: true,
                padding: EdgeInsets.symmetric(horizontal: PSizes.sm, vertical: PSizes.lg),
                tabAlignment: TabAlignment.center,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                labelPadding: EdgeInsets.symmetric(horizontal: PSizes.xl, vertical: PSizes.xs),
                indicatorPadding: const EdgeInsets.symmetric(horizontal: -35,vertical: 5),
                tabs: _tabs,
              ),
              const SizedBox(height:PSizes.defaultSpace),
              Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children:  const [
                      LoginScreen(),
                      SignUpScreen(),
                    ],
                  )
              )
            ],
          ),
        )
    );
  }
}

