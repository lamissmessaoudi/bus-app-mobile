import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/profile/profile_controller.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/colors.dart';

class CustomDialog extends StatelessWidget {
  @override
  final Widget child;
  CustomDialog({required this.child});
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        initState: (_) {},
        builder: (controller) {
          return Container(
            // Don't Add Padding here
            margin: EdgeInsets.only(left: 0.0, right: 0.0),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(
                    18.0,
                  ),
                  margin: EdgeInsets.symmetric(vertical: 25.0, horizontal: 20),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 0.0,
                          offset: Offset(0.0, 0.0),
                        ),
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [child],
                  ),
                ),
                Positioned(
                  right: 0.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 24.0,
                        backgroundColor: AppColors.errorColor,
                        child: Image.asset(Assets.closeX),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
