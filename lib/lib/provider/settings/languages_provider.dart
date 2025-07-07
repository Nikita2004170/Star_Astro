import 'package:flutter/cupertino.dart';
import 'package:star_astro/common/utils/constanr_list.dart';

import '../../models/const_settings.dart';

class LanguagesProvider with ChangeNotifier {
  final languagesList = ConstantList.languagesList;

  //On Language's item click navigation
  onLanguageItemClick(ConstantSettings language, BuildContext context) {}
}
