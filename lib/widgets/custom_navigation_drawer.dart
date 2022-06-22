import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/screens/home/home_controller.dart';
import 'package:softun_bus_mobile/screens/profile/profile_controller.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final c = Get.put(ProfileController());
  final h = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            buildDrawerHeader(c),
            SizedBox(height: 20),
            h.role == RoleType.collaborateur
                ? buildDrawerItem(
                    asset: Assets.mapEdit,
                    text: "Demandes",
                    onTap: () => navigate(0),
                    route: Routes.roles,
                  )
                : SizedBox(),
            buildDrawerItem(
              asset: Assets.addLocation,
              text: "FeedBacks",
              onTap: () => navigate(1),
              route: Routes.feedback,
            ),
            buildDrawerItem(
              asset: Assets.logout,
              text: "Logout",
              onTap: () => navigate(2),
              route: Routes.signin,
            )
          ],
        ),
      ),
    );
  }

  Widget buildDrawerHeader(ProfileController c) {
    return Container(
      child: Column(children: [
        Image.asset(Assets.user),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            "${c.fetchetedUser.name} ${c.fetchetedUser.lastname} ",
            style: AppTextStyles.primarySlab24,
            textAlign: TextAlign.center,
          ),
        ),
        // Text(c.fetchetedUser.email, style: AppTextStyles.primarySlab24),
      ]),
    );
  }

  Widget buildDrawerItem(
      {required String text,
      required String asset,
      required VoidCallback onTap,
      required String route,
      z}) {
    return Column(
      children: [
        Divider(
          color: AppColors.inactiveGrayBg,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Image.asset(asset),
            title: Text(
              text,
              style: AppTextStyles.primarySlab17.copyWith(
                  color: Get.currentRoute == route
                      ? AppColors.accentColor
                      : AppColors.primaryColor),
            ),
            onTap: onTap,
          ),
        ),
      ],
    );
  }

  navigate(int index) {
    if (index == 0) {
      h.role == RoleType.collaborateur ? Get.toNamed(Routes.request) : null;
    } else if (index == 1) {
      Get.toNamed(Routes.feedback);
    }
    if (index == 2) {
      Get.toNamed(Routes.signin);
    }
  }
}
