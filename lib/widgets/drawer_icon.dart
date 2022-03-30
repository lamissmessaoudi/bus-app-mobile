import 'package:flutter/material.dart';
import 'package:softun_bus_mobile/style/colors.dart';

class DrawerIcon extends StatelessWidget {
  const DrawerIcon({
    Key? key,
    required this.scaffoldState,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldState;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      top: 30,
      child: GestureDetector(
          child: Icon(
            Icons.menu,
            color: AppColors.primaryColor,
            size: 25,
          ),
          onTap: () => scaffoldState.currentState?.openDrawer()),
    );
  }
}
