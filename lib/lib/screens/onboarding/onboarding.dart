import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_astro/common/utils/app_string.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/common/utils/images.dart';
import 'package:star_astro/widgets/app_gradiant_button.dart';
import 'package:star_astro/widgets/app_text.dart';

import '../../../common/utils/styles.dart';
import '../../../widgets/app_scaffold.dart';
import '../../provider/onboarding_provider.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Consumer<OnBoardingProvider>(
        builder: (context, _, child) {
          return GestureDetector(
            onTapDown: (TapDownDetails details) =>
                _.onTapDown(details, context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, right: 24.0, top: 55.0, bottom: 35.0),
                  child: GestureDetector(
                    onTap: () => _.navigateToSignIn(context),
                    child: const AppText(
                      AppString.skip,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      fontFamily: sora,
                      textColor: SDColors.settingsTextWhite,
                    ),
                  ),
                ),
                Expanded(
                  child: PageView(
                    clipBehavior: Clip.hardEdge,
                    physics: const BouncingScrollPhysics(),
                    controller: _.pageController,
                    onPageChanged: (index) => _.onPageChanged(index),
                    children: [
                      _buildPage(
                        imagePath: Images.onboarding1,
                        text: 'Welcome to Unlock the Stars!',
                        subtitle:
                            "Explore the fusion of Vedic Astrology and Space Intelligence with Star Astro GPTCurve.",
                        showNextButton: false,
                        onBoardingProvider: _,
                      ),
                      _buildPage(
                        imagePath: Images.onboarding2,
                        text: 'Celestial Insights\n Await',
                        subtitle:
                            "Embark on a journey where tradition meets technology. Star Astro GPT: AI-powered astrology for precise insights.",
                        showNextButton: false,
                        onBoardingProvider: _,
                      ),
                      _buildPage(
                        imagePath: Images.onboarding3,
                        text: 'Cosmic Wisdom\n Unleashed',
                        subtitle:
                            "Explore cosmic mysteries with Star Astro GPT—Vedic Astrology and AI for precise insights.",
                        showNextButton: false,
                        onBoardingProvider: _,
                      ),
                      _buildPage(
                        imagePath: Images.onboarding4,
                        text: 'Your Astrological\n Guide',
                        subtitle:
                            "Start your astrological adventure with Star Astro GPT – AI at the intersection of tradition and innovation.",
                        showNextButton: true,
                        onBoardingProvider: _,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                      (index) => Padding(
                        padding: const EdgeInsets.only(
                            left: 7.0, right: 7.0, bottom: 15.0),
                        child: Icon(
                          _.currentPage == index
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          size: 10,
                          color: _.currentPage == index
                              ? SDColors.deleteButtonLeft
                              : SDColors.referCopy,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget _buildPage({
  //   required String imagePath,
  //   required String text,
  //   required String subtitle,
  //   required bool showNextButton,
  //   required OnBoardingProvider onBoardingProvider,
  // }) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 24.0),
  //         child: Image.asset(
  //           imagePath,
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //       const SizedBox(height: 20.0),
  //       AppText(
  //         text,
  //         textAlign: TextAlign.center,
  //         fontSize: 36.0,
  //         fontWeight: FontWeight.w700,
  //         textColor: SDColors.settingsTextWhite,
  //         fontFamily: sora,
  //       ),
  //       const SizedBox(height: 24.0),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //         child: AppText(
  //           subtitle,
  //           textAlign: TextAlign.center,
  //           fontSize: 17.0,
  //           fontWeight: FontWeight.w400,
  //           textColor: SDColors.referCopy,
  //           fontFamily: sora,
  //         ),
  //       ),
  //       if (showNextButton)
  //         Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: AppGradiantButton(
  //             onTap: () => onBoardingProvider.navigateToSignIn(context),
  //             title: AppString.getStart,
  //           ),
  //         ),
  //     ],
  //   );
  // }
  Widget _buildPage({
  required String imagePath,
  required String text,
  required String subtitle,
  required bool showNextButton,
  required OnBoardingProvider onBoardingProvider,
}) {
  return SafeArea(
    child: LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;

        return Column(
          children: [
            SizedBox(
              height: height * 0.45,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  width: width * 0.8,
                ),
              ),
            ),
            SizedBox(height: height * 0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppText(
                text,
                textAlign: TextAlign.center,
                fontSize: width * 0.08, // responsive font
                fontWeight: FontWeight.w700,
                textColor: SDColors.settingsTextWhite,
                fontFamily: sora,
              ),
            ),
            SizedBox(height: height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppText(
                subtitle,
                textAlign: TextAlign.center,
                fontSize: width * 0.045, // responsive subtitle font
                fontWeight: FontWeight.w400,
                textColor: SDColors.referCopy,
                fontFamily: sora,
              ),
            ),
            const Spacer(),
            if (showNextButton)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AppGradiantButton(
                  onTap: () => onBoardingProvider.navigateToSignIn(context),
                  title: AppString.getStart,
                ),
              ),
          ],
        );
      },
    ),
  );
}

}
