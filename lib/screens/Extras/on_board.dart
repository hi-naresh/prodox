import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prodox/screens/Home/home_screen.dart';

import '../../utils/ui_colors.dart';
import '../Register/login_screen.dart';
import '../Register/signup_screen.dart';

// ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  static TextStyle head(Color color) => TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    fontFamily: 'Poppins',
    color:color,
  );

  static TextStyle info(Color color) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
    color:color,
  );

  final Text onBoardScreen1RichText = Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: 'Welcome to\n New You ',
          style : head(Color(0xFF191D21)),
        ),
        TextSpan(
            text: '\nEmbark on a transformative journey with Know Yourself Better, unlocking the tools to illuminate the spark within.',
            style: info(Color(0xFF191D21))
        ),
      ],
    ),
    textAlign: TextAlign.center,

  );

  final Text onBoardScreen2RichText = Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: 'Set,track,Change',
          style: head(Color(0xFF2D2D2D)),
        ),
        TextSpan(
          text:   "\n\nCapture emotions, track feelings, and gain personalized insights. Empower yourself for a deeper understanding, navigating life's highs and lows.",
          style: info(Color(0xFF191D21)),
        ),
      ],
    ),
    textAlign: TextAlign.center,
  );

  final Text onBoardScreen3RichText = Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: 'Get Started!',
          style: head(Color(0xFF0086DF)),
        ),
        TextSpan(
          text: "\n\nYour path to self-discovery \nawaits, let's start this empowering journey together.",
          style: info(const Color(0xFF191D21)),
        ),
      ],
    ),
    textAlign: TextAlign.center,
  );

  Color _buildColor() {
    if (activeIndex == 0) {
      return kPrimaryColor;
    } else if (activeIndex == 1) {
      return kTodoPrimaryColor;
    }
    return kJournalPrimaryColor;
  }

  Color _buildActiveDotColor() {
    if (activeIndex == 0) {
      return kPrimaryColor;
    } else if (activeIndex == 1) {
      return kTodoPrimaryColor;
    }
    return kJournalPrimaryColor;
  }

  Future showBottomSheet(BuildContext context, {required Widget child}) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: kBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          height: 750,
          // color: Colors.white,
          child: child,
        );
      },
    );
  }

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                activeIndex = value;
              });
            },
            children: [
              _buildPage(
                  richText: onBoardScreen1RichText,
                  pngName: "tasks",
                  context: context),
              _buildPage(
                  richText: onBoardScreen2RichText,
                  pngName: "tasks",
                  context: context),
              _buildPage(
                  richText: onBoardScreen3RichText,
                  pngName: "tasks",
                  context: context),
            ],
          ),
          // Positioned(
          //   bottom: 150,
          //   child: SmoothPageIndicator(
          //     controller: _pageController,
          //     count: 3,
          //     effect: WormEffect(
          //       dotHeight: 11,
          //       dotWidth: 11,
          //       radius: 20,
          //       activeDotColor: _buildActiveDotColor(),
          //       dotColor: const Color(0xFFD0D0D0),
          //     ),
          //   ),
          // ),
          Positioned(
            bottom: 50,
            child: GestureDetector(
              onTap: () {
                if (activeIndex == 2) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return  HomeScreen();
                    // return const LoginScreen();
                  }));

                  return;
                }
                _pageController.animateToPage(activeIndex + 1,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear);
              },
              child: (activeIndex == 2) ?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  button(context, 'Sign In', () => showBottomSheet(context, child: const LoginScreen())),
                  SizedBox(width: 20,),
                  button(context, 'Sign Up', () => showBottomSheet(context, child: const SignUpScreen())),
                ],
              )
                  :
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _buildColor(),
                ),
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget button(BuildContext context, String text, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: _buildColor(),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Container _buildPage(
      {required Text richText,
        required String pngName,
        required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 350,
            width: double.infinity,
            child: SvgPicture.asset(
              "assets/illustrations/$pngName.svg",
              fit: BoxFit.contain,
            ),
          ),
          richText,
          const Spacer()
        ],
      ),
    );
  }
}
