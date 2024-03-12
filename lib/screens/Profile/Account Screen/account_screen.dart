import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../utils/ui_colors.dart';

import '../../../utils/global_styles.dart';
import '../../../utils/global_widgets.dart';
import '../../Extras/on_board.dart';
import '../../shared/custom_header.dart';
import 'about_screen.dart';

// ignore: must_be_immutable
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with AutomaticKeepAliveClientMixin {

  void showLogoutConfirmationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height *
                  0.5, // Set desired height here
            ),
            child: Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Divider(
                    thickness: 6.0,
                    indent: 130.0,
                    endIndent: 130.0,
                  ),
                  const SizedBox(height: 30.0),
                  const Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'SF-Pro-Display',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Are you sure you want to log out?',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'SF-Pro-Display',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  appButtonFunc(
                    context,
                    Styles.gradient(context),
                    'Logout',
                        () async {
                      // Perform the logout action
                      FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.signOut();

                      // Close all screens and go back to the login screen
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                              const OnBoardingScreen()),
                              (route) => false
                      );
                    },
                  ),
                  appButtonFunc(
                    margin: const EdgeInsets.only(top: 20.0),
                    context,
                    Styles.border(context),
                    'Cancel',
                        () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomHeader(
                title: "Settings",
                  custom: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: kPrimaryColor, shape: BoxShape.circle),
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              )),
              // const AccountWidget(),

              // SwitchContainer(
              //   leadingIcon: Icons.dark_mode_outlined,
              //   title: "Dark Mode",
              //   description: "Switch between dark and light mode",
              //   switchWidget: const ThemeSwitch(),
              //   backgroundColor: Theme.of(context).chipTheme.backgroundColor,
              // ),
              // SwitchContainer(
              //   leadingIcon: Icons.fingerprint,
              //   title: "Biometric Login",
              //   description: "Login with your face/fingerprint",
              //   switchWidget: const BiometricSwitch(),
              //   backgroundColor: Theme.of(context).chipTheme.backgroundColor,
              // ),
              // ReminderNotificationWidget(),
              // SwitchContainer(
              //   leadingIcon: Icons.notifications_active_outlined,
              //   title: "Notifications",
              //   description: "Do you need daily Notifications?",
              //   switchWidget: const NotificationSwitch(),
              //   backgroundColor: Theme.of(context).chipTheme.backgroundColor,
              // ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const AboutScreen();
                  }));
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).chipTheme.backgroundColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "About Prodo",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "AppInfo.version",
                              maxLines: 1,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 25,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showLogoutConfirmationBottomSheet(context);
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).chipTheme.backgroundColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.logout,
                            size: 25,
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Logout from your account",
                              maxLines: 1,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // child: Consumer<AppStateProvider>(
          //   builder: (BuildContext context, value, Widget? child) {

          //   },
          // ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
