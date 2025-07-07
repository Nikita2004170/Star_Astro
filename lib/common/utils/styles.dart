import 'package:flutter/material.dart';
import 'package:star_astro/common/utils/dimens.dart' as dimens;
import 'colors.dart';

const poppinsFamily = "Poppins";
const HelveticaFamily = "Helvetica";
const Montserrat = "Montserrat";
const sora = "Sora";
const source = "Source_Code_Pro";
const karla = "Karla";

class TextStyles {
  static const String defaultFontFamily = poppinsFamily;
  static const String montserratFamily = Montserrat;
  static const String helveticaFontFamily = HelveticaFamily;

  static const regularTextStyle = TextStyle(
      fontSize: dimens.TextSize.normal,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w600,
      color: SDColors.textColor);

  static const mediumTextStyle = TextStyle(
      fontSize: dimens.TextSize.xlarge,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w500,
      color: SDColors.textColor);

  static TextStyle buttonTextStyle = TextStyle(
      fontSize: dimens.TextSize.buttonFont > 16
          ? dimens.TextSize.large
          : dimens.TextSize.buttonFont,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w400,
      color: SDColors.whiteColor);

  static TextStyle regularButtonTextStyle = const TextStyle(
      fontSize: dimens.TextSize.large,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w400,
      color: SDColors.whiteColor);

  ///Regular styles
  static const _small = TextStyle(
    fontSize: dimens.TextSize.small,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w400,
    color: SDColors.textColor,
  );
  static const _xsmall = TextStyle(
    fontSize: dimens.TextSize.xsmall,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w400,
    color: SDColors.textColor,
  );

  static const _xxsmall = TextStyle(
    fontSize: dimens.TextSize.xxsmall,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w400,
    color: SDColors.textColor,
  );

  static const _normal = TextStyle(
    fontSize: dimens.TextSize.normal,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w400,
    color: SDColors.textColor,
  );

  static const _normal15 = TextStyle(
    fontSize: dimens.TextSize.normal,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w400,
    color: SDColors.textColor,
  );

  static const _large = TextStyle(
    fontSize: dimens.TextSize.large,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w400,
    color: SDColors.textColor,
  );

  static const _xlarge = TextStyle(
    fontSize: dimens.TextSize.xlarge,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w400,
    color: SDColors.textColor,
  );

  static const _xxlarge = TextStyle(
    fontSize: dimens.TextSize.xxlarge,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w400,
    color: SDColors.textColor,
  );

  static const _xxxlarge = TextStyle(
    fontSize: dimens.TextSize.xxxlarge,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w400,
    color: SDColors.textColor,
  );

  static TextStyle market = const TextStyle(
    fontSize: 18,
    fontFamily: Montserrat,
    fontWeight: FontWeight.bold,
    color: SDColors.whiteColor,
  );

  static TextStyle exchange = const TextStyle(
    fontSize: 18,
    fontFamily: Montserrat,
    fontWeight: FontWeight.bold,
    color: SDColors.textColor,
  );

  static TextStyle marketPoppins = const TextStyle(
    fontSize: 18,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.bold,
    color: SDColors.whiteColor,
  );

  static TextStyle exchangePoppins = const TextStyle(
    fontSize: 18,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.bold,
    color: SDColors.textColor,
  );

  static const textFieldStyle = TextStyle(
      fontSize: dimens.TextSize.large,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w400,
      color: SDColors.textColor);

  static const smallHelveticaStyle = TextStyle(
      fontSize: dimens.TextSize.small,
      fontFamily: helveticaFontFamily,
      fontWeight: FontWeight.w400,
      color: SDColors.textColor);

  static TextStyle get small => _small;

  static TextStyle get xSmall => _xsmall;

  static TextStyle get xxSmall => _xxsmall;

  static TextStyle get normal => _normal;

  static TextStyle get normal15 => _normal15;

  static TextStyle get large => _large;

  static TextStyle get xLarge => _xlarge;

  static TextStyle get xxLarge => _xxlarge;

  static TextStyle get xxxLarge => _xxxlarge;
}

class AppTheme {
  var appTheme = ThemeData(
    primaryColor: SDColors.appColor,
    canvasColor: SDColors.whiteColor,
    hintColor: SDColors.hintTextColor,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: SDColors.textColor,
    ),
  );
}
