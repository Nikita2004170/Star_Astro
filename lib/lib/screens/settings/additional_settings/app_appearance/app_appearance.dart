import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_astro/widgets/app_scaffold.dart';
import '../../../../../common/utils/app_string.dart';
import '../../../../../common/utils/colors.dart';
import '../../../../../common/utils/common_widget.dart';
import '../../../../../common/utils/images.dart';
import '../../../../../common/utils/styles.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/settings_app_bar.dart';
import '../../../../models/const_settings.dart';
import '../../../../provider/settings/app_appearance_provider.dart';

@RoutePage()
class AppAppearanceScreen extends StatefulWidget {
  const AppAppearanceScreen({super.key});

  @override
  State<AppAppearanceScreen> createState() => _AppAppearanceScreenState();
}

class _AppAppearanceScreenState extends State<AppAppearanceScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: _buildAppAppearanceView(context),
    );
  }

  Widget _buildAppAppearanceView(BuildContext context) {
    final appAppearanceProvider =
        Provider.of<AppAppearanceProvider>(context, listen: false);
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image
        Positioned.fill(
          child: Image.asset(
            Images.bgImage,
            fit: BoxFit.cover,
          ),
        ),

        // App Appearance Body View
        SafeArea(
          child: Column(
            children: [
              SettingsAppBar(
                title: AppString.appAppearance.toUpperCase(),
                leadingIcon: Icons.arrow_back_ios,
              ),
              divider(
                height: 20.0,
              ),
              ListView.separated(
                itemCount: appAppearanceProvider.appAppearanceList.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final ConstantSettings appearance =
                      appAppearanceProvider.appAppearanceList[index];

                  //Account's item view
                  return Consumer<AppAppearanceProvider>(
                    builder: (context, provider, child) {
                      return ListTile(
                        dense: true,
                        onTap: () => appAppearanceProvider.onAppAppearanceClick(
                            appearance, context),
                        leading: Image.asset(
                          appearance.leadingImage ?? "",
                          width: 22.0,
                          height: 22.0,
                          fit: BoxFit.cover,
                        ),
                        title: AppText(
                          appearance.title,
                          textColor: SDColors.whiteColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: sora,
                        ),
                        trailing:
                            provider.selectedAppearance.id == appearance.id
                                ? const Icon(
                                    Icons.check_circle,
                                    color: SDColors.whiteColor,
                                    size: 24.0,
                                  )
                                : const SizedBox.shrink(),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return divider();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
