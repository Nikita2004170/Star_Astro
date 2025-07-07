import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/common/utils/styles.dart';
import 'package:star_astro/lib/provider/home/home_provider.dart';
import 'package:star_astro/widgets/app_text.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({
    super.key,
    required this.homeProvider,
    required this.scrollController,
  });

  final HomeProvider homeProvider;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Container(
          height: 70.0,
          decoration: const BoxDecoration(
            color: SDColors.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          child: Row(
            children: homeProvider.homeBottomList
                .map(
                  (bottomItem) => Expanded(
                    child: GestureDetector(
                      onTap: () {
                        homeProvider.onBottomItemClick(bottomItem.id, context);

                        if (bottomItem.id == 1) {
                          scrollController.animateTo(
                            0.0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                        child: Column(
                          crossAxisAlignment: bottomItem.id == 1
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  bottomItem.leadingImage ?? "",
                                  height: 30.0,
                                  width: 30.0,
                                ),
                                AppText(
                                  bottomItem.title ?? "",
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: sora,
                                  textColor: SDColors.deleteButtonLeft,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
