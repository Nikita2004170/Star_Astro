import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.cursorColor,
    this.fontSize,
    this.fontFamily,
    this.fontWeight,
    this.textColor,
    this.prefixIcon,
    this.hintText,
    this.hintColor,
    this.fillColor,
    this.inputFormatters,
    this.suffixIcon,
    this.obscureText = false,
    this.onTapOutside,
    this.border,
    this.onChanged,
    this.keyboardType,
  });

  final TextEditingController controller;
  final Color? cursorColor;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final Color? textColor;
  final Widget? prefixIcon;
  final String? hintText;
  final Color? hintColor;
  final Color? fillColor;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final bool obscureText;
  final TapRegionCallback? onTapOutside;
  final InputBorder? border;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: cursorColor,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        color: textColor,
      ),
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      keyboardType: keyboardType,
      onTapOutside: onTapOutside ??
          (event) {
            FocusScope.of(context).unfocus();
          },
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor,
          fontSize: fontSize,
          fontFamily: fontFamily,
          fontWeight: fontWeight,
        ),
        focusedBorder: border,
        enabledBorder: border,
        disabledBorder: border,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
