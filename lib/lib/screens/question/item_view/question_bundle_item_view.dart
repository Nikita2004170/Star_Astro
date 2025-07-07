// import 'package:flutter/material.dart';
// import 'package:star_astro/common/extension/string_extension.dart';
// import 'package:star_astro/common/utils/colors.dart';
// import 'package:star_astro/widgets/app_text.dart';
// import '../../../../common/utils/images.dart';
// import '../../../../common/utils/styles.dart';
// import '../../../models/plan_model.dart';

// class QuestionBundleItemView extends StatelessWidget {
//   const QuestionBundleItemView({
//     super.key,
//     this.onTap,
//     required this.plan,
//     required this.locationStatus,
//   });

//   final GestureTapCallback? onTap;
//   final PlanData plan;
//   final int locationStatus;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: BorderContainer(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Image.asset(
//                   Images.questionSpark,
//                   height: 40.0,
//                   width: 40.0,
//                 ),
//                 Image.asset(
//                   Images.questionArrow,
//                   height: 19.0,
//                   width: 19.0,
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 13.0,
//             ),
//             AppText(
//               locationStatus == 1 ? "\u{20B9}${plan.priceInr}" : "\$${plan.priceUsd}",
//               fontSize: 24.0,
//               fontWeight: FontWeight.w600,
//               fontFamily: sora,
//               textColor: SDColors.settingsTextWhite,
//             ),
//             const SizedBox(
//               height: 13.0,
//             ),
//             AppText(
//               "${plan.noOfCredit?.toString() ?? " "} Question Credit",
//               fontSize: 16.0,
//               fontWeight: FontWeight.w600,
//               fontFamily: sora,
//               textColor: SDColors.settingsTextWhite,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BorderContainer extends StatelessWidget {
//   final Widget child;
//   final EdgeInsetsGeometry? padding;

//   const BorderContainer({
//     super.key,
//     required this.child,
//     this.padding,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//         border: const Border(
//           top: BorderSide(
//             width: 2.0,
//             color: SDColors.transparent,
//           ),
//         ),
//         gradient: const LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             // First gradient
//             Color.fromRGBO(255, 255, 255, 0.15),
//             Color.fromRGBO(255, 255, 255, 0.15),
//           ],
//         ),
//       ),
//       child: Stack(
//         children: [
//           // Background gradient
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8.0),
//               gradient: const LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color.fromRGBO(51, 206, 255, 0.85),
//                   Color.fromRGBO(214, 51, 255, 0),
//                 ],
//               ),
//             ),
//           ),
//           //Inner Container View
//           Container(
//             margin: const EdgeInsets.all(2.0),
//             decoration: BoxDecoration(
//               color: SDColors.whiteColor,
//               borderRadius: BorderRadius.circular(8.0),
//               gradient: const LinearGradient(
//                 colors: [
//                   SDColors.questionGradiantLight,
//                   SDColors.questionGradiantDark,
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             padding: padding ?? const EdgeInsets.all(20.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(8.0),
//               child: child,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/widgets/app_text.dart';
import '../../../../common/utils/images.dart';
import '../../../../common/utils/styles.dart';
import '../../../models/plan_model.dart';

class QuestionBundleItemView extends StatelessWidget {
  const QuestionBundleItemView({
    super.key,
    this.onTap,
    required this.plan,
    required this.isIndianUser,
    required this.isLoading,
    this.onCountryCodeFetched,
  });

  final GestureTapCallback? onTap;
  final PlanData plan;
  final bool isIndianUser;
  final bool isLoading;
  final Function(bool)? onCountryCodeFetched; // Callback to pass country code

  @override
  Widget build(BuildContext context) {
    // Notify parent about country code (if needed)
    if (onCountryCodeFetched != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onCountryCodeFetched!(isIndianUser);
      });
    }

    return GestureDetector(
      onTap: onTap,
      child: BorderContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  Images.questionSpark,
                  height: 40.0,
                  width: 40.0,
                ),
                Image.asset(
                  Images.questionArrow,
                  height: 19.0,
                  width: 19.0,
                ),
              ],
            ),
            const SizedBox(height: 13.0),
            isLoading
                ? const SizedBox(
                    height: 32.0,
                    child: Center(
                      child: SizedBox(
                        height: 20.0,
                        width: 20.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            SDColors.settingsTextWhite,
                          ),
                        ),
                      ),
                    ),
                  )
                : AppText(
                    isIndianUser
                        ? "\u{20B9}${plan.priceInr}"
                        : "\$${plan.priceUsd}",
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: sora,
                    textColor: SDColors.settingsTextWhite,
                  ),
            const SizedBox(height: 13.0),
            AppText(
              "${plan.noOfCredit?.toString() ?? " "} Question Credit",
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              fontFamily: sora,
              textColor: SDColors.settingsTextWhite,
            ),
          ],
        ),
      ),
    );
  }
}

class BorderContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const BorderContainer({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: const Border(
          top: BorderSide(
            width: 2.0,
            color: SDColors.transparent,
          ),
        ),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            // First gradient
            Color.fromRGBO(255, 255, 255, 0.15),
            Color.fromRGBO(255, 255, 255, 0.15),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(51, 206, 255, 0.85),
                  Color.fromRGBO(214, 51, 255, 0),
                ],
              ),
            ),
          ),
          //Inner Container View
          //Inner Container View
          Container(
            margin: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: SDColors.whiteColor,
              borderRadius: BorderRadius.circular(8.0),
              gradient: const LinearGradient(
                colors: [
                  SDColors.questionGradiantLight,
                  SDColors.questionGradiantDark,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: padding ?? const EdgeInsets.all(20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: child,
            ),
          )
        ],
      ),
    );
  }
}
