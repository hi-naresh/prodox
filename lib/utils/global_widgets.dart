import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prodox/utils/ui_colors.dart';

import 'global_styles.dart';

void showGlobalSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 4.0,
    margin: const EdgeInsets.only(bottom: 90.0, left: 20.0, right: 20.0),
  );

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Column myField(
    BuildContext context,
    String label,
    TextEditingController controller,
    bool obscure, {
      String? subLabel,
      String? Function(String?)? validator,
      bool isNumber = false,
    }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'SF-Pro-Display',
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColor,
        ),
      ),
      Text(
        subLabel ?? '',
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'SF-Pro-Display',
          fontWeight: FontWeight.w300,
          color: Theme.of(context).primaryColor,
        ),
      ),

      const SizedBox(height: 10),
      Container(
        width: double.infinity,
        height: 50,
        decoration: Styles.border(context,
            colorbg: kPrimaryColor.withOpacity(0.15),
            borderColor: Colors.transparent,
            borderRadius: 10),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          obscureText: obscure,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
          ),
          validator: validator,
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}

Column ValidateField(
    BuildContext context,
    String label,
    TextEditingController controller,
    bool obscure, {
      String? truePhrase,
      String? regexPattern,
      String? falsePhrase,
      bool isNumber = false,
    }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'SF-Pro-Display',
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColor,
        ),
      ),
      const SizedBox(height: 10),
      Container(
        width: 360,
        height: 50,
        decoration: Styles.border(context,
            colorbg: Colors.grey.withOpacity(0.25),
            borderColor: Colors.transparent,
            borderRadius: 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller,
              obscureText: obscure,
              keyboardType:
              isNumber ? TextInputType.number : TextInputType.text,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return truePhrase;
                } else if (regexPattern != null &&
                    !RegExp(regexPattern!).hasMatch(value)) {
                  return falsePhrase;
                } else {
                  return null;
                }
              },
            ),
            if (truePhrase != null)
              Align(
                alignment: Alignment.center,
                child: Text(
                  truePhrase,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}


ButtonStyle appButtonStyle(BuildContext context) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(kPrimaryColor),
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    ),
    textStyle: MaterialStateProperty.all(
      // customTitle(kBoxLight, 16),
      TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}

Container appButton(
    BuildContext context,
    BoxDecoration styleButton,
    String title,
    String route, {
      String? iconPath,
    }) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.88,
    height: MediaQuery.of(context).size.height * 0.065,
    decoration: styleButton,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(20),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconPath != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    iconPath,
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Container appButtonFunc(
    BuildContext context,
    BoxDecoration styleButton,
    String title,
    Function() onPressed, {
      String? iconPath,
      EdgeInsets? margin,
      bool isEnabled = true, // default value is true, so it won't affect other parts of the app
      Color? disabledColor,
    }) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.88,
    height: MediaQuery.of(context).size.height * 0.065,
    decoration: isEnabled ? styleButton : styleButton.copyWith(color: disabledColor ?? Colors.grey),
    margin: margin,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onPressed : null, // if the button is not enabled, onTap will be null
        borderRadius: BorderRadius.circular(20),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconPath != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    iconPath,
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
