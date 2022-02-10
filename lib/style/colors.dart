import 'package:flutter/material.dart';

class AppColors {
  static Color white = HexColor("#FFFFFF");
  static Color primaryColor = HexColor("13404D"); //Dark blue
  static Color secondaryColor = HexColor("323941"); //dark grey
  static Color accentColor = HexColor("FF9728"); //Orange
  static Color saumonColor = HexColor("FFCC96"); //Saumon
  static Color tabColor = HexColor("F1F5F8"); //Saumon
  static Color errorColor = HexColor("e04f5f");
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
