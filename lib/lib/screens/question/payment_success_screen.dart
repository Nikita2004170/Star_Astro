import 'dart:async';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:star_astro/common/utils/app_string.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/widgets/app_scaffold.dart';
import 'package:star_astro/widgets/app_text.dart';
import '../../../common/utils/images.dart';
import '../../../common/utils/styles.dart';

@RoutePage()
class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      _redirectBack();
    });
  }

  void _redirectBack() async {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: _buildPaymentSuccessView(context),
    );
  }

  Widget _buildPaymentSuccessView(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image
        Positioned.fill(
          child: Image.asset(
            Images.bgImage,
            fit: BoxFit.cover,
          ),
        ),

        // Settings Refer & Earn Body View
        SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: SDColors.whiteColor,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.success,
                      height: 150.0,
                      width: 150.0,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const AppText(
                      AppString.congratulations,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      fontFamily: sora,
                      textColor: SDColors.whiteColor,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    const AppText(
                      "You have successfully purchased X questions",
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                      fontFamily: sora,
                      textColor: SDColors.whiteColor,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
