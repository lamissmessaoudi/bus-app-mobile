import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final TextEditingController? controller;
  final Color focusColor;
  final Color borderColor;
  final Color errorColor;
  final TextInputType inputType;
  final bool obscureText;
  final bool enabled;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Function? onChanged;
  final int? minLines;

  CustomTextField(
      {this.hint = "",
      this.controller,
      this.onChanged,
      required this.focusColor,
      required this.borderColor,
      required this.errorColor,
      this.inputType = TextInputType.text,
      this.obscureText = false,
      this.enabled = true,
      this.prefix = null,
      this.suffixIcon = null,
      this.validator,
      this.minLines});

  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Color currentColor = AppColors.tabColor;

  @override
  void initState() {
    super.initState();
    currentColor = widget.borderColor;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyles.hintPTMono18,
      validator: widget.validator,
      controller: widget.controller,
      cursorColor: widget.focusColor,
      obscureText: widget.obscureText,
      keyboardType: widget.inputType,
      enabled: widget.enabled,
      minLines: widget.minLines,
      maxLines: widget.minLines,
      decoration: InputDecoration(
        hintText: widget.hint,
        focusColor: AppColors.accentColor,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.focusColor,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.errorColor,
            width: 2.0,
          ),
        ),
        hintStyle:
            AppTextStyles.hintPTMono18.copyWith(color: AppColors.inactiveText),
        prefix: widget.prefix,
        suffixIcon: widget.suffixIcon,
      ),
    );
  }
}
