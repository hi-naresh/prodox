import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../constants/sizes.dart';

class Helper {
  Helper._();
  static void showSnackBar(String title, String message) {
    Get.snackbar(
      title, message,
      barBlur: 20,
      isDismissible: true,
      borderRadius: PSizes.borderRadiusXl,
      margin: const EdgeInsets.symmetric(horizontal:  PSizes.defaultSpace/1.3),
    );
  }

}