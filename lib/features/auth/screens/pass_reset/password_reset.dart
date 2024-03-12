import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prodox/features/auth/controller/pass_reset/pass_reset_controller.dart';
import 'package:prodox/utils/constants/sizes.dart';

import '../../../../utils/constants/text_strings.dart';

class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PasswordResetController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(PSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                PTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: PSizes.spaceBtwItems),
              const Text(PTexts.forgetPasswordSubTitle),
              const SizedBox(height: PSizes.spaceBtwItems),
              Form(
                key: controller.passwordResetFormKey,
                child: TextFormField(
                  controller: controller.email,
                  decoration: const InputDecoration(
                    labelText: PTexts.email,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => controller.resetPassword(),
                child: const Text(PTexts.submit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
