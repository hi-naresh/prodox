import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:prodox/utils/constants/image_strings.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controller/onboard_controller.dart';


class OnBoard extends StatelessWidget {
  const OnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardController());

    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Lottie.asset(
            PImages.onboardAnim,
            width: double.infinity,
            fit: BoxFit.cover,
            frameRate: FrameRate.max,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(PSizes.defaultSpace*2),
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
                    // Get.toNamed(PRoutes.getRegisterRoute());
                    controller.nextPage();
                  },
                  child: Lottie.asset(
                    PImages.buttonAnim,
                    width: 160,
                    frameRate: FrameRate.max,
                    fit: BoxFit.cover,
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
