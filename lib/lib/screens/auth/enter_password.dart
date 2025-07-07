import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_astro/common/utils/app_string.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/common/utils/images.dart';
import 'package:star_astro/common/utils/styles.dart';
import 'package:star_astro/lib/screens/auth/forgot_password.dart';
import 'package:star_astro/widgets/app_gradiant_button.dart';
import 'package:star_astro/widgets/app_scaffold.dart';
import 'package:star_astro/widgets/app_text.dart';
import 'package:star_astro/widgets/edit_text.dart';

import '../../provider/auth/enter_password_provider.dart';

@RoutePage()
class EnterPasswordScreen extends StatefulWidget {
  const EnterPasswordScreen({super.key, required this.email});

  final String email;

  @override
  State<EnterPasswordScreen> createState() => _EnterPasswordScreenState();
}

class _EnterPasswordScreenState extends State<EnterPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EnterPasswordProvider>(context, listen: false);
    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 44, left: 118, right: 118),
            child: Image.asset(
              Images.appBarLogo,
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 32.0),
            child: AppText(
              'Enter Your Password',
              textColor: SDColors.whiteColor,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              fontFamily: sora,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Consumer<EnterPasswordProvider>(
              builder: (context, provider, child) {
                return AppTextField(
                  fillColor: SDColors.editProfileFill,
                  textColor: SDColors.settingsTextWhite,
                  cursorColor: SDColors.settingsTextWhite.withOpacity(0.5),
                  hintText: "Password",
                  obscureText: provider.isPasswordObscure,
                  suffixIcon: GestureDetector(
                    onTap: () => provider.onPasswordObscureClick(),
                    child: Icon(
                      provider.isPasswordObscure
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: SDColors.settingsTextWhite.withOpacity(0.5),
                    ),
                  ),
                  controller: passwordController,
                  hintColor: SDColors.settingsTextWhite.withOpacity(0.5),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: SDColors.settingsTextWhite.withOpacity(0.5),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: AppGradiantButton(
              // onTap: () {
              //   Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
              // },
              // onTap: () async => provider.onSignInClick(
              //   context,
              //   password: passwordController.text,
              //   email: widget.email,
              // ),
              onTap: () async {
                final password = passwordController.text.trim();

                if (password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password cannot be empty'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  return;
                }

                // final passwordRegex = RegExp(
                //     r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

                // if (!passwordRegex.hasMatch(password)) {
                //   // ScaffoldMessenger.of(OneContext.instance.key.currentContext!)
                //   // .showSnackBar(getSnackBar(
                //   //     'Password must be at least 8 characters long,\ninclude uppercase, lowercase, number, and special character.' ??
                //   //         StringResource.somethingWrong,
                //   //     isError: true));

                //   return;
                // }

                await provider.onSignInClick(
                  context,
                  password: password,
                  email: widget.email,
                );
              },

              title: AppString.continueBtn,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen()));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: AppText(
                    'Forgot Password?',
                    textColor: SDColors.forgotPassword,
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
