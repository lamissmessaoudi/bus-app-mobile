import 'package:flutter/material.dart';

class AppColors {
  static Color white = HexColor("#FFFFFF");
  static Color primaryColor = HexColor("13404D"); //Dark blue
  static Color secondaryColor = HexColor("323941"); //dark grey
  static Color accentColor = HexColor("FF9728"); //Orange
  static Color saumonColor = HexColor("FFCC96"); //Saumon
  static Color tabColor = HexColor("F1F5F8"); //btn + navbar bg
  static Color errorColor = HexColor("e04f5f"); //red
  static Color hintColor = HexColor("323941"); //very dark grey
  static Color borderColor = HexColor("D5D8DE"); // textfield border
  static Color green = HexColor("139652"); //successb green
  static Color blue = HexColor("49a8df"); // Badge Border
  static Color yellow = HexColor("FFD600");
  static Color inactiveGrayBg = HexColor("dadada"); //Inactive Badge
  static Color inactiveText = HexColor("7A7A7A"); //Inactive Badge Tzxt
  static Color headerGray = HexColor("F4F4F4"); //activation header
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
