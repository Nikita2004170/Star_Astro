import 'package:flutter/material.dart';
import 'package:star_astro/widgets/app_text.dart';
import '../common/utils/colors.dart';
import '../common/utils/styles.dart';

class AppGradiantButton extends StatelessWidget {
  const AppGradiantButton({
    super.key,
    this.onTap,
    required this.title,
    this.icon,
    this.margin,
    this.padding,
    this.gradiantColors,
    this.fontSize,
    this.fontWeight,
    this.textColor,
    this.fontFamily,
    this.height,
    this.width,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
  });

  final GestureTapCallback? onTap;
  final String title;
  final Widget? icon; 
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final List<Color>? gradiantColors;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final String? fontFamily;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(12.0),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: gradiantColors ??
                [
                  SDColors.deleteButtonLeft,
                  SDColors.deleteButtonRight,
                ],
          ),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 0.0,
          ),
        ),
        padding: padding ?? const EdgeInsets.symmetric(vertical: 15.0),
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 15.0),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: icon!,
              ),
            ],
            AppText(
              title,
              textColor: textColor ?? SDColors.settingsTextWhite,
              fontSize: fontSize ?? 16.0,
              fontFamily: fontFamily ?? sora,
              fontWeight: fontWeight ?? FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
