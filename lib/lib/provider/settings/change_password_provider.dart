import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:star_astro/common/utils/common_function.dart';

import '../../../common/utils/api_constant.dart';

class ChangePasswordProvider with ChangeNotifier {
  TextEditingController oldPasswordCtrl = TextEditingController();
  TextEditingController newPasswordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();

  //Handle Obscure
  bool isOldObscure = true;
  bool isNewObscure = true;
  bool isConfirmObscure = true;

  //Api
  final Dio _dio = Dio();

  void onConfirmObscureClick() {
    isConfirmObscure = !isConfirmObscure;
    notifyListeners();
  }

  void onNewObscureClick() {
    isNewObscure = !isNewObscure;
    notifyListeners();
  }

  void onOldObscureClick() {
    isOldObscure = !isOldObscure;
    notifyListeners();
  }

  void onContinueClick(BuildContext context) {
    if (newPasswordCtrl.text.trim() != confirmPasswordCtrl.text.trim()) {
      Fluttertoast.showToast(msg: "Password Not Matched");
    } else {
      changePassword(context);
    }
  }

  Future<void> changePassword(BuildContext context) async {
    try {
      final bodyData = {
        "password": oldPasswordCtrl.text.trim(),
        "new_password": newPasswordCtrl.text.trim(),
      };

      final apiResponse = await _dio.post(
        "$BASE_URL$apiChangePassword",
        data: bodyData,
        options: getToken(),
      );
      if (apiResponse.statusCode == 200) {
        Navigator.pop(context);
        oldPasswordCtrl.clear();
        newPasswordCtrl.clear();
        confirmPasswordCtrl.clear();
        Fluttertoast.showToast(msg: apiResponse.data['message']);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        Fluttertoast.showToast(msg: e.response?.data['data']);
      }
      if (e.response?.statusCode == 401) {
        await refreshToken();
        await changePassword(context);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
