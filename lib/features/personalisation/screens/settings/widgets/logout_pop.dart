import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prodox/features/personalisation/controller/profile_controller.dart';
import 'package:prodox/utils/constants/sizes.dart';

class LogoutPop extends StatelessWidget {
  const LogoutPop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Padding(
      padding: const EdgeInsets.all(PSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Log Out',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: PSizes.spaceBtwItems),
          Text(
            'Are you sure you want to log out?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: PSizes.spaceBtwSections),
          ElevatedButton(
            onPressed: () => controller.logoutUser(),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  vertical: PSizes.md,
                ),
              ),
            ),
            child: const Text('Log Out'),
          ),
          const SizedBox(height: PSizes.spaceBtwItems),
          OutlinedButton(
            onPressed: () {
              Get.back();
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  vertical: PSizes.md,
                ),
              ),
            ),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
