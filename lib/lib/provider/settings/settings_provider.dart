import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_astro/common/utils/constanr_list.dart';

import '../../models/const_settings.dart';

class SettingsProvider with ChangeNotifier {
  final accountSettingsList = ConstantList.accountSettingsList;

  void onEditClick(BuildContext context) {
    context.push('/edit_profile_screen?isFromLogin=false');
  }

  //On account's item click navigation
  onAccountItemClick(ConstantSettings setting, BuildContext context) {
    return switch (setting.id) {
      1 => context.push('/purchase_screen'),
      2 => context.push('/purchase_screen'),
      3 => context.push('/notification_screen'),
      4 => context.push('/settings_refer_screen'),
      5 => context.push('/additional_settings'),
      _ => null,
    };
  }
}
