import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/common/utils/global.dart';
import 'package:star_astro/common/utils/styles.dart';
import 'package:star_astro/widgets/app_text.dart';
import '../../../../common/utils/app_string.dart';
import '../../../../widgets/app_scaffold.dart';

@RoutePage()
class CreditsScreen extends StatefulWidget {
  const CreditsScreen({super.key});

  @override
  State<CreditsScreen> createState() => _CreditsScreenState();
}

class _CreditsScreenState extends State<CreditsScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        backgroundColor: SDColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: AppText(
          AppString.credits.toUpperCase(),
          textColor: SDColors.whiteColor.withOpacity(0.7),
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          fontFamily: sora,
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: SDColors.whiteColor,
          ),
        ),
      ),
      body: _buildCreditView(),
    );
  }

  Widget _buildCreditView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Consumer<GlobalProvider>(
                builder: (context, _, child) {
                  return AppText(
                    "${_.userModel?.wallet?.balance ?? "0"}",
                    fontWeight: FontWeight.w400,
                    fontSize: 65.0,
                    fontFamily: sora,
                    textColor: SDColors.whiteColor,
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5.0, bottom: 18.0),
                child: AppText(
                  AppString.credits,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  fontFamily: sora,
                  textColor: SDColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 10.0),
          child: Consumer<GlobalProvider>(
            builder: (context, _, child) {
              return AppText(
                "Your credits will be expired by ${_.formatExpiredDate()}",
                fontSize: 14.0,
                textColor: SDColors.whiteColor.withOpacity(0.5),
                fontFamily: sora,
                maxLines: 2,
              );
            },
          ),
        ),
      ],
    );
  }
}
