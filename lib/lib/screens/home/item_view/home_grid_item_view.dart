import 'package:flutter/material.dart';
import '../../../../common/utils/colors.dart';
import '../../../../common/utils/styles.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/home_gradiant_border.dart';
import '../../../provider/pdf/pdf_report_provider.dart';

class HomeGridItemView extends StatelessWidget {
  const HomeGridItemView({
    super.key,
    required this.gridItem,
    this.onTap,
  });

  final PdfReportData gridItem;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: HomeGradiantBorder(
            height: gridItem.id == 3
                ? 255.0 // Bigger height for Relationship AI
                : (gridItem.id == 1 || gridItem.id == 3
                    ? 180.0 // Medium height for specific cards
                    : 105.0), // Default height

            width: double.infinity,
            child: Image.asset(
              gridItem.image ?? "",
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        const SizedBox(
          height: 4.0,
        ),
        AppText(
          gridItem.title ?? "",
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          fontFamily: sora,
          textColor: SDColors.horoscopeTitle,
        ),
      ],
    );
  }
}
