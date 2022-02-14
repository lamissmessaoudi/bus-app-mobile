import 'package:flutter/material.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';

class BtnGrey extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double width;
  const BtnGrey({
    Key? key,
    required this.text,
    required this.onTap,
    this.width = 230,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        splashColor: AppColors.accentColor,
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.tabColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10.0),
          child: Text(
            text,
            style: AppTextStyles.primarySlab24,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
