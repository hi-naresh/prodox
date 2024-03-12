import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:prodox/utils/constants/colors.dart';
import 'package:prodox/utils/device/device_utility.dart';
import 'package:provider/provider.dart';

import '../../../provider/App_State/app_state_provider.dart';
import '../../../screens/Extras/notification_screen.dart';
import '../../../screens/Profile/Account Screen/account_screen.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/p_routes.dart';


class PAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PAppBar({super.key, this.back= false});

  final bool? back;

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }



  @override
  Widget build(BuildContext context) {
    void switchTheme() {
      if (Provider.of<AppStateProvider>(context, listen: false).isDarkMode) {
        Provider.of<AppStateProvider>(context, listen: false).updateTheme(false);
      } else {
        Provider.of<AppStateProvider>(context, listen: false).updateTheme(true);
      }
    }
    return AppBar(
      // title: Text(PTexts.appName),
      // centerTitle: true,
      // flexibleSpace: const CustomHeader( title: PTexts.appName,),
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: GestureDetector(
          onTap: () {
            if (back == true) {
              Get.back();
            } else {
              Get.toNamed(PRoutes.getSettingsRoute());
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              back! ?"assets/icons/close.svg" : "assets/illustrations/male.svg",
              height: PSizes.iconSm,
              width: PSizes.iconSm,
              fit: BoxFit.contain,
              clipBehavior: Clip.none,
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: PSizes.spaceBtwItems),
          child: Row(
            children: [
              IconButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NotificationsScreen())
                  );
                },
                icon: SvgPicture.asset(
                  "assets/icons/bell.svg",
                  height: PSizes.iconXl,
                  color : Theme.of(context).textTheme.labelLarge?.color,
                ),),
              //dark mode button to switch mode
              IconButton(
                  onPressed: switchTheme,
                  icon: Icon(
                    isDarkMode(context)
                        ? Icons.light_mode_outlined
                        : Icons.dark_mode_outlined,
                    size: PSizes.iconXl,
                  )
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
