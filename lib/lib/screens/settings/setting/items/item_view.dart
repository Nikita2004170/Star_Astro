import 'package:flutter/material.dart';
import '../../../../../common/utils/colors.dart';
import '../../../../../common/utils/styles.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../models/const_settings.dart';

class SettingsAccountItemView extends StatelessWidget {
  const SettingsAccountItemView({
    super.key,
    required this.setting,
    this.onItemClick,
    this.isLanguage = false,
    this.isActionHide = false,
  });

  final ConstantSettings setting;
  final GestureTapCallback? onItemClick;
  final bool isLanguage;
  final bool isActionHide;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemClick,
      child: Container(
        color: SDColors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    setting.leadingImage ?? "",
                    width: 24.0,
                    height: 24.0,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  AppText(
                    setting.title,
                    textColor: setting.color ?? SDColors.whiteColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: sora,
                  ),
                ],
              ),
              if (!isActionHide) _trailingWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _trailingWidget() {
    if (isLanguage) {
      return const SizedBox.shrink();
    }
    return const Icon(
      Icons.arrow_forward_ios,
      color: SDColors.whiteColor,
      size: 24.0,
    );
  }
}
