import 'package:flutter/cupertino.dart';

import '../../../common/utils/constanr_list.dart';
import '../../models/const_settings.dart';

class AppAppearanceProvider with ChangeNotifier {
  final appAppearanceList = ConstantList.appAppearanceList;
  ConstantSettings selectedAppearance = ConstantList.appAppearanceList.last;

  //On Appearance's item click navigation
  onAppAppearanceClick(ConstantSettings appearance, BuildContext context) {
    selectedAppearance = appearance;
    notifyListeners();

    //Change appearance logic
    return switch (appearance.id) {
      _ => null,
    };
  }
}
