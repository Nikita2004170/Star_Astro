import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/widgets/app_text.dart';
import '../../../common/utils/app_string.dart';
import '../../../common/utils/styles.dart';
import '../../../widgets/app_scaffold.dart';
import '../../provider/pdf/pdf_report_provider.dart';
import 'item_view/pdf_report_item_view.dart';

// @RoutePage()
class PdfReportScreen extends StatefulWidget {
  const PdfReportScreen({super.key});

  @override
  State<PdfReportScreen> createState() => _PdfReportScreenState();
}

class _PdfReportScreenState extends State<PdfReportScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: _buildPdfReportView(context),
    );
  }

  Widget _buildPdfReportView(BuildContext context) {
    final pdfReportProvider =
        Provider.of<PdfReportProvider>(context, listen: false);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 10.0, top: 15.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: SDColors.whiteColor,
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                AppText(
                  AppString.pdfReport.toUpperCase(),
                  textColor: SDColors.whiteColor.withOpacity(0.7),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: sora,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const Divider(
            color: SDColors.dividerColor,
            height: 3.0,
            thickness: 1.0,
          ),
          const SizedBox(
            height: 16.0,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: pdfReportProvider.pdfDemoModel.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final PdfDemoModel pdfDemoModel =
                    pdfReportProvider.pdfDemoModel[index];

                if (pdfDemoModel.type == 1) {
                  return ListView.builder(
                    itemCount: pdfDemoModel.pdfReportData?.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final PdfReportData pdfReportData =
                          pdfDemoModel.pdfReportData![index];
                      return PdfReportItemView(
                        pdfReportData: pdfReportData,
                        padding: EdgeInsets.zero,
                        onTap: () => pdfReportProvider.onPdfReportItemClick(
                          context,
                          pdfReportData,
                        ),
                      );
                    },
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Row(
                    children: pdfDemoModel.pdfReportData
                            ?.map(
                              (pdfReportData) => PdfReportItemView(
                                pdfReportData: pdfReportData,
                                height: MediaQuery.of(context).size.width / 2,
                                padding: const EdgeInsets.only(right: 16.0),
                                onTap: () =>
                                    pdfReportProvider.onPdfReportItemClick(
                                  context,
                                  pdfReportData,
                                ),
                              ),
                            )
                            .toList() ??
                        [],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
