import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_astro/common/utils/app_string.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/common/utils/images.dart';
import 'package:star_astro/common/utils/styles.dart';
import 'package:star_astro/lib/provider/auth/forgot_password_provider.dart';
import 'package:star_astro/widgets/app_gradiant_button.dart';
import 'package:star_astro/widgets/app_scaffold.dart';
import 'package:star_astro/widgets/app_text.dart';
import 'package:star_astro/widgets/edit_text.dart';

@RoutePage()
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final ForgotPasswordProvider provider =
        Provider.of<ForgotPasswordProvider>(context);
    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(top: 44, left: 118, right: 118),
            child: Image.asset(
              Images.appBarLogo,
            ),
          ),
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.only(left: 32),
            child: AppText(
              'Forgot Password?',
              textColor: SDColors.whiteColor,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: sora,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: AppTextField(
              fillColor: SDColors.editProfileFill,
              textColor: SDColors.settingsTextWhite,
              cursorColor: SDColors.settingsTextWhite.withOpacity(0.5),
              hintText: "Email",
              controller: provider.yourEmail,
              hintColor: SDColors.settingsTextWhite.withOpacity(0.5),
              prefixIcon: Icon(
                Icons.email,
                color: SDColors.settingsTextWhite.withOpacity(0.5),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: AppGradiantButton(
              onTap: () async => provider.forgotPassword(context),
              title: AppString.continueBtn,
            ),
          ),
        ],
      ),
    );
  }
}
