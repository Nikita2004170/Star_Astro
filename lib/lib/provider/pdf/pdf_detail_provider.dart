import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:star_astro/common/utils/constanr_list.dart';

import '../../models/const_settings.dart';

class PdfDetailProvider with ChangeNotifier {
  //Gender Selection
  final List<ConstantSettings> genderList = ConstantList.genderList;
  ConstantSettings selectedGender = ConstantList.genderList.first;

  //Day Shift Selection
  final List<ConstantSettings> shiftList = ConstantList.shiftList;
  ConstantSettings selectedShift = ConstantList.shiftList.first;

  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();

  //Date Of Birth
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController monthCtrl = TextEditingController();
  TextEditingController yearCtrl = TextEditingController();

  //Time Of Birth
  TextEditingController hourCtrl = TextEditingController();
  TextEditingController minutesCtrl = TextEditingController();
  TextEditingController secondCtrl = TextEditingController();

  //Location
  TextEditingController locationCtrl = TextEditingController();

  bool isMySelf = false;

  //On Gender Value Change
  void onGenderChange(ConstantSettings? gender) {
    selectedGender = gender!;
    notifyListeners();
  }

  //On Shift Value Change
  void onShiftChange(ConstantSettings? gender) {
    selectedShift = gender!;
    notifyListeners();
  }

  onSaveChange(BuildContext context) {
    context.pushNamed('routeQuestionBundle');
  }

  onDetailChange() {
    isMySelf = !isMySelf;
    notifyListeners();
  }
}
