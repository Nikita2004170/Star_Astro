// import 'package:auto_route/annotations.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:star_astro/common/utils/colors.dart';
// import 'package:star_astro/common/utils/styles.dart';
// import 'package:star_astro/lib/provider/settings/delete_account_provider.dart';
// import 'package:star_astro/widgets/app_text.dart';
// import '../../../../../common/utils/app_string.dart';
// import '../../../../../widgets/app_scaffold.dart';
// import '../../../../../widgets/edit_text.dart';
// import '../../../../../widgets/settings_app_bar.dart';

// @RoutePage()
// class DeleteAccountScreen extends StatefulWidget {
//   const DeleteAccountScreen({super.key});

//   @override
//   State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
// }

// class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return AppScaffold(
//       body: _buildDeleteAccountView(context),
//     );
//   }

//   Widget _buildDeleteAccountView(BuildContext context) {
//     final deleteAccountProvider =
//         Provider.of<DeleteAccountProvider>(context, listen: false);
//     return SafeArea(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SettingsAppBar(
//             title: AppString.deleteAccount.toUpperCase(),
//             leadingIcon: Icons.arrow_back_ios,
//           ),
//           const SizedBox(
//             height: 10.0,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const AppText(
//                   AppString.deleteAccountTitle,
//                   textColor: SDColors.whiteColor,
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: sora,
//                 ),
//                 const SizedBox(
//                   height: 8.0,
//                 ),
//                 const AppText(
//                   AppString.deleteAccountWarning,
//                   textColor: SDColors.referCopy,
//                   fontSize: 12.0,
//                   fontFamily: sora,
//                   fontWeight: FontWeight.w400,
//                 ),
//                 const SizedBox(
//                   height: 15.0,
//                 ),
//                 /* const AppText(
//                   AppString.yourPassword,
//                   textColor: SDColors.whiteColor,
//                   fontSize: 14.0,
//                   fontFamily: sora,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 const SizedBox(
//                   height: 8.0,
//                 ),
//                 AppTextField(
//                   controller: deleteAccountProvider.passwordCtrl,
//                   cursorColor: SDColors.referCopy.withOpacity(0.5),
//                   fontSize: 14.0,
//                   fontFamily: sora,
//                   fillColor: SDColors.whiteColor,
//                   fontWeight: FontWeight.w400,
//                   textColor: SDColors.referCopy,
//                   prefixIcon: Icon(
//                     Icons.lock,
//                     color: SDColors.referCopy.withOpacity(0.5),
//                   ),
//                   hintText: AppString.password,
//                   hintColor: SDColors.referCopy.withOpacity(0.5),
//                 ),*/
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 // GestureDetector(
//                 //   onTap: () =>
//                 //       deleteAccountProvider.onDeleteAccountClick(context),
//                 //   child: Container(
//                 //     width: double.infinity,
//                 //     decoration: BoxDecoration(
//                 //       borderRadius: BorderRadius.circular(12.0),
//                 //       gradient: const LinearGradient(
//                 //         begin: Alignment.topRight,
//                 //         end: Alignment.bottomLeft,
//                 //         colors: [
//                 //           SDColors.deleteButtonLeft,
//                 //           SDColors.deleteButtonRight,
//                 //         ],
//                 //       ),
//                 //     ),
//                 //     padding: const EdgeInsets.symmetric(vertical: 15.0),
//                 //     alignment: Alignment.center,
//                 //     child: const AppText(
//                 //       AppString.deleteAccount,
//                 //       textColor: SDColors.settingsTextWhite,
//                 //       fontSize: 16.0,
//                 //       fontFamily: sora,
//                 //       fontWeight: FontWeight.w600,
//                 //     ),
//                 //   ),
//                 // )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
