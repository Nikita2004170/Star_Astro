// import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_astro/lib/screens/home/home_screen.dart';

// import '../../../app_route.gr.dart';
import '../../../common/utils/api_constant.dart';
import '../../../common/utils/common_widget.dart';
import '../../../di/di_services.dart';

class EnterPasswordProvider with ChangeNotifier {
  final SharedPreferences _preferences = getIt.get<SharedPreferences>();
  final _dio = Dio();
  bool isPasswordObscure = true;

  void onPasswordObscureClick() {
    isPasswordObscure = !isPasswordObscure;
    notifyListeners();
  }

  Future<void> onSignInClick(
    BuildContext context, {
    String? password,
    String? email,
  }) async {
    FocusScope.of(context).unfocus();
    if (password?.isNotEmpty ?? false) {
      Map<String, dynamic> reqBody = {
        "email": email?.trim() ?? "",
        "password": password,
      };
      try {
        await showProgressDialog(context);
        final apiResponse =
            await _dio.post("$BASE_URL$apiLogin", data: reqBody);
        Navigator.pop(context);
        print("Star astro login : $apiResponse");
        if (apiResponse.statusCode == 200) {
          accessToken = apiResponse.data?['data']['accessToken'] ?? "";
          _preferences.setString("access_token", accessToken!);
          _preferences.setString(
              "refresh_token", apiResponse.headers["set-cookie"]?.first ?? "");
          _preferences.setBool("user_logged_in", true);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));

          // context.pushNamed("home"
          //     // predicate: (route) => false,
          //     );
        } else {
          _preferences.remove("access_token");
          _preferences.remove("refresh_token");
          _preferences.remove("refresh_token");
          _preferences.setBool("user_logged_in", false);
        }
      } on DioException catch (e) {
        Navigator.pop(context);
        print("Star astro login : ${e.response}");

        Fluttertoast.showToast(msg: e.response?.data["data"] ?? "");
      } catch (e) {
        Navigator.pop(context);
      }
    } else {
      Fluttertoast.showToast(msg: "Please Add Password");
    }
  }
}
