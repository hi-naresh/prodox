import 'package:flutter/material.dart';
import 'package:prodox/features/auth/screens/login/widgets/social_button.dart';
import 'package:prodox/features/auth/screens/login/widgets/login_form.dart';
import 'package:prodox/features/auth/screens/login/widgets/p_login_header.dart';
import 'package:prodox/features/auth/screens/login/widgets/pdividier.dart';
import 'package:prodox/utils/constants/sizes.dart';
import 'package:prodox/utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(PSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PLoginHeader(),
              SizedBox(height: PSizes.defaultSpace),
              //form
              PLoginForm(),
              //divider
              SizedBox(height: PSizes.defaultSpace),
              PDivider( text: PTexts.orSignInWith,),
              SizedBox(height: PSizes.defaultSpace),
              SocialButton(),
              //login buttons
            ],
          ),
        ),
      ),
    );
  }
}
