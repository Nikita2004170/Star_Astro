// import 'package:flutter/material.dart';
// import 'package:star_astro/widgets/app_gradiant_button.dart';
// import 'package:star_astro/widgets/edit_text.dart';
// import '../../../../common/utils/colors.dart';
// import '../../../../common/utils/styles.dart';
// import '../../../../widgets/app_text.dart';
// import '../../../provider/question/question_bundle_provider.dart';

// class PaymentModeBottomSheet extends StatelessWidget {
//   const PaymentModeBottomSheet({
//     super.key,
//     required this.questionBundleProvider,
//     required this.onUpiClick,
//     required this.onClickCard,
//   });

//   final QuestionBundleProvider questionBundleProvider;
//   final Function(String promoCode) onUpiClick;
//   final Function(String promoCode) onClickCard;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 16.0),
//       decoration: const BoxDecoration(
//         color: SDColors.backgroundColor,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30.0),
//           topRight: Radius.circular(30.0),
//         ),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             height: 6,
//             width: 40,
//             decoration: BoxDecoration(
//               color: SDColors.whiteColor,
//               borderRadius: BorderRadius.circular(20),
//             ),
//           ),
//           const SizedBox(
//             height: 20.0,
//           ),
//           const AppText(
//             'PAYMENT MODE',
//             fontSize: 15,
//             fontWeight: FontWeight.w500,
//             fontFamily: sora,
//             textColor: SDColors.whiteColor,
//           ),
//           const SizedBox(
//             height: 25.0,
//           ),
//           SizedBox(
//             height: 120.0,
//             child: ListView.separated(
//               itemCount: questionBundleProvider.paymentMode.length,
//               clipBehavior: Clip.hardEdge,
//               shrinkWrap: true,
//               physics: const BouncingScrollPhysics(),
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 final paymentMode = questionBundleProvider.paymentMode[index];
//                 return Column(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                         if (paymentMode.id == 1) {
//                           showUPIBottomSheet(
//                             context,
//                             (promoCode) => onUpiClick(promoCode),
//                           );
//                         } else if (paymentMode.id == 2) {
//                           showUPIBottomSheet(
//                             context,
//                             (promoCode) => onClickCard(promoCode),
//                           );
//                         }
//                       },
//                       child: Image.asset(
//                         paymentMode.leadingImage ?? "",
//                         height: 80.0,
//                         width: 110.0,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 8.0,
//                     ),
//                     AppText(
//                       paymentMode.title,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: sora,
//                       textColor: SDColors.whiteColor,
//                     )
//                   ],
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return const SizedBox(
//                   width: 16.0,
//                 );
//               },
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           const Align(
//             alignment: Alignment.bottomLeft,
//             child: Padding(
//               padding: EdgeInsets.only(left: 20.0),
//               child: AppText(
//                 '* SELECT ONE',
//                 textColor: SDColors.whiteColor,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// void showUPIBottomSheet(BuildContext context, Function(String) onTap) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (BuildContext context) {
//       double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
//       final promoCodeCtrl = TextEditingController();
//       return Container(
//         padding: EdgeInsets.only(
//           top: 16.0,
//           bottom: keyboardHeight + 16.0,
//         ),
//         decoration: const BoxDecoration(
//           color: SDColors.backgroundColor,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30.0),
//             topRight: Radius.circular(30.0),
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 height: 6,
//                 width: 40,
//                 decoration: BoxDecoration(
//                   color: SDColors.whiteColor,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               const SizedBox(height: 20.0),
//               const AppText(
//                 'Promo Code',
//                 fontSize: 15,
//                 fontWeight: FontWeight.w500,
//                 fontFamily: sora,
//                 textColor: SDColors.whiteColor,
//               ),
//               const SizedBox(height: 25.0),
//               const Padding(
//                 padding: EdgeInsets.only(left: 20),
//                 child: Align(
//                   alignment: Alignment.bottomLeft,
//                   child: AppText(
//                     'Enter Promo Code',
//                     textColor: SDColors.settingsTextWhite,
//                     fontFamily: sora,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: AppTextField(
//                   controller: promoCodeCtrl,
//                   fillColor: SDColors.editProfileFill,
//                   textColor: SDColors.settingsTextWhite,
//                   cursorColor: SDColors.settingsTextWhite.withOpacity(0.5),
//                   hintText: "Optional",
//                   hintColor: SDColors.settingsTextWhite.withOpacity(0.5),
//                 ),
//               ),
//               const SizedBox(height: 20.0),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 6),
//                 child: AppGradiantButton(
//                   onTap: () {
//                     Navigator.pop(context);
//                     onTap.call(promoCodeCtrl.text);
//                   },
//                   title: "Continue",
//                 ),
//               ),
//               const SizedBox(height: 20.0),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

// void showPaymentModeBottomSheet(
//   BuildContext context,
//   QuestionBundleProvider questionBundleProvider, {
//   required Function(String promoCode) onUpiClick,
//   required Function(String promoCode) onClickCard,
// }) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (BuildContext context) {
//       return PaymentModeBottomSheet(
//         questionBundleProvider: questionBundleProvider,
//         onUpiClick: (promoCode) => onUpiClick(promoCode),
//         onClickCard: (promoCode) => onClickCard(promoCode),
//       );
//     },
//   );
// }
import 'package:flutter/material.dart';
import 'package:star_astro/widgets/app_gradiant_button.dart';
import 'package:star_astro/widgets/edit_text.dart';
import '../../../../common/utils/colors.dart';
import '../../../../common/utils/styles.dart';
import '../../../../widgets/app_text.dart';
import '../../../provider/question/question_bundle_provider.dart';

class PaymentModeBottomSheet extends StatelessWidget {
  const PaymentModeBottomSheet({
    super.key,
    required this.questionBundleProvider,
    required this.onUpiClick,
    required this.onClickCard,
    required this.isIndianUser, // Add parameter
  });

  final QuestionBundleProvider questionBundleProvider;
  final Function(String promoCode) onUpiClick;
  final Function(String promoCode) onClickCard;
  final bool isIndianUser; // Add field

  @override
  Widget build(BuildContext context) {
    // Filter payment modes to exclude UPI for non-Indian users
    final filteredPaymentModes =
        questionBundleProvider.paymentMode.where((mode) {
      if (!isIndianUser && mode.id == 1) {
        return false; // Exclude UPI (id == 1) for non-Indian users
      }
      return true;
    }).toList();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: const BoxDecoration(
        color: SDColors.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 6,
            width: 40,
            decoration: BoxDecoration(
              color: SDColors.whiteColor,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const AppText(
            'PAYMENT MODE',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontFamily: sora,
            textColor: SDColors.whiteColor,
          ),
          const SizedBox(
            height: 25.0,
          ),
          SizedBox(
            height: 120.0,
            child: ListView.separated(
              itemCount: filteredPaymentModes.length, // Use filtered list
              clipBehavior: Clip.hardEdge,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final paymentMode = filteredPaymentModes[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        if (paymentMode.id == 1) {
                          showUPIBottomSheet(
                            context,
                            (promoCode) => onUpiClick(promoCode),
                          );
                        } else if (paymentMode.id == 2) {
                          showUPIBottomSheet(
                            context,
                            (promoCode) => onClickCard(promoCode),
                          );
                        }
                      },
                      child: Image.asset(
                        paymentMode.leadingImage ?? "",
                        height: 80.0,
                        width: 110.0,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    AppText(
                      paymentMode.title,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: sora,
                      textColor: SDColors.whiteColor,
                    )
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 16.0,
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: AppText(
                '* SELECT ONE',
                textColor: SDColors.whiteColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}

void showUPIBottomSheet(BuildContext context, Function(String) onTap) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
      final promoCodeCtrl = TextEditingController();
      return Container(
        padding: EdgeInsets.only(
          top: 16.0,
          bottom: keyboardHeight + 16.0,
        ),
        decoration: const BoxDecoration(
          color: SDColors.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 6,
                width: 40,
                decoration: BoxDecoration(
                  color: SDColors.whiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 20.0),
              const AppText(
                'Promo Code',
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: sora,
                textColor: SDColors.whiteColor,
              ),
              const SizedBox(height: 25.0),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: AppText(
                    'Enter Promo Code',
                    textColor: SDColors.settingsTextWhite,
                    fontFamily: sora,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: AppTextField(
                  controller: promoCodeCtrl,
                  fillColor: SDColors.editProfileFill,
                  textColor: SDColors.settingsTextWhite,
                  cursorColor: SDColors.settingsTextWhite.withOpacity(0.5),
                  hintText: "Optional",
                  hintColor: SDColors.settingsTextWhite.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: AppGradiantButton(
                  onTap: () {
                    Navigator.pop(context);
                    onTap.call(promoCodeCtrl.text);
                  },
                  title: "Continue",
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      );
    },
  );
}

void showPaymentModeBottomSheet(
  BuildContext context,
  QuestionBundleProvider questionBundleProvider, {
  required Function(String promoCode) onUpiClick,
  required Function(String promoCode) onClickCard,
  required bool isIndianUser, // Add parameter
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return PaymentModeBottomSheet(
        questionBundleProvider: questionBundleProvider,
        onUpiClick: (promoCode) => onUpiClick(promoCode),
        onClickCard: (promoCode) => onClickCard(promoCode),
        isIndianUser: isIndianUser, // Pass parameter
      );
    },
  );
}
