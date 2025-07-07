import 'package:flutter/material.dart';
import '../../../../../common/utils/colors.dart';
import '../../../../../common/utils/styles.dart';
import '../../../../../widgets/app_text.dart';

class SettingsTableView extends StatelessWidget {
  const SettingsTableView({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(110.0),
        },
        children: [
          TableRow(
            children: [
              AppText(
                title,
                fontSize: 16.0,
                fontFamily: sora,
                fontWeight: FontWeight.w600,
                textColor: SDColors.settingsTextWhite.withOpacity(0.6),
              ),
              AppText(
                value,
                fontSize: 16.0,
                fontFamily: sora,
                textColor: SDColors.settingsTextWhite,
                fontWeight: FontWeight.w400,
              )
            ],
          ),
        ],
      ),
    );
  }
}
