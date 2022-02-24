import 'package:flutter/material.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double? width;
  final BtnType btnType;

  const CustomButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.width = 230,
      this.btnType = BtnType.PrimaryOutline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: btnType == BtnType.AccentOutlined
            ? Border.all(
                color: AppColors.accentColor, //
                // width: 5.0,
              )
            : null,
      ),
      child: InkWell(
        splashColor: AppColors.accentColor,
        onTap: btnType == BtnType.Inactive ? null : onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: btnType == BtnType.AccentFilled
                ? AppColors.accentColor
                : btnType == BtnType.AccentOutlined
                    ? AppColors.white
                    : btnType == BtnType.Inactive
                        ? AppColors.inactiveGrayBg
                        : AppColors.tabColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10.0),
          child: Text(
            text,
            style: AppTextStyles.primarySlab24.copyWith(
              color: btnType == BtnType.AccentFilled
                  ? AppColors.white
                  : btnType == BtnType.AccentOutlined
                      ? AppColors.accentColor
                      : btnType == BtnType.Inactive
                          ? AppColors.inactiveText
                          : AppColors.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
