import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_astro/lib/provider/settings/settings_provider.dart';
import '../../../../common/utils/app_string.dart';
import '../../../../common/utils/colors.dart';
import '../../../../common/utils/common_widget.dart';
import '../../../../common/utils/global.dart';
import '../../../../common/utils/styles.dart';
import '../../../../widgets/app_scaffold.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/settings_app_bar.dart';
import '../../../../widgets/social_media_items.dart';
import '../../../models/const_settings.dart';
import 'components/settings_table_view.dart';
import 'items/item_view.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: _buildSettingsView(context),
    );
  }

  Widget _buildSettingsView(BuildContext context) {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);

    return SafeArea(
      child: Column(
        children: [
          SettingsAppBar(
            title: AppString.settings.toUpperCase(),
            leadingIcon: Icons.arrow_back_ios,
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 8.0),
                  decoration:
                      const BoxDecoration(color: SDColors.settingsChart),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        AppString.yourChart.toUpperCase(),
                        textColor: SDColors.whiteColor,
                        fontSize: 16.0,
                        fontFamily: sora,
                        fontWeight: FontWeight.w600,
                      ),
                      GestureDetector(
                        onTap: () => settingsProvider.onEditClick(context),
                        child: AppText(
                          AppString.edit.toUpperCase(),
                          textColor: SDColors.whiteColor.withOpacity(0.6),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: sora,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Consumer<GlobalProvider>(
                  builder: (context, _, child) {
                    return SettingsTableView(
                      title: AppString.name,
                      value:
                          "${_.userModel?.firstName ?? ""} ${_.userModel?.lastName ?? ""}",
                    );
                  },
                ),
                Consumer<GlobalProvider>(
                  builder: (context, _, child) {
                    return SettingsTableView(
                      title: AppString.birthDate,
                      value: _.formatBirthDate(),
                    );
                  },
                ),
                Consumer<GlobalProvider>(
                  builder: (context, _, child) {
                    return SettingsTableView(
                      title: AppString.birthPlace,
                      value: _.userModel?.placeOfBirth ?? "",
                    );
                  },
                ),
                Consumer<GlobalProvider>(
                  builder: (context, _, child) {
                    return SettingsTableView(
                      title: AppString.birthTime,
                      value: _.userModel?.timeOfBirth ?? "",
                    );
                  },
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 8.0),
                  decoration:
                      const BoxDecoration(color: SDColors.settingsChart),
                  child: AppText(
                    AppString.yourAccount.toUpperCase(),
                    textColor: SDColors.whiteColor,
                    fontSize: 16.0,
                    fontFamily: sora,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                ListView.separated(
                  itemCount: settingsProvider.accountSettingsList.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final ConstantSettings setting =
                        settingsProvider.accountSettingsList[index];

                    //Account's item view
                    return SettingsAccountItemView(
                      setting: setting,
                      onItemClick: () =>
                          settingsProvider.onAccountItemClick(setting, context),
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
      ),
    );
  }
}
