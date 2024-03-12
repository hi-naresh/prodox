import 'package:flutter/material.dart';
import 'package:prodox/utils/constants/sizes.dart';
import 'package:prodox/utils/constants/text_strings.dart';
import 'package:get/get.dart';
import 'package:prodox/utils/validators/validation.dart';

import '../../../../../routes.dart';
import '../../../controller/login/login_controller.dart';
class PLoginForm extends StatelessWidget {
  const PLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.email,
            validator: (value)=> PValidator.validateEmpty(value, controller.email.text),
            decoration: const InputDecoration(
              labelText: PTexts.username,
              hintText: PTexts.usernameHint,
            ),
          ),
          const SizedBox(height: PSizes.spaceBtwInputFields),
          Obx(
            ()=> TextFormField(
              controller: controller.password,
              validator: (value)=> PValidator.validateEmpty(value, controller.password.text),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: PTexts.password,
                hintText: PTexts.passwordHint,
                suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                    icon: Icon(Icons.remove_red_eye_outlined))
              ),

            ),
          ),
          const SizedBox(height: PSizes.spaceBtwInputFields),
          //remmeber me and forgot password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                () =>Checkbox(value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value),
                  ),
                  const Text(PTexts.rememberMe),
                ],
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed(PRoutes.getPasswordResetRoute());
                },
                child: Text(PTexts.forgetPassword),
              ),
            ],
          ),
          const SizedBox(height: PSizes.spaceBtwInputFields),
          //signIn and create account button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.emailLogin(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(PSizes.md),
              ),
              child: Text(PTexts.signIn),
            ),
          ),
          const SizedBox(height: PSizes.defaultSpace),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Get.toNamed(PRoutes.getSignupRoute());
              },
              child: Text(PTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
