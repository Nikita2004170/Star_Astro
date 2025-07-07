import 'package:flutter/material.dart';
import '../../../../common/utils/colors.dart';
import '../../../../common/utils/styles.dart';
import '../../../../widgets/app_text.dart';
import '../../../provider/pdf/pdf_report_provider.dart';

class PdfReportItemView extends StatelessWidget {
  const PdfReportItemView({
    super.key,
    required this.pdfReportData,
    this.height,
    this.width,
    required this.padding,
    this.onTap,
  });

  final PdfReportData pdfReportData;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry padding;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              pdfReportData.image ?? "",
              fit: BoxFit.cover,
              height: height,
              width: width,
            ),
            const SizedBox(
              height: 16.0,
            ),
            AppText(
              pdfReportData.title ?? "",
              textColor: SDColors.settingsTextWhite,
              fontFamily: sora,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(
              height: 4.0,
            ),
            AppText(
              "Coming Soon",
              // "\$${pdfReportData.price}/-",
              textColor: SDColors.settingsTextWhite.withOpacity(0.8),
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              fontFamily: sora,
            ),
          ],
        ),
      ),
    );
  }
}
