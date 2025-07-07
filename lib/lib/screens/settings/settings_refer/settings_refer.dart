import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/common/utils/global.dart';
import 'package:star_astro/widgets/app_text.dart';
import '../../../../common/utils/app_string.dart';
import '../../../../common/utils/images.dart';
import '../../../../common/utils/styles.dart';
import '../../../../widgets/app_scaffold.dart';
import '../../../provider/settings/refer_provider.dart';

@RoutePage()
class SettingsReferScreen extends StatelessWidget {
  const SettingsReferScreen({super.key});

  void _handleBack(BuildContext context) {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _handleBack(context);
        return false;
      },
      child: ChangeNotifierProvider(
        create: (_) => ReferProvider(),
        child: AppScaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: SDColors.backgroundColor,
            title: AppText(
              AppString.referEarn.toUpperCase(),
              textColor: SDColors.whiteColor.withOpacity(0.7),
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              fontFamily: sora,
              textAlign: TextAlign.center,
            ),
            leading: IconButton(
              icon:
                  const Icon(Icons.arrow_back_ios, color: SDColors.whiteColor),
              onPressed: () => _handleBack(context),
            ),
          ),
          body: Consumer2<ReferProvider, GlobalProvider>(
            builder: (context, referProvider, globalProvider, _) {
              final referralId = globalProvider.userModel?.referralId ?? "";

              return SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 80.0),
                    Image.asset(
                      Images.refer,
                      fit: BoxFit.contain,
                      height: 125.0,
                      width: 108.0,
                    ),
                    const SizedBox(height: 50.0),
                    const AppText(
                      AppString.referAFriend,
                      fontFamily: sora,
                      textColor: SDColors.whiteColor,
                      fontSize: 22.0,
                    ),
                    const SizedBox(height: 8.0),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: AppText(
                        AppString.referAFriendDesc,
                        fontFamily: sora,
                        textColor: SDColors.whiteColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 60),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: SDColors.accountDivider,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        onTap: () =>
                            referProvider.copyToClipboard(context, referralId),
                        leading: Image.asset(
                          Images.settingsRefer,
                          width: 22.0,
                          height: 22.0,
                          color: SDColors.referCopy,
                        ),
                        title: AppText(
                          referralId,
                          fontSize: 16.0,
                          textColor: SDColors.whiteColor,
                        ),
                        trailing: Image.asset(
                          Images.copy,
                          width: 22.0,
                          height: 22.0,
                          color: SDColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
