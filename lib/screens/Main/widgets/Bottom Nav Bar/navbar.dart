import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prodox/utils/constants/colors.dart';
import 'package:prodox/utils/ui_colors.dart';
import 'navbar_widget.dart';


class NavBar extends StatelessWidget {
  final List<NavBarWidget> items;
  final int currentIndex;
  final Function(int index) onChanged;
  final double height;
  const NavBar(
      {super.key,
      required this.items,
      required this.currentIndex,
      required this.onChanged,
      this.height = 80});

  // Color _buildIconColor(int index, BuildContext context) {
  //   if (index == currentIndex) {
  //     return Colors.white;
  //   }

  //   return const Color(0xFFB3B3B7);
  // }

  Color _buildIconContainerColor(int index, BuildContext context) {
    if (index == currentIndex) {
      return items[index].selectedIconColor;
    }

    return kSecondaryColor;
  }

  // Color _buildTextColor(int index, BuildContext context) {
  //   if (index == currentIndex) {
  //     return Colors.white;
  //   }

  //   return const Color(0xFFB3B3B7);
  // }

  // Widget _buildBottomNavbarWidget(int index, BuildContext context) {
  //   return I(
  //     items[index].icon,
  //     color: _buildIconContainerColor(index, context),
  //     size: items[index].iconSize,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: height,
        padding: const EdgeInsets.only(left: 10, right: 10),
        width: MediaQuery.of(context).size.width,
        // color: kBoxLight.withOpacity(0.5),
        decoration: BoxDecoration(
          //code for shadow in upper direction
          // boxShadow: [
          //   BoxShadow(
          //     color: PColors.borderPrimary,
          //     spreadRadius: 1,
          //     blurRadius: 20,
          //     offset: const Offset(10, 10), // changes position of shadow
          //   ),
          // ],
          borderRadius: BorderRadius.circular(40),
          // border: Border.all(
          //   color: Colors.white,
          //   width: 1.5,
          // ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < items.length; i++)
              GestureDetector(
                onTap: () {
                  onChanged(i);
                },
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  width: 80,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linearToEaseOut,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // _buildBottomNavbarWidget(i, context),
                      SvgPicture.asset(
                        items[i].icon,
                        color: _buildIconContainerColor(i, context),
                        height: 25,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        items[i].title,
                        style: TextStyle(
                          color: _buildIconContainerColor(i, context),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
