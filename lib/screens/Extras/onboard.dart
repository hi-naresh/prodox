import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prodox/utils/constants/colors.dart';
import 'package:prodox/utils/constants/sizes.dart';
import 'package:get/get.dart';

import '../../common/styles/styles.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/p_routes.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Lottie.asset(
            'assets/animations/onboard.json',
            width: double.infinity,
            fit: BoxFit.cover,
            frameRate: FrameRate.max,
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(40),
            width: double.infinity,
            // color: PColors.accent3Light,
            // decoration: PStyles.darkToLight(PColors.accent3Light),
            child: Column(
              children: [
                Text(
                  PTexts.onBoardingTitle,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                  ),
                const SizedBox(height:PSizes.spaceBtwItems),
                Text(
                  PTexts.onBoardingSubtitle,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height:PSizes.defaultSpace*4),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(PRoutes.getRegisterRoute());
                  },
                  child: Lottie.asset(
                    'assets/animations/button.json',
                    width: 160,
                    frameRate: FrameRate.max,
                    // animate: false,
                    fit: BoxFit.cover,
                    // width: 300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
