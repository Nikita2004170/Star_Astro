import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../common/utils/app_string.dart';
import '../../../../common/utils/colors.dart';
import '../../../../common/utils/common_widget.dart';
import '../../../../common/utils/styles.dart';
import '../../../../widgets/app_scaffold.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/social_media_items.dart';
import '../../../models/const_settings.dart';
import '../../../provider/settings/additional_setting_provider.dart';
import '../setting/items/item_view.dart';

@RoutePage()
class AdditionalSettings extends StatefulWidget {
  const AdditionalSettings({super.key});

  @override
  State<AdditionalSettings> createState() => _AdditionalSettingsState();
}

class _AdditionalSettingsState extends State<AdditionalSettings> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: SDColors.backgroundColor,
        title: AppText(
          AppString.additionalSettings.toUpperCase(),
          textColor: SDColors.whiteColor.withOpacity(0.7),
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          fontFamily: sora,
          textAlign:
              TextAlign.center, // Ensure the text is centered within its space
        ),
        leading: IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: SDColors.whiteColor,
          ),
        ),
      ),
      body: _buildAdditionalSettingsView(context),
    );
  }

  Widget _buildAdditionalSettingsView(BuildContext context) {
    final additionalSettingsProvider =
        Provider.of<AdditionalSettingProvider>(context, listen: false);
    return Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              divider(),
              ListView.separated(
                itemCount:
                    additionalSettingsProvider.additionalSettingsList.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final ConstantSettings setting =
                      additionalSettingsProvider.additionalSettingsList[index];

                  //Account's item view
                  return SettingsAccountItemView(
                    setting: setting,
                    onItemClick: () => additionalSettingsProvider
                        .onSettingItemClick(setting, context),
                    isActionHide: setting.id == 5,
                  );
                },
                separatorBuilder: (context, index) {
                  return divider();
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                width: double.maxFinite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                decoration: const BoxDecoration(color: SDColors.settingsChart),
                child: AppText(
                  AppString.about.toUpperCase(),
                  textColor: SDColors.whiteColor,
                  fontSize: 16.0,
                  fontFamily: sora,
                  fontWeight: FontWeight.w600,
                ),
              ),
              divider(height: 0),
              const SizedBox(
                height: 10.0,
              ),
              ListView.separated(
                itemCount:
                    additionalSettingsProvider.additionalAboutList.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final ConstantSettings setting =
                      additionalSettingsProvider.additionalAboutList[index];

                  //Account's item view
                  return SettingsAccountItemView(
                    setting: setting,
                    onItemClick: () => additionalSettingsProvider
                        .onAboutItemClick(setting, context),
                    isActionHide: setting.id == 3,
                  );
                },
                separatorBuilder: (context, index) {
                  return divider();
                },
              ),
            ],
          ),
        ),
        const SocialMediaItems(),
      ],
    );
  }
}
