import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../common/styles/styles.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';


class LargeButton extends StatelessWidget {
  const LargeButton({
    super.key,
    this.height ,
    this.width ,
    this.onTap,
    this.color,
    required this.text,
    required this.imagePath,
  });

  final double? height;
  final double? width;
  final Function()? onTap;
  final Color? color;
  final String imagePath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: PStyles.lightToDark(color??PColors.accent1),
        padding: const EdgeInsets.all(PSizes.defaultSpace/1.4),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: -PSizes.defaultSpace/2,
              child: SvgPicture.asset(
                imagePath,
                height: height!,
              ),
            ),
            Text(text,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: PColors.primaryWhite,
                ),
            ),
          ],
        ),
      ),
    );
  }
}