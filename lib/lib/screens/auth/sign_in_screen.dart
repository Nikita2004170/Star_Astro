import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:star_astro/lib/provider/auth/sign_in_provider.dart';
import 'package:star_astro/common/utils/app_string.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/widgets/app_gradiant_button.dart';
import 'package:star_astro/widgets/app_scaffold.dart';
import 'package:star_astro/common/utils/images.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<SignInProvider>(context, listen: false).initUniLinks(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignInProvider>(context, listen: false);
    return AppScaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              const SizedBox(height: 192),
              Image.asset(
                Images.appBarLogo,
                height: 50.0,
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF141718),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              height: 300,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
                child: Column(
                  children: [
                    const Text(
                      AppString.chatWithTheSmartestAi,
                      style: TextStyle(
                        color: SDColors.settingsTextWhite,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      AppString.experienceThePowerOfAiWithUs,
                      style: TextStyle(
                        color: SDColors.referCopy,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 32),
                    AppGradiantButton(
                      onTap: () => provider.onGoogleSignInClick(),
                      icon: Brand(Brands.google, size: 24),
                      gradiantColors: const [
                        Colors.transparent,
                        Colors.transparent
                      ],
                      borderWidth: 2,
                      borderColor: SDColors.chatItemBack,
                      title: AppString.continueWithGoogle,
                    ),
                    const SizedBox(height: 16),
                    AppGradiantButton(
                      onTap: () => provider.onEmailSignInClick(context),
                      title: AppString.continueWithEmail,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
