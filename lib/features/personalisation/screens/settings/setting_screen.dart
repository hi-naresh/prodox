import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prodox/features/personalisation/screens/settings/widgets/logout_pop.dart';
import 'package:prodox/features/personalisation/screens/settings/widgets/settings_tile.dart';
import 'package:prodox/utils/constants/sizes.dart';
import 'package:prodox/utils/helpers/helper_functions.dart';
import 'package:prodox/routes.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../controller/user_controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: PAppBar(
        back: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //profile card
              const SizedBox(height: PSizes.spaceBtwSections),

              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                title: Text(
                  controller.user.value.fullName ?? "No user",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                subtitle: Text(controller.user.value.username ?? "No email"),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Navigate to the profile edit screen
                    Get.toNamed(PRoutes.getProfileEditRoute());
                  },
                ),
              ),

              const SizedBox(height: PSizes.spaceBtwSections),

              // ReminderNotificationWidget(),
              SettingTile(
                  title: "Bio-metric Login",
                  subtitle: "Login with your face/fingerprint",
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  icon: Icons.security_outlined),
              SettingTile(
                title: "Notifications",
                subtitle: "In order to remind your tasks.",
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Theme.of(context).primaryColor,
                ),
                icon: Icons.notifications_active_outlined,
              ),
              SettingTile(
                  title: "About",
                  subtitle: "Know more about Prodo",
                  trailing: Icon(Icons.chevron_right),
                  icon: Icons.info_outline),
              SettingTile(
                  title: "Help",
                  subtitle: "Get help from Prodo",
                  trailing: Icon(Icons.chevron_right),
                  icon: Icons.help_outline),
              SettingTile(
                  onTap: () {
                    PHelper.showBottomSheet(const LogoutPop());
                  },
                  title: "Logout",
                  subtitle: "Logout from Prodo",
                  trailing: Icon(Icons.chevron_right),
                  icon: Icons.logout),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
