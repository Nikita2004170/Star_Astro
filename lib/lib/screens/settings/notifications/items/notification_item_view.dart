import 'package:flutter/material.dart';
import '../../../../../common/utils/colors.dart';
import '../../../../../common/utils/images.dart';
import '../../../../../common/utils/styles.dart';
import '../../../../../widgets/app_text.dart';

class NotificationItemView extends StatelessWidget {
  const NotificationItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        Images.notification,
        width: 18.0,
        height: 18.0,
        fit: BoxFit.cover,
      ),
      title: const AppText(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        fontFamily: sora,
        fontSize: 16.0,
        textColor: SDColors.whiteColor,
      ),
    );
  }
}
