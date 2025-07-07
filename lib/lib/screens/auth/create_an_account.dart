import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:star_astro/common/utils/app_string.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/common/utils/images.dart';
import 'package:star_astro/common/utils/styles.dart';
import 'package:star_astro/widgets/app_gradiant_button.dart';
import 'package:star_astro/widgets/app_scaffold.dart';
import 'package:star_astro/widgets/app_text.dart';
import 'package:star_astro/widgets/edit_text.dart';
import '../../provider/auth/create_account_provider.dart';

@RoutePage()
class SignUpWithEmail extends StatefulWidget {
  const SignUpWithEmail({super.key});

  @override
  State<SignUpWithEmail> createState() => _SignUpWithEmailState();
}

class _SignUpWithEmailState extends State<SignUpWithEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController promoCodeController = TextEditingController();

  bool _isPromoCodeVisible = false;
  bool _isAgreedToTerms = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    promoCodeController.dispose();
    super.dispose();
  }

  void togglePromoCodeVisibility() {
    setState(() {
      _isPromoCodeVisible = !_isPromoCodeVisible;
    });
  }

  void toggleTermsAgreement() {
    setState(() {
      _isAgreedToTerms = !_isAgreedToTerms;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    // At least 6 characters with 1 number, 1 letter
    final passwordRegex =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{6,}$');
    return passwordRegex.hasMatch(password);
  }

  void _onSignUpPressed(CreateAccountProvider provider) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("Email and password cannot be empty.");
      return;
    }

    if (!_isValidEmail(email)) {
      _showSnackBar("Please enter a valid email.");
      return;
    }

    if (!_isValidPassword(password)) {
      _showSnackBar(
          "Password must be at least 6 characters and contain a number.");
      return;
    }

    if (!_isAgreedToTerms) {
      _showSnackBar("Please agree to the terms and conditions.");
      return;
    }

    provider.onSignUpClick(
      context,
      email: email,
      password: password,
      promoCode: promoCodeController.text.trim(),
      isAgreedToTerms: _isAgreedToTerms,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CreateAccountProvider>(context, listen: false);

    return AppScaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 44, left: 118, right: 118),
                child: Image.asset(Images.appBarLogo),
              ),
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.only(left: 32),
                child: AppText(
                  'Create New Account',
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
                  hintText: "Username or email",
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
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: AppTextField(
                  fillColor: SDColors.editProfileFill,
                  textColor: SDColors.settingsTextWhite,
                  cursorColor: SDColors.settingsTextWhite.withOpacity(0.5),
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController,
                  hintColor: SDColors.settingsTextWhite.withOpacity(0.5),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: SDColors.settingsTextWhite.withOpacity(0.5),
                  ),
                ),
              ),
              _isPromoCodeVisible
                  ? Padding(
                      padding:
                          const EdgeInsets.only(left: 32.0, right: 32, top: 16),
                      child: AppTextField(
                        fillColor: SDColors.editProfileFill,
                        hintText: "Enter Promo Code",
                        textColor: SDColors.settingsTextWhite,
                        controller: promoCodeController,
                        cursorColor:
                            SDColors.settingsTextWhite.withOpacity(0.5),
                        prefixIcon: Icon(
                          HeroIcons.gift,
                          size: 22,
                          color: SDColors.settingsTextWhite.withOpacity(0.5),
                        ),
                        hintColor: SDColors.settingsTextWhite.withOpacity(0.5),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: GestureDetector(
                        onTap: togglePromoCodeVisibility,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: AppText(
                            'I Have A Promo Code',
                            textColor: SDColors.forgotPassword,
                          ),
                        ),
                      ),
                    ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: AppGradiantButton(
                  onTap: () => _onSignUpPressed(provider),
                  title: AppString.continueBtn,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _isAgreedToTerms,
                    onChanged: (value) => toggleTermsAgreement(),
                    side: const BorderSide(
                        color: SDColors.forgotPassword, width: 2),
                    activeColor: SDColors.forgotPassword,
                  ),
                  GestureDetector(
                    onTap: toggleTermsAgreement,
                    child: const AppText(
                      'I Agree To Terms & Conditions',
                      textColor: SDColors.settingsTextWhite,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 14),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: GestureDetector(
                    onTap: () => context.push('/continue_with_email'),
                    child: RichText(
                      text: const TextSpan(
                        text: 'Already Have an Account? ',
                        style: TextStyle(
                          color: SDColors.settingsTextWhite,
                          fontSize: 15,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
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
        ),
      ),
    );
  }
}
