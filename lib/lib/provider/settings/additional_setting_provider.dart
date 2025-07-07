import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_astro/common/utils/api_constant.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/widgets/app_gradiant_button.dart';
import 'package:star_astro/widgets/app_text.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../common/utils/common_function.dart';
import '../../../common/utils/common_widget.dart';
import '../../../common/utils/constanr_list.dart';
import '../../models/const_settings.dart';

class AdditionalSettingProvider with ChangeNotifier {
  final additionalSettingsList = ConstantList.additionalSettingsList;

  final additionalAboutList = ConstantList.additionalAboutList;

  onSettingItemClick(
      ConstantSettings additionalSetting, BuildContext context) async {
    const mailTo = 'mailto:connect@starastrogpt.com?subject=Support%3A';

    return switch (additionalSetting.id) {
      // 1 => context.router.push(const LanguagesScreen()),
      2 => context.push('/change_password_screen'),
      // 3 => context.router.push(const AppAppearanceScreen()),
      4 => await launch(mailTo),
      5 => context.push('/delete_account_screen'),
      _ => null,
    };
  }

  //On Settings about item click navigation
  onAboutItemClick(ConstantSettings aboutSetting, BuildContext context) async {
    const privacyPolicy = 'https://www.starastrogpt.com/privacy-policy';
    const termsService = 'https://www.starastrogpt.com/terms-of-service';
    return switch (aboutSetting.id) {
      1 => await launch(termsService),
      2 => await launch(privacyPolicy),
      3 => onLogoutClick(context),
      _ => null,
    };
  }

//   onLogoutClick(BuildContext context) async {
//     appDialog(
//       context,
//       title: "Logout",
//       widget: Column(
//         children: [
//           const AppText(
//             "Are You Sure, You Want To Logout?",
//             fontSize: 14.0,
//             textColor: SDColors.whiteColor,
//           ),
//           const SizedBox(
//             height: 15.0,
//           ),
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Expanded(
//                 child: AppGradiantButton(
//                   title: "Okay",
//                   onTap: () async {
//                     Navigator.pop(context); // close dialog

//                     /// Step 1: Clear preferences
//                     await clearAllPreferences();

//                     /// Step 2: Reset any providers (optional but recommended)
//                     // await resetProviders();

//                     /// Step 3: Navigate to login & clear nav stack
//                     context.go('/sign_in_screen');
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: AppGradiantButton(
//                   title: "Cancel",
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
  onLogoutClick(BuildContext context) async {
    appDialog(
      context,
      title: "Logout",
      widget: Column(
        children: [
          const AppText(
            "Are You Sure, You Want To Logout?",
            fontSize: 14.0,
            textColor: SDColors.whiteColor,
          ),
          const SizedBox(height: 15.0),
          Row(
            children: [
              Expanded(
                child: AppGradiantButton(
                  title: "Okay",
                  onTap: () async {
                    Navigator.pop(context);
                    accessToken = null; // Clear access token

                    /// 🔒 Step 1: Clear all local data and mark user as logged out
                    await clearAllPreferences();

                    /// ✅ Step 2: Cancel any ongoing token refresh timers or API queues if any (optional)

                    /// ⛔ Step 3: Ensure no providers reinitialize with old token (use isLoggedIn())
                    // await resetProviders();

                    /// 🚀 Step 4: Navigate
                    context.go('/sign_in_screen');
                  },
                ),
              ),
              Expanded(
                child: AppGradiantButton(
                  title: "Cancel",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
