import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:star_astro/common/utils/api_constant.dart';

import '../../../app_route.gr.dart';
import '../../../common/utils/common_function.dart';

class ForgotPasswordProvider with ChangeNotifier {
  TextEditingController yourEmail = TextEditingController();

  forgotPassword(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (yourEmail.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please Add Email");
      return;
    }
    if (!isValidEmail(yourEmail.text)) {
      Fluttertoast.showToast(msg: "Invalid Email");
      return;
    }

    await _forgotPasswordApi(context);
  }

  Future<void> _forgotPasswordApi(BuildContext context) async {
    try {
      const url = "$BASE_URL$apiForgotPassword";
      final bodyData = {"email": yourEmail.text.trim()};
      final apiResponse = await Dio().post(url, data: bodyData);
      if (apiResponse.data['status'] == "success") {
        context.router.pushAndPopUntil(
          const ContinueWithEmail(),
          predicate: (route) => false,
        );
        await Fluttertoast.showToast(msg: apiResponse.data['message']);
      }
    } on DioException catch (e) {
      await Fluttertoast.showToast(msg: e.response?.data['data']);
    } catch (e) {
      log(e.toString());
    }
  }
}
