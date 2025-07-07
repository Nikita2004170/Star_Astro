import 'package:flutter/material.dart';
import '../common/utils/colors.dart';
import '../common/utils/styles.dart';
import 'app_text.dart';

class SettingsAppBar extends StatelessWidget {
  const SettingsAppBar({
    super.key,
    required this.title,
    this.leadingIcon,
    this.actionIcon,
    this.actionImage,
    this.onActionPressed,
  });

  final IconData? leadingIcon;
  final IconData? actionIcon;
  final String? actionImage;
  final VoidCallback? onActionPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
            icon: Icon(
              leadingIcon,
              color: SDColors.whiteColor,
            ),
          ),
          Expanded(
            child: AppText(
              title,
              textColor: SDColors.whiteColor.withOpacity(0.7),
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              fontFamily: sora,
              textAlign: TextAlign
                  .center, // Ensure the text is centered within its space
            ),
          ),
          actionImage != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: onActionPressed,
                    child: Image.asset(
                      actionImage ?? "",
                      height: 24.0,
                      width: 24.0,
                    ),
                  ),
                )
              : IconButton(
                  onPressed: onActionPressed,
                  icon: Icon(
                    actionIcon,
                    color: SDColors.whiteColor,
                  ),
                ),
        ],
      ),
    );
  }
}
