import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:prodox/features/auth/controller/login/login_controller.dart';
import 'package:prodox/utils/constants/sizes.dart';
import 'package:prodox/utils/constants/text_strings.dart';

import '../../../../../utils/constants/image_strings.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => controller.signInWithGoogle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              PImages.google,
              height: 20,
            ),
            const SizedBox(width: PSizes.spaceBtwItems),
            const Text(PTexts.signInGoogle),
          ],
        ),
      ),
    );
  }
}
