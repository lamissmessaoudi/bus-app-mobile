import 'package:flutter/material.dart';
import 'package:softun_bus_mobile/style/colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new CircularProgressIndicator(
        color: AppColors.accentColor,
      ),
    );
  }
}
