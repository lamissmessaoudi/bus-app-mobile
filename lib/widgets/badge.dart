import 'package:flutter/material.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';

class CustomBadge extends StatelessWidget {
  final bool isSelected;
  final String text;

  const CustomBadge({
    Key? key,
    this.isSelected = true,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.white : AppColors.inactiveGrayBg,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.blue : AppColors.inactiveGrayBg,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            text,
            style: isSelected
                ? AppTextStyles.activeMontserrat14
                : AppTextStyles.inactiveMontserrat14,
          ),
        ),
      ),
    );
  }
}

class BadgeTab extends StatelessWidget {
  final String number;
  final String title;
  final bool isSelected;

  const BadgeTab({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomBadge(
            isSelected: true,
            text: number,
          ),
          Text(
            title,
            style: AppTextStyles.activeMontserrat14,
          ),
        ],
      ),
    );
  }
}
