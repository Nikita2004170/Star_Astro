import 'package:flutter/material.dart';
import '../../../../../common/utils/app_string.dart';
import '../../../../../common/utils/colors.dart';
import '../../../../../common/utils/images.dart';
import '../../../../../common/utils/styles.dart';
import '../../../../../widgets/app_text.dart';

class InvoiceItemView extends StatelessWidget {
  const InvoiceItemView({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        Images.invoice,
        width: 18.0,
        height: 22.0,
        fit: BoxFit.cover,
      ),
      title: AppText(
        "$index ${AppString.credits}",
        fontSize: 16.0,
        textColor: SDColors.whiteColor,
        fontFamily: sora,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: SDColors.whiteColor,
        size: 24.0,
      ),
    );
  }
}
