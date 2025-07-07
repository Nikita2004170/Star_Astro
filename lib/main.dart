import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_astro/common/utils/context_utility.dart';
import 'package:star_astro/common/utils/global.dart';
import 'package:star_astro/lib/provider/auth/create_account_provider.dart';
import 'package:star_astro/lib/provider/auth/enter_password_provider.dart';
import 'package:star_astro/lib/provider/auth/forgot_password_provider.dart';
import 'package:star_astro/lib/provider/auth/sign_in_provider.dart';
import 'package:star_astro/lib/provider/home/brahma_ai_provider.dart';
import 'package:star_astro/lib/provider/home/chat_provider.dart';
import 'package:star_astro/lib/provider/home/home_provider.dart';
import 'package:star_astro/lib/provider/horoscope/daily_horoscope_provider.dart';
import 'package:star_astro/lib/provider/onboarding_provider.dart';
import 'package:star_astro/lib/provider/pdf/pdf_detail_provider.dart';
import 'package:star_astro/lib/provider/pdf/pdf_download_provider.dart';
import 'package:star_astro/lib/provider/pdf/pdf_report_provider.dart';
import 'package:star_astro/lib/provider/question/question_bundle_provider.dart';
import 'package:star_astro/lib/provider/settings/additional_setting_provider.dart';
import 'package:star_astro/lib/provider/settings/edit_profile_provider.dart';
import 'package:star_astro/lib/provider/settings/settings_provider.dart';
import 'package:star_astro/lib/repository/base_repository.dart';
import 'package:star_astro/lib/repository/chat_repository.dart';
import 'package:star_astro/lib/repository/horoscope_repository.dart';
import 'package:star_astro/lib/repository/user_repository.dart';
import 'package:star_astro/lib/router.dart';
import 'firebase_options.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void setupLocator() {
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImp());
}

Future<void> setupDependencies() async {
  if (!getIt.isRegistered<SharedPreferences>()) {
    print('Registering SharedPreferences...');
    getIt.registerSingletonAsync<SharedPreferences>(
        () async => await SharedPreferences.getInstance());
  }
  if (!getIt.isRegistered<Connectivity>()) {
    print('Registering Connectivity...');
    getIt.registerSingleton<Connectivity>(Connectivity());
  }
  if (!getIt.isRegistered<Dio>()) {
    print('Registering Dio...');
    getIt.registerSingleton<Dio>(Dio());
  }
  if (!getIt.isRegistered<BaseRepository>()) {
    print('Registering BaseRepository...');
    getIt.registerSingleton<BaseRepository>(BaseRepository());
  }
  if (!getIt.isRegistered<ChatRepository>()) {
    print('Registering ChatRepository...');
    getIt.registerSingleton<ChatRepository>(ChatRepositoryImp());
  }
  if (!getIt.isRegistered<UserRepository>()) {
    print('Registering UserRepository...');
    getIt.registerSingleton<UserRepository>(UserRepositoryImp());
  }
  if (!getIt.isRegistered<HoroscopeRepository>()) {
    print('Registering HoroscopeRepository...');
    getIt.registerSingleton<HoroscopeRepository>(HoroscopeRepositoryImp());
  }
  if (!getIt.isRegistered<Logger>()) {
    print('Registering Logger...');
    getIt.registerLazySingleton<Logger>(() => Logger());
  }
  if (!getIt.isRegistered<SignInProvider>()) {
    print('Registering SignInProvider...');
    getIt.registerLazySingleton<SignInProvider>(() => SignInProvider());
  }
  print('Waiting for async dependencies...');
  await getIt.allReady();
  await UniServices.init();
  log("UniServices initialized");
  print('All dependencies ready');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("Token at startup: ${prefs.getString('access_token')}");
  await setupDependencies();

  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    log("Firebase initialized successfully");
    await FirebaseAnalytics.instance.logAppOpen();
    log("Firebase Analytics logged app open");
  } catch (e) {
    print("Firebase Init Error: $e");
  }

  await FirebaseMessaging.instance.requestPermission();

  // Wrap your app with Phoenix for restart capability
  runApp(Phoenix(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ContextUtility.setAppContext(navigatorKey.currentContext ?? context);
      log("ContextUtility.setAppContext called with navigatorKey");
    });
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignInProvider()),
        ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
        ChangeNotifierProvider(create: (_) => EnterPasswordProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => BrahmaAiProvider()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
        ChangeNotifierProvider(create: (_) => DailyHoroscopeProvider()),
        ChangeNotifierProvider(create: (_) => QuestionBundleProvider()),
        ChangeNotifierProvider(create: (_) => PdfDetailProvider()),
        ChangeNotifierProvider(create: (_) => PdfDownloadProvider()),
        ChangeNotifierProvider(create: (_) => PdfReportProvider()),
        ChangeNotifierProvider(create: (_) => CreateAccountProvider()),
        ChangeNotifierProvider(create: (_) => EditProfileProvider()),
        ChangeNotifierProvider(create: (_) => AdditionalSettingProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => GlobalProvider(null)),
      ],
      child: MaterialApp.router(
        title: 'Star Astro',
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
