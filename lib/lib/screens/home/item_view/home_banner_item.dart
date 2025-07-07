import 'package:flutter/material.dart';
import 'package:star_astro/common/utils/app_string.dart';
import '../../../../common/utils/colors.dart';
import '../../../../common/utils/images.dart';
import '../../../../common/utils/styles.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/home_gradiant_border.dart';

class HomeBannerItem extends StatelessWidget {
  const HomeBannerItem({
    super.key,
    this.onTap,
  });

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: HomeGradiantBorder(
        width: double.infinity,
        borderRadius: 12.0,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: const Color(0xFF231D3B),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const AppText(
                      "Get your AI-generated cosmic report now",
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                      fontFamily: sora,
                      textColor: SDColors.pdfReportText,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    const AppText(
                      "Coming Soon",
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                      fontFamily: sora,
                      textColor: SDColors.horoscopeTitle,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: SDColors.whiteColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 3.0),
                      child: AppText(
                        AppString.downloadNow.toUpperCase(),
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: source,
                        textColor: SDColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                Images.pdfIcon,
                fit: BoxFit.cover,
                width: 90.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
