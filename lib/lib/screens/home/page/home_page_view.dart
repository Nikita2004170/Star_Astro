import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_astro/common/utils/app_string.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/common/utils/global.dart';
import 'package:star_astro/lib/provider/home/brahma_ai_provider.dart';
import 'package:star_astro/lib/provider/home/home_provider.dart';
import 'package:star_astro/lib/screens/home/item_view/home_banner_item.dart';
import 'package:star_astro/lib/screens/home/page/brahma_ai.dart';
import 'package:star_astro/lib/screens/home/page/personal_details_form.dart';
import 'package:star_astro/lib/screens/question/question_bundle.dart';
import 'package:star_astro/widgets/app_text.dart';
import '../../../../common/utils/images.dart';
import '../../../../common/utils/styles.dart';
import '../../../provider/pdf/pdf_report_provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../item_view/home_grid_item_view.dart';
import '../item_view/home_horizonatal_item.dart';

class HomePageView extends StatefulWidget {
  final ScrollController scrollController;

  const HomePageView({super.key, required this.scrollController});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final bool _dialogShown = false;
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timestamp) {
    //   Provider.of<HomeProvider>(context, listen: false).dateDialog(context);
    // });
  }

  void snackBar(BuildContext context, String message, Color backgroundColor) {
    final snackBar = SnackBar(
      content: AppText(
        message,
        textColor: SDColors.whiteColor,
      ),
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return SizedBox(
      height: screenHeight,
      width: screenWidth,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0, left: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  Images.appBarLogo,
                  height: 50.0,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => homeProvider.onClickBalance(context),
                      child: Row(
                        children: [
                          Consumer<GlobalProvider>(
                            builder: (context, _, child) {
                              return AppText(
                                maxLines: 2,
                                "${_.userModel?.wallet?.balance ?? ""}",
                                textColor: SDColors.settingsTextWhite,
                                fontFamily: sora,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              );
                            },
                          ),
                          const SizedBox(
                            width: 3.0,
                          ),
                          Image.asset(
                            Images.flashIcon,
                            height: 30.0,
                            width: 30.0,
                            color: SDColors.whiteColor,
                          ),
                        ],
                      ),
                    ),
                    Consumer<BrahmaAiProvider>(
                      builder: (context, value, child) => IconButton(
                        onPressed: () {
                          value.historyBottomSheet(context);
                        },
                        icon: const Icon(
                          size: 30,
                          Icons.history,
                          color: SDColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: SDColors.dividerColor,
            height: 10,
            thickness: 1,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: ListView(
              controller: widget.scrollController,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<GlobalProvider>(
                        builder: (context, provider, child) {
                          final firstName =
                              provider.userModel?.firstName?.trim() ?? '';

                          return AppText(
                            "Hello $firstName, 👋🏻",
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Sora',
                            textColor: SDColors.whiteColor,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      AppText(
                        "Welcome to Star Astro",
                        fontSize: 18.0,
                        textColor: SDColors.unSelectedIcon.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontFamily: sora,
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      AppText(
                        AppString.aIAstrologer,
                        fontWeight: FontWeight.w600,
                        textColor: SDColors.whiteColor.withOpacity(0.7),
                        fontFamily: sora,
                        fontSize: 18.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: homeProvider.pdfDemoModel.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final PdfDemoModel pdfDemoModel =
                              homeProvider.pdfDemoModel[index];

                          return MasonryGridView.builder(
                            itemCount: pdfDemoModel.pdfReportData?.length ?? 0,
                            shrinkWrap: true,
                            crossAxisSpacing: 17.0,
                            mainAxisSpacing: 17.0,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 24.0),
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (BuildContext context, int index) {
                              final gridItem =
                                  pdfDemoModel.pdfReportData?[index];
                              if (gridItem != null) {
                                return Consumer<GlobalProvider>(
                                  builder: (context, value, child) =>
                                      HomeGridItemView(
                                    gridItem: gridItem,
                                    onTap: () {
                                      if (value.userModel?.wallet?.balance ==
                                          0) {
                                        // Show dialog for insufficient credits
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: const Color(
                                                  0xFF1A2B4D), // Dark blue background
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              title: const Text(
                                                'Insufficient Credits',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Sora',
                                                ),
                                              ),
                                              content: const Text(
                                                'You do not have enough credits. Please purchase more to continue.',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontFamily: 'Sora',
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Close the dialog
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const QuestionBundleScreen(),
                                                      ),
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Buy Credits',
                                                    style: TextStyle(
                                                      color: Color(0xFF1A2B4D),
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Sora',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        return; // Stop further execution
                                      }

                                      // Proceed with navigation if balance is sufficient
                                      if (index == 0) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BrahmaAiScreen(
                                                    aiType: 'brahma'),
                                          ),
                                        );
                                      } else if (index == 1) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BrahmaAiScreen(
                                                    aiType: 'hanuman'),
                                          ),
                                        );
                                      } else if (index == 2) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BrahmaAiScreen(
                                                    aiType: 'career'),
                                          ),
                                        );
                                      } else if (index == 3) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PersonalDetailsForm(
                                                    onContinue: (p0) {}),
                                          ),
                                        );
                                      } else if (index == 4) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BrahmaAiScreen(
                                                    aiType: 'numerology'),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          );
                        },
                      ),
                      AppText(
                        AppString.horoscope,
                        fontWeight: FontWeight.w600,
                        textColor: SDColors.whiteColor.withOpacity(0.7),
                        fontFamily: sora,
                        fontSize: 18.0,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      HomeHorizontalItem(
                        onTap: () =>
                            homeProvider.onHorizontalItemClick(context),
                      ),
                      AppText(
                        AppString.cosmicReport,
                        fontWeight: FontWeight.w600,
                        textColor: SDColors.whiteColor.withOpacity(0.7),
                        fontFamily: sora,
                        fontSize: 18.0,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      HomeBannerItem(
                        onTap: () => homeProvider.onBannerItemClick(context),
                      ),
                      const SizedBox(
                        height: 65.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
