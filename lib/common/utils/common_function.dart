import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:one_context/one_context.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_astro/common/utils/string.dart';
import 'package:star_astro/lib/models/base_model.dart';
import '../../di/di_services.dart';
import 'api_constant.dart';
import 'colors.dart';
import 'common_widget.dart';
import 'dimens.dart';
import 'enums.dart';

Logger logger = getIt.get<Logger>();

// bool isLoggedIn({SharedPreferences? preferences}) {
//   preferences ??= getIt.get<SharedPreferences>();
//   final accessToken = preferences.getString("access_token");
//   final isLoggedIn = preferences.getBool("user_logged_in") ?? false;
//   return accessToken != null && accessToken.isNotEmpty;
// }

bool isLoggedIn({SharedPreferences? preferences}) {
  preferences ??= getIt.get<SharedPreferences>();
  final accessToken = preferences.getString("access_token");
  final isUserLoggedIn = preferences.getBool("user_logged_in") ?? false;

  return isUserLoggedIn && accessToken != null && accessToken.isNotEmpty;
}

resetAllProvidersValue(BuildContext context) async {
  await clearAllPreferences();

  await resetProviders();

  context.go('/sign_in_screen');

  return Future.value(true);
}

// clearAllPreferences() async {
//   SharedPreferences preferences = getIt.get<SharedPreferences>();
//   await preferences.clear();
//   logger.i("Preferences cleared");

//   assert(
//       preferences.getString("access_token") == null); // Optional sanity check
//   assert(
//       preferences.getString("refresh_token") == null); // Optional sanity check
// }

clearAllPreferences() async {
  SharedPreferences preferences = getIt.get<SharedPreferences>();
  await preferences.clear();

  // Explicitly mark user as logged out
  await preferences.setBool("user_logged_in", false);

  logger.i("Preferences cleared");

  log("access_token after clear: ${preferences.getString("access_token")}");
  log("user_logged_in after clear: ${preferences.getBool("user_logged_in")}");
}

bool handleAPIResponse(BaseModel? response, Function successTransaction,
    {Function? onFailed, shouldShowError = true}) {
  if (response != null) {
    if (response.status ?? false) {
      successTransaction();
      return true;
    } else {
      if (onFailed != null) onFailed();
      if (!shouldShowError) return false;
      try {
        ScaffoldMessenger.of(OneContext.instance.key.currentContext!)
            .showSnackBar(getSnackBar(
                response.message ?? StringResource.somethingWrong,
                isError: true));
      } catch (e) {
        showCustomToast(
            text: response.message ?? StringResource.somethingWrong,
            toastType: ToastType.Error);
      }
      return false;
    }
  } else {
    if (onFailed != null) onFailed();
    if (!shouldShowError) return false;
    try {
      ScaffoldMessenger.of(OneContext.instance.key.currentContext!)
          .showSnackBar(
              getSnackBar(StringResource.somethingWrong, isError: true));
    } catch (e) {
      showCustomToast(
          text: response?.message ?? StringResource.somethingWrong,
          toastType: ToastType.Error);
    }
    return false;
  }
}

showCustomToast(
    {required String? text, ToastType toastType = ToastType.Success}) {
  Color backgroundColor;

  switch (toastType) {
    case ToastType.Success:
      backgroundColor = SDColors.primaryGreen;
      break;
    case ToastType.Error:
      backgroundColor = SDColors.alertRedColor;
      break;
  }
}

get getDivider => Container(
      height: 1,
      color: SDColors.textColor.withOpacity(.07),
    );

get spacingVerticalNormal => const SizedBox(
      height: Spacing.normal,
    );

get spacingVerticalXSmall => const SizedBox(
      height: Spacing.xSmall,
    );

get spacingVerticalXxSmall => const SizedBox(
      height: Spacing.xxSmall,
    );

get spacingVerticalXxxSmall => const SizedBox(
      height: Spacing.xxxSmall,
    );

get spacingHorizontalNormal => const SizedBox(
      width: Spacing.normal,
    );
refreshToken() async {
  try {
    final SharedPreferences preferences = getIt.get<SharedPreferences>();
    final refreshToken = preferences.getString("refresh_token");

    final isStillLoggedIn = preferences.getBool("user_logged_in") ?? false;
    if (!isStillLoggedIn) {
      log("Not logged in. Skipping refresh token.");
      return;
    }

    final response = await Dio().get(
      "$BASE_URL$apiUser",
      options: getToken(),
    );

    if (response.statusCode == 200 && response.data != null) {
      preferences.setString(
          "access_token", response.data['data']['accessToken']);
      accessToken = response.data['data']['accessToken'];
    } else {
      Navigator.of(OneContext.instance.key.currentContext!)
          .pushReplacementNamed('/sign_in_screen');
    }
  } catch (e) {
    Navigator.of(OneContext.instance.key.currentContext!)
        .pushReplacementNamed('/sign_in_screen');
    log("refreshToken error: $e");
  }
}

// refreshToken() async {
//   try {
//     final SharedPreferences preferences = getIt.get<SharedPreferences>();
//     var refreshToken = preferences.getString("refresh_token");
//     print("RefreshToken 3: $refreshToken");
//     final headers = {'Cookie': refreshToken};
//     final response = await Dio().get(
//       "$BASE_URL$apiUser",
//       options: getToken(),
//     );

//     if (response.statusCode == 200 && response.data != null) {
//       preferences.setString(
//           "access_token", response.data['data']['accessToken']);
//       accessToken = response.data['data']['accessToken'];
//     }
//   } catch (e) {
//     log(e.toString());
//   }
// }

double timeZone() {
  // Get the current time zone offset
  final Duration timeZoneOffset = DateTime.now().timeZoneOffset;

  // Convert the time zone offset to hours and minutes (as a fraction of an hour)
  final double timezone =
      timeZoneOffset.inHours + (timeZoneOffset.inMinutes % 60) / 60.0;

  // Return Timezone
  return timezone;
}

Options getToken() {
  print("getToken called");
  // 1. Get the SharedPreferences instance from your service locator
  final SharedPreferences prefs = getIt.get<SharedPreferences>();
  print("getToken prefs: ${prefs.getString('access_token')}");
  // 2. GET the latest token from phone storage. This is the critical step.
  final String? storedToken = prefs.getString("access_token");

  final Map<String, dynamic> headers = {};

  // 3. CHECK if the token exists and ADD it to the header with the "Bearer" prefix.
  //log( "Stored Token: $storedToken");
  if (storedToken != null && storedToken.isNotEmpty) {
    headers['Authorization'] = 'Bearer $storedToken';
  }
//log( "Headers: $headers");
  // 4. RETURN the options with the correct header
  return Options(headers: headers);
}

bool isValidEmail(String email) {
  String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  RegExp regex = RegExp(pattern);
  return regex.hasMatch(email);
}
