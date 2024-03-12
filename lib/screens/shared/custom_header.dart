import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prodox/utils/constants/colors.dart';
import 'package:prodox/utils/constants/sizes.dart';
import 'package:provider/provider.dart';
import 'package:prodox/screens/Profile/Account%20Screen/account_screen.dart';
import 'package:prodox/screens/shared/titles.dart';
import '../../provider/Extras/user_data_provider.dart';


class CustomHeader extends StatelessWidget {
  const CustomHeader({Key? key, required this.title, this.custom}) : super(key: key);

  final String title;
  final Widget? custom;

  get onPressed => null;

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: PSizes.defaultSpace),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const AccountScreen();
                }));
              },
              child: custom?? CircleAvatar(
                radius: 18,
                backgroundColor: kPrimaryColor,
                backgroundImage: AssetImage(
                  "assets/illustrations/male.png",
                ),
              ) ,
            ),
            IconButton(
              onPressed: onPressed,
              icon: SvgPicture.asset(
                "assets/icons/bell.svg",
                color : Theme.of(context).textTheme.labelLarge?.color,
              ),)
          ],
        ),
      ),
    );
  }
}