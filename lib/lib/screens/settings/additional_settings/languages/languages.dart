import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_astro/widgets/app_scaffold.dart';
import '../../../../../common/utils/app_string.dart';
import '../../../../../common/utils/common_widget.dart';
import '../../../../../common/utils/images.dart';
import '../../../../../widgets/settings_app_bar.dart';
import '../../../../models/const_settings.dart';
import '../../../../provider/settings/languages_provider.dart';
import '../../setting/items/item_view.dart';

@RoutePage()
class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({super.key});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: _buildLanguagesView(context),
    );
  }

  Widget _buildLanguagesView(BuildContext context) {
    final languagesProvider =
        Provider.of<LanguagesProvider>(context, listen: false);

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

        // Language Body View
        SafeArea(
          child: Column(
            children: [
              SettingsAppBar(
                title: AppString.languages.toUpperCase(),
                leadingIcon: Icons.arrow_back_ios,
              ),
              divider(
                height: 20.0,
              ),
              ListView.separated(
                itemCount: languagesProvider.languagesList.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final ConstantSettings language =
                      languagesProvider.languagesList[index];

                  //Account's item view
                  return SettingsAccountItemView(
                    setting: language,
                    isLanguage: true,
                    onItemClick: () => languagesProvider.onLanguageItemClick(
                        language, context),
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
