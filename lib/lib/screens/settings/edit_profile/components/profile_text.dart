import 'package:flutter/material.dart';
import 'package:star_astro/widgets/app_text.dart';
import '../../../../../common/utils/colors.dart';
import '../../../../../common/utils/styles.dart';

class ProfileText extends StatelessWidget {
  const ProfileText({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppText(
      title,
      fontWeight: FontWeight.w600,
      fontFamily: sora,
      textColor: SDColors.horoscopeTitle,
      fontSize: 14.0,
    );
  }
}
