import 'package:flutter/material.dart';
import 'package:prodox/utils/constants/colors.dart';
import 'package:prodox/utils/constants/sizes.dart';

class PDivider extends StatelessWidget {
  final String text;
  const PDivider({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Divider(
            color: PColors.borderPrimary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: PSizes.defaultSpace),
          child: Text(text),
        ),
        const Expanded(
          child: Divider(
            color: PColors.borderPrimary,
          ),
        ),
      ],
    );
  }
}
