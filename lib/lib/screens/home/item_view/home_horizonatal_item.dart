import 'package:flutter/material.dart';
import 'package:star_astro/common/utils/app_string.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/common/utils/styles.dart';
import 'package:star_astro/widgets/app_text.dart';
import '../../../../common/utils/images.dart';
import '../../../../widgets/home_gradiant_border.dart';

class HomeHorizontalItem extends StatelessWidget {
  const HomeHorizontalItem({
    super.key,
    this.onTap,
  });

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: GestureDetector(
        onTap: onTap,
        child: HomeGradiantBorder(
          height: 168.0,
          width: double.infinity,
          borderRadius: 12.0,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: const Color(0xFF231D3B),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      Images.moonBack,
                      height: 40.0,
                      width: 40.0,
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    const AppText(
                      AppString.todayHoroscope,
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0,
                      fontFamily: sora,
                      textColor: SDColors.whiteColor,
                    )
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const AppText(
                  "Vedic astrology interprets planets to guide life events and destiny.",
                  fontSize: 14.0,
                  fontFamily: sora,
                  fontWeight: FontWeight.w300,
                  textColor: SDColors.pdfReportText,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Row(
                  children: [
                    AppText(
                      "EXPLORE MORE",
                      fontSize: 12.0,
                      fontFamily: source,
                      fontWeight: FontWeight.w700,
                      textColor: SDColors.whiteColor,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: SDColors.whiteColor,
                      size: 20.0,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
