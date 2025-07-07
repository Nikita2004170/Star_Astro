import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_astro/lib/screens/auth/phone_entry_screen.dart';

import '../../../common/utils/api_constant.dart';
import '../../../common/utils/common_function.dart';
import '../../../common/utils/common_widget.dart';
import '../../../common/utils/enums.dart';
import '../../../di/di_services.dart';

class CreateAccountProvider with ChangeNotifier {
  final _dio = Dio();
  final SharedPreferences _preferences = getIt.get<SharedPreferences>();

  Future<void> onSignUpClick(
    BuildContext context, {
    String? email,
    String? password,
    String? promoCode,
    bool isAgreedToTerms = false,
  }) async {
    FocusScope.of(context).unfocus();
    if (email?.isEmpty ?? true) {
      Fluttertoast.showToast(msg: "Please Enter Email");
      return;
    }
    if (password?.isEmpty ?? true) {
      Fluttertoast.showToast(msg: "Please Enter Password");
      return;
    }
    if (!isValidEmail(email ?? "")) {
      Fluttertoast.showToast(msg: "Invalid Email.");
      return;
    }
    if (isAgreedToTerms) {
      try {
        await showProgressDialog(context);
        Map<String, dynamic> reqBody = {
          "email": email,
          "password": password,
          if (promoCode?.isNotEmpty ?? false) "referralCode": promoCode,
        };
        final apiResponse = await _dio.post(
          "$BASE_URL$apiCreateUser",
          data: reqBody,
        );
        Navigator.pop(context);
        if (apiResponse.data != null &&
            apiResponse.data['status'] == 'success') {
          await onSignInClick(
            context,
            email: email,
            password: password,
          );

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PhoneEntryScreen()));
        }
      } on DioException catch (e) {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: e.response?.data['data'] ?? "Something went wrong");
      } catch (e) {
        Navigator.pop(context);
        log('Login failed: $e');
        showCustomToast(
            text: 'Unexpected error occurred', toastType: ToastType.Error);
      }
    } else {
      Fluttertoast.showToast(msg: "You must agree to terms and conditions");
    }
  }

  Future<void> onSignInClick(BuildContext context,
      {String? email, String? password}) async {
    FocusScope.of(context).unfocus();
    Map<String, dynamic> reqBody = {
      "email": email,
      "password": password,
    };
    try {
      await showProgressDialog(context);
      const url = "$BASE_URL$apiLogin";
      final apiResponse = await _dio.post(url, data: reqBody);
      Navigator.pop(context);
      if (apiResponse.statusCode == 200) {
        accessToken = apiResponse.data?['data']['accessToken'] ?? "";
        _preferences.setString("access_token", accessToken!);
        _preferences.setBool("is_login", true);
        _preferences.setString(
            "refresh_token", apiResponse.headers["set-cookie"]?.first ?? "");
        _preferences.setBool("user_logged_in", true);
        // context.router.pushAndPopUntil(
        //   EditProfileScreen(isFromLogin: true),
        //   predicate: (route) => false,
        // );
        await Fluttertoast.showToast(msg: apiResponse.data['message']);
      } else {
        _preferences.remove("access_token");
        _preferences.remove("refresh_token");
        _preferences.setBool("user_logged_in", false);
        _preferences.setBool("is_login", false);
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: e.response?.data["data"]);
    } catch (e) {
      Navigator.pop(context);
    }
  }
}
