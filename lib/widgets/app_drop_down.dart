import 'package:flutter/material.dart';
import '../common/utils/colors.dart';
import '../common/utils/styles.dart';

class AppDropDown<T> extends StatelessWidget {
  const AppDropDown({
    super.key,
    required this.items,
    this.value,
    this.onChange,
    this.icon,
    this.padding,
    this.fillColor,
    this.border,
    this.borderRadius,
  });

  final List<DropdownMenuItem<T>> items;
  final T? value;
  final Function(T? type)? onChange;
  final Widget? icon;
  final EdgeInsetsGeometry? padding;

  final Color? fillColor;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: fillColor ?? SDColors.editProfileFill,
        borderRadius: borderRadius ?? BorderRadius.circular(12.0),
        border: border,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          onChanged: onChange,
          icon: icon,
          dropdownColor: fillColor ?? SDColors.editProfileFill,
          items: items,
                                                                                                                                                                                                                                                                                                                                            style: const TextStyle(
            fontSize: 14.0,
            fontFamily: sora,
            color: SDColors.settingsTextWhite,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
