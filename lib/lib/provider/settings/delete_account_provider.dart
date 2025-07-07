import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:star_astro/common/utils/api_constant.dart';

import '../../../app_route.gr.dart';
import '../../../common/utils/colors.dart';
import '../../../common/utils/common_function.dart';
import '../../../common/utils/common_widget.dart';
import '../../../widgets/app_gradiant_button.dart';
import '../../../widgets/app_text.dart';

class DeleteAccountProvider with ChangeNotifier {
  final passwordCtrl = TextEditingController();
  final _dio = Dio();

  onDeleteAccountClick(BuildContext context) async {
    appDialog(
      context,
      title: "Delete Account",
      widget: Column(
        children: [
          const AppText(
            "We're sorry to see you go! \n\nAre you sure you want to delete your account?",
            fontSize: 14.0,
            textColor: SDColors.whiteColor,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: AppGradiantButton(
                  title: "Okay",
                  gradiantColors: const [SDColors.appRed, SDColors.appRed],
                  onTap: () async {
                    Navigator.pop(context);
                    await clearAllPreferences();
                    deleteAccountApi(context);
                  },
                ),
              ),
              Expanded(
                child: AppGradiantButton(
                  title: "Cancel",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> deleteAccountApi(BuildContext context) async {
    try {
      showProgressDialog(context);
      final response = await _dio.delete(
        "$BASE_URL$apiUser",
        options: getToken(),
      );
      Navigator.pop(context);
      if (response.statusCode == 200) {
        context.router.pushAndPopUntil(
          const ContinueWithEmail(),
          predicate: (route) => false,
        );
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: e.response?.data["data"]);
    } catch (e) {
      Navigator.pop(context);
      log(e.toString());
      Fluttertoast.showToast(
          msg: "An unexpected error occurred. Please try again.");
    }
  }
}
