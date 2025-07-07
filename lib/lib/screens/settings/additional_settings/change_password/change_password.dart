// import 'package:auto_route/annotations.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:star_astro/widgets/app_gradiant_button.dart';
// import 'package:star_astro/widgets/app_scaffold.dart';
// import 'package:star_astro/widgets/app_text.dart';
// import '../../../../../common/utils/app_string.dart';
// import '../../../../../common/utils/colors.dart';
// import '../../../../../common/utils/images.dart';
// import '../../../../../common/utils/styles.dart';
// import '../../../../../widgets/edit_text.dart';
// import '../../../../provider/settings/change_password_provider.dart';

// @RoutePage()
// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({super.key});

//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }

// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return AppScaffold(
//       appBar: AppBar(
//         backgroundColor: SDColors.transparent,
//         elevation: 0,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 8.0),
//           child: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(Icons.arrow_back_ios)),
//         ),
//       ),
//       body: _buildChangePasswordView(context),
//     );
//   }

//   Widget _buildChangePasswordView(BuildContext context) {
//     final changePasswordProvider =
//         Provider.of<ChangePasswordProvider>(context, listen: false);
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 32.0),
//         child: ListView(
//           shrinkWrap: true,
//           physics: const BouncingScrollPhysics(),
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 0.0, bottom: 86.0),
//               child: Image.asset(
//                 Images.changePasswordLogo,
//                 height: 50.0,
//               ),
//             ),
//             const AppText(
//               AppString.createNewPassword,
//               textColor: SDColors.settingsTextWhite,
//               fontWeight: FontWeight.bold,
//               fontSize: 40.0,
//               fontFamily: sora,
//             ),
//             const SizedBox(
//               height: 32.0,
//             ),
//             Consumer<ChangePasswordProvider>(
//               builder: (context, provider, child) {
//                 return AppTextField(
//                   controller: changePasswordProvider.oldPasswordCtrl,
//                   hintText: AppString.oldPassword,
//                   cursorColor: SDColors.settingsTextWhite.withOpacity(0.5),
//                   fontSize: 14.0,
//                   fontFamily: sora,
//                   fillColor: SDColors.editProfileFill,
//                   fontWeight: FontWeight.w400,
//                   textColor: SDColors.settingsTextWhite,
//                   hintColor: SDColors.settingsTextWhite.withOpacity(0.5),
//                   prefixIcon: _getLockIcon,
//                   obscureText: provider.isOldObscure,
//                   suffixIcon: GestureDetector(
//                     onTap: () => provider.onOldObscureClick(),
//                     child: Icon(
//                       provider.isOldObscure
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                       color: SDColors.settingsTextWhite.withOpacity(0.5),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(
//               height: 16.0,
//             ),
//             Consumer<ChangePasswordProvider>(
//               builder: (context, provider, child) {
//                 return AppTextField(
//                   controller: changePasswordProvider.newPasswordCtrl,
//                   hintText: AppString.newPassword,
//                   cursorColor: SDColors.settingsTextWhite.withOpacity(0.5),
//                   fontSize: 14.0,
//                   fontFamily: sora,
//                   fillColor: SDColors.editProfileFill,
//                   fontWeight: FontWeight.w400,
//                   textColor: SDColors.settingsTextWhite,
//                   hintColor: SDColors.settingsTextWhite.withOpacity(0.5),
//                   prefixIcon: _getLockIcon,
//                   obscureText: provider.isNewObscure,
//                   suffixIcon: GestureDetector(
//                     onTap: () => provider.onNewObscureClick(),
//                     child: Icon(
//                       provider.isNewObscure
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                       color: SDColors.settingsTextWhite.withOpacity(0.5),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(
//               height: 16.0,
//             ),
//             Consumer<ChangePasswordProvider>(
//               builder: (context, provider, child) {
//                 return AppTextField(
//                   controller: changePasswordProvider.confirmPasswordCtrl,
//                   hintText: AppString.confirmPassword,
//                   cursorColor: SDColors.settingsTextWhite.withOpacity(0.5),
//                   fontSize: 14.0,
//                   fontFamily: sora,
//                   fillColor: SDColors.editProfileFill,
//                   fontWeight: FontWeight.w400,
//                   textColor: SDColors.settingsTextWhite,
//                   hintColor: SDColors.settingsTextWhite.withOpacity(0.5),
//                   prefixIcon: _getLockIcon,
//                   obscureText: provider.isConfirmObscure,
//                   suffixIcon: GestureDetector(
//                     onTap: () => provider.onConfirmObscureClick(),
//                     child: Icon(
//                       provider.isConfirmObscure
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                       color: SDColors.settingsTextWhite.withOpacity(0.5),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(
//               height: 16.0,
//             ),
//             AppGradiantButton(
//               title: AppString.continueBtn,
//               margin: EdgeInsets.zero,
//               onTap: () => changePasswordProvider.onContinueClick(context),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Icon get _getLockIcon {
//     return Icon(
//       Icons.lock_outline,
//       color: SDColors.settingsTextWhite.withOpacity(0.5),
//     );
//   }
// }
