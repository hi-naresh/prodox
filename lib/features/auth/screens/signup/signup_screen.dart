import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prodox/utils/validators/validation.dart';
import '../../controller/signup/signup_controller.dart';
import '/features/auth/screens/login/widgets/social_button.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';

import '../login/widgets/pdividier.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(PSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //title
              Text(PTexts.signupTitle, style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: PSizes.spaceBtwSections),
              //form
              Form(
                key : controller.signupFormKey,
                child: Column(
                  children: [
                    //name
                    TextFormField(
                      controller: controller.fullName,
                      validator: (value)=> PValidator.validateEmpty("FullName", value),
                      decoration: InputDecoration(
                        labelText: PTexts.fullname,
                      ),
                    ),
                    const SizedBox(height: PSizes.spaceBtwItems),
                    //email
                    TextFormField(
                      controller: controller.email,
                      validator: (value)=> PValidator.validateEmail(value),
                      decoration: InputDecoration(
                        labelText: PTexts.email,
                      ),
                    ),
                    const SizedBox(height: PSizes.spaceBtwItems),
                    //password
                    Obx(
                      ()=> TextFormField(
                        controller: controller.password,
                        obscureText: controller.hidePassword.value,
                        validator: (value)=> PValidator.validatePassword( value),
                        decoration: InputDecoration(
                          labelText: PTexts.password,
                          suffixIcon: IconButton(
                            onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                            icon: Icon(Icons.remove_red_eye_outlined),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: PSizes.spaceBtwItems),
                    //confirm password
                    TextFormField(
                      controller: controller.confirmPassword,
                      obscureText: true,
                      validator: (value) => PValidator.validateConfirmPass(value, controller.password.text),
                      decoration: InputDecoration(
                        labelText: PTexts.confirmPassword,
                      ),
                    ),
                    const SizedBox(height: PSizes.spaceBtwItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(()=> Checkbox(value: controller.privacyPolicy.value,
                            onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value )),
                        // const SizedBox(width: PSizes.spaceBtwItems),
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(text: "${PTexts.iAgreeTo} "),
                            TextSpan(
                              text: PTexts.privacyPolicy,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            TextSpan(text: " ${PTexts.and} "),
                            TextSpan(
                              text: PTexts.termsOfUse,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ]
                          )
                        )
                      ],
                    ),
                    const SizedBox(height: PSizes.spaceBtwItems),
                    //signup button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => controller.signup(),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(PSizes.md),
                        ),
                        child: Text(PTexts.createAccount),
                      ),
                    ),
                  ],
                ),
              ),
              //divider
              const SizedBox(height: PSizes.defaultSpace),
              const PDivider(text: PTexts.orSignUpWith,),
              const SizedBox(height: PSizes.defaultSpace),
              const SocialButton(),

            ],
          ),
        ),
      ),
    );
  }
}

