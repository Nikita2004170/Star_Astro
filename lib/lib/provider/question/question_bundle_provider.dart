
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import 'package:star_astro/common/utils/common_widget.dart';
import 'package:star_astro/common/utils/constanr_list.dart';
import 'package:star_astro/lib/models/plan_model.dart';
import '../../../common/utils/api_constant.dart';
import '../../../common/utils/common_function.dart';
import '../../models/const_settings.dart';
import '../../screens/question/widget/upi_mode_dialog.dart';

class QuestionBundleProvider with ChangeNotifier {
  final paymentMode = ConstantList.paymentMode;
  final upiModes = ConstantList.upiMode;

  onPaymentModeClick(BuildContext context, ConstantSettings constantSettings) {
    Navigator.pop(context);
    return switch (constantSettings.id) {
      1 => _upiDialog(context, constantSettings),
      2 => context.pushNamed('routePaymentSuccess'),
      3 => context.pushNamed('routePaymentSuccess'),
      _ => null,
    };
  }

  void _upiDialog(BuildContext context, ConstantSettings constantSettings) {
    return appDialog(
      context,
      title: constantSettings.title,
      widget: UpiModeDialog(
        upiModes: upiModes,
      ),
    );
  }

  //Api Calling
  List<PlanData> planDataList = [];

  Future<void> getPlans(BuildContext context) async {
    try {
      String url = "$dashboard$plans";

      // Make network call to get plans
      final response = await Dio().get(
        url,
        options: getToken(),
      );

      // Parse the response
      final data = PlanModel.fromJson(response.data);
      planDataList = data.data ?? [];
      planDataList
          .sort((a, b) => a.noOfCredit?.compareTo(b.noOfCredit ?? 0) ?? 0);
      notifyListeners();
    } on DioException catch (e) {
      // Log the error and show a proper message based on the error type
      String errorMessage = e.response != null
          ? "Failed to get plans: ${e.response?.statusMessage ?? 'Unknown error'}"
          : "Network error: ${e.message}";

      Fluttertoast.showToast(msg: errorMessage);
    } catch (e) {
      // Show a generic error message in the UI
      Fluttertoast.showToast(
          msg: "An unexpected error occurred. Please try again.");
    }
  }
}
