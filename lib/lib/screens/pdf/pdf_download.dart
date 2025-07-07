import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_astro/common/utils/app_string.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/lib/provider/pdf/pdf_download_provider.dart';
import 'package:star_astro/widgets/app_gradiant_button.dart';
import 'package:star_astro/widgets/app_scaffold.dart';
import 'package:star_astro/widgets/app_text.dart';
import '../../../common/utils/images.dart';
import '../../../common/utils/styles.dart';
import '../../provider/pdf/pdf_report_provider.dart';

@RoutePage()
class PdfDownloadScreen extends StatefulWidget {
  const PdfDownloadScreen({super.key, required this.pdfReportData});

  final PdfReportData pdfReportData;

  @override
  State<PdfDownloadScreen> createState() => _PdfDownloadScreenState();
}

class _PdfDownloadScreenState extends State<PdfDownloadScreen> {
  late PdfReportData pdfReportData;

  @override
  void initState() {
    super.initState();
    //Get detail of item id vise
    pdfReportData = widget.pdfReportData;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: _buildPdfDownloadView(context),
    );
  }

  Widget _buildPdfDownloadView(BuildContext context) {
    final pdfProvider =
        Provider.of<PdfDownloadProvider>(context, listen: false);

    return Container(
      color: SDColors.pdfReportBack,
      child: Stack(
        children: [
          Image.asset(
            pdfReportData.image ?? "",
            fit: BoxFit.cover,
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
            child: Container(
              decoration: BoxDecoration(
                color: SDColors.pdfReportBack,
                border: Border.all(width: 2.0),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16.0),
                  topLeft: Radius.circular(16.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            pdfReportData.title,
                            fontFamily: sora,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                            textColor: SDColors.settingsTextWhite,
                          ),
                          sizedBox8(),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: SDColors.whiteColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(200.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7.0, vertical: 2.0),
                                child: Row(
                                  children: [
                                    const AppText(
                                      "4.9 ",
                                      fontFamily: sora,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      textColor: SDColors.settingsTextWhite,
                                    ),
                                    Image.asset(
                                      Images.star,
                                      width: 17.0,
                                      height: 17.0,
                                    ),
                                  ],
                                ),
                              ),
                              AppText(
                                " (1.9k)",
                                fontFamily: sora,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                textColor:
                                    SDColors.settingsTextWhite.withOpacity(0.7),
                              ),
                            ],
                          ),
                          const Divider(
                            color: SDColors.dividerColor,
                            height: 26.0,
                            thickness: 1,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  const AppText(
                                    AppString.pdfDownloadDesc,
                                    fontFamily: sora,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    textColor: SDColors.settingsTextWhite,
                                  ),
                                  sizedBox8(),
                                  _richText(
                                    '1. Sun Sign: ',
                                    'Represents your core personality, ego, and essence.',
                                  ),
                                  sizedBox8(),
                                  _richText(
                                    '2. Moon Sign: ',
                                    'Reflects your emotional nature and inner self.',
                                  ),
                                  sizedBox8(),
                                  _richText(
                                    '3. Rising Sign: ',
                                    'Indicates your outward demeanor and how others perceive you.',
                                  ),
                                  sizedBox8(),
                                  _richText(
                                    '4. Planets in Sign: ',
                                    ' Each planet in the chart (e.g., Mercury, Venus, Mars) affects different aspects of your personality and life, depending on the sign it occupies.',
                                  ),
                                  sizedBox8(),
                                  _richText(
                                    '5. Houses: ',
                                    'The chart is divided into 12 houses, each representing different areas of life (e.g., career, relationships, health).',
                                  ),
                                  sizedBox8(),
                                  _richText(
                                    '6. Aspects: ',
                                    'These are the angles between planets, which influence how the planetary energies interact.',
                                  ),
                                  sizedBox8(),
                               
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: SDColors.dividerColor,
                    height: 3.0,
                    thickness: 1.0,
                  ),
                  Container(
                    height: 85.0,
                    color: SDColors.downloadBtn,
                    child: Center(
                      child: AppGradiantButton(
                        height: 40.0,
                        width: 190.0,
                        padding: EdgeInsets.zero,
                        title: AppString.downloadNow,
                        fontSize: 16.0,
                        borderRadius: BorderRadius.circular(4.0),
                        fontFamily: sora,
                        fontWeight: FontWeight.w400,
                        textColor: SDColors.whiteColor,
                        onTap: () => pdfProvider.onDownloadClick(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 30.0,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: SDColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox sizedBox8() {
    return const SizedBox(
      height: 8.0,
    );
  }

  Widget _richText(String title, String subTitle) {
    return RichText(
      text: TextSpan(
        text: title,
        style: const TextStyle(
          fontFamily: sora,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          color: SDColors.settingsTextWhite,
        ),
        children: <TextSpan>[
          TextSpan(
            text: subTitle,
            style: const TextStyle(
              fontFamily: sora,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: SDColors.settingsTextWhite,
            ),
          ),
        ],
      ),
    );
  }
}
