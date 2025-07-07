import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:star_astro/common/utils/styles.dart';

import '../../widgets/app_text.dart';
import 'colors.dart';

showSnackBar(
    {required String message, required BuildContext context, isError = false}) {
  OneContext()
      .showSnackBar(builder: (_) => getSnackBar(message, isError: true));
}

SnackBar getSnackBar(message, {isError = false}) {
  return SnackBar(
    content: message,
    backgroundColor: !isError ? SDColors.secondary : SDColors.alertRedColor,
    behavior: SnackBarBehavior.floating,
    duration: isError
        ? const Duration(seconds: 2)
        : const Duration(milliseconds: 1500),
  );
}

Divider divider({double? height}) {
  return Divider(
    color: SDColors.accountDivider,
    thickness: 2,
    height: height,
  );
}

void appDialog(
  BuildContext context, {
  String? title,
  EdgeInsetsGeometry? contentPadding,
  required Widget widget,
  bool barrierDismissible = true,
}) {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: const Color(0xFF090d2c),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppText(
                title,
                fontFamily: sora,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
                textColor: SDColors.whiteColor,
              ),
              const SizedBox(height: 16),
              widget,
            ],
          ),
        ),
      );
    },
  );
}

showProgressDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: progressIndicator(),
    ),
    useRootNavigator: false,
  );
}

Widget progressIndicator() {
  return const Center(
    child: CircularProgressIndicator(
      color: SDColors.sendChatBack,
    ),
  );
}

void snackBar(BuildContext context, String message, Color backgroundColor) {
  final snackBar = SnackBar(
    content: AppText(
      message,
      textColor: SDColors.whiteColor,
    ),
    backgroundColor: backgroundColor,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
