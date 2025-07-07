import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:star_astro/common/utils/app_string.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/common/utils/common_function.dart';
import 'package:star_astro/common/utils/images.dart';
import 'package:star_astro/common/utils/styles.dart';
import 'package:star_astro/lib/screens/auth/create_an_account.dart';
import 'package:star_astro/lib/screens/auth/enter_password.dart';
import 'package:star_astro/widgets/app_gradiant_button.dart';
import 'package:star_astro/widgets/app_scaffold.dart';
import 'package:star_astro/widgets/app_text.dart';
import 'package:star_astro/widgets/edit_text.dart';

// @RoutePage()
class ContinueWithEmail extends StatefulWidget {
  const ContinueWithEmail({super.key});

  @override
  State<ContinueWithEmail> createState() => _ContinueWithEmailState();
}

class _ContinueWithEmailState extends State<ContinueWithEmail> {
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      emailController.text = "user2@test.com";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(top: 44, left: 118, right: 118),
            child: Image.asset(
              Images.appBarLogo,
            ),
          ),
          const SizedBox(height: 72),
          const Padding(
            padding: EdgeInsets.only(left: 32),
            child: AppText(
              'Your Email Address',
              textColor: SDColors.whiteColor,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: sora,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: AppTextField(
              fillColor: SDColors.editProfileFill,
              hintText: "Username Or Email",
              textColor: SDColors.settingsTextWhite,
              controller: emailController,
              cursorColor: SDColors.settingsTextWhite.withOpacity(0.5),
              prefixIcon: Icon(
                Icons.email,
                color: SDColors.settingsTextWhite.withOpacity(0.5),
              ),
              hintColor: SDColors.settingsTextWhite.withOpacity(0.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: AppGradiantButton(
              onTap: () async {
                FocusScope.of(context).unfocus();
                if (emailController.text.isNotEmpty) {
                  if (isValidEmail(emailController.text)) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EnterPasswordScreen(
                                email: emailController.text)));
                  } else {
                    Fluttertoast.showToast(msg: "Invalid Email");
                  }
                } else {
                  Fluttertoast.showToast(msg: "Please Add Email Address");
                }
              },
              title: AppString.continueBtn,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: GestureDetector(
                child: RichText(
                  text: TextSpan(
                    text: 'New User? ',
                    style: const TextStyle(
                      color: SDColors.settingsTextWhite,
                      fontSize: 15,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Create An Account',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpWithEmail()));
                          },
                        style: const TextStyle(
                          color: SDColors.forgotPassword,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
