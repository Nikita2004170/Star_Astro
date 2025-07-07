import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_astro/common/utils/api_constant.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/common/utils/styles.dart';
import 'package:star_astro/lib/screens/home/home_screen.dart';
import 'package:star_astro/lib/screens/onboarding/onboarding.dart';
import 'package:star_astro/widgets/app_scaffold.dart';
import 'package:star_astro/widgets/app_text.dart';
import '../../../common/utils/images.dart';
import '../../../di/di_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _moveAnimation;
  late Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();
    _checkLocation();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _moveAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.linearToEaseOut));

    _textFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.7, 0.9)),
    );

    Future.delayed(const Duration(seconds: 5), () {
      _redirectToDashboard();
    });
  }

  // _redirectToDashboard() async {
  //   final SharedPreferences preferences = getIt.get<SharedPreferences>();
  //   final loggedIn = isLoggedIn(preferences: preferences); // ✅ Use your helper

  //   if (loggedIn) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  //   } else {
  //     Navigator.push(context,
  //         MaterialPageRoute(builder: (context) => const OnboardingScreen()));
  //   }
  // }

  _redirectToDashboard() async {
    // if (isLoggedIn()) {
    final SharedPreferences preferences = getIt.get<SharedPreferences>();
    accessToken = preferences.getString("access_token");
    
    // bool isLogin = preferences.getBool("is_login") ?? false;
    if (accessToken != null) {
      // context.go('/edit-profile?isFromLogin=true');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => EditProfileScreen(
      //               isFromLogin: true,
      //             )));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
    }
    // }
    // else {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
    // }
  }

  Future<void> _checkLocation() async {
    // Check for permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Stack(
        children: [
          const AnimatedText(),
          FadeTransition(
            opacity: _textFadeAnimation,
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 50.0),
                child: AppText(
                  "World's 1st AI Astrologer",
                  textAlign: TextAlign.center,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  textColor: SDColors.settingsTextWhite,
                  fontFamily: sora,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedText extends StatefulWidget {
  const AnimatedText({super.key});

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _moveAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _moveAnimation = Tween<Offset>(
      begin: const Offset(0, 3),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.linearToEaseOut));

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _moveAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Images.appLogo,
                  height: 88,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Image.asset(
                    Images.appLogoText,
                    height: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
