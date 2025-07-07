// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import 'package:star_astro/lib/provider/auth/sign_in_provider.dart';
// import 'package:star_astro/lib/provider/pdf/pdf_report_provider.dart';
// import 'package:star_astro/lib/screens/auth/continue_with_email.dart';
// import 'package:star_astro/lib/screens/auth/create_an_account.dart';
// import 'package:star_astro/lib/screens/auth/enter_password.dart';
// import 'package:star_astro/lib/screens/auth/forgot_password.dart';
// import 'package:star_astro/lib/screens/auth/sign_in_screen.dart'
//     show SignInScreen;
// import 'package:star_astro/lib/screens/home/page/brahma_ai.dart';
// import 'package:star_astro/lib/screens/horoscope/horoscope_selection_screen.dart';
// import 'package:star_astro/lib/screens/onboarding/onboarding.dart';
// import 'package:star_astro/lib/screens/onboarding/splash.dart';
// import 'package:star_astro/lib/screens/pdf/pdf_download.dart'
//     show PdfDownloadScreen;
// import 'package:star_astro/lib/screens/pdf/pdf_report.dart';
// import 'package:star_astro/lib/screens/question/payment_success_screen.dart'
//     show PaymentSuccessScreen;
// import 'package:star_astro/lib/screens/question/question_bundle.dart'
//     show QuestionBundleScreen;
// import 'package:star_astro/lib/screens/question/stripe_webview.dart';
// import 'package:star_astro/lib/screens/settings/additional_settings/additional_settings.dart';
// import 'package:star_astro/lib/screens/settings/additional_settings/app_appearance/app_appearance.dart'
//     show AppAppearanceScreen;
// import 'package:star_astro/lib/screens/settings/additional_settings/languages/languages.dart';
// import 'package:star_astro/lib/screens/settings/credit/creadits.dart';
// import 'package:star_astro/lib/screens/settings/edit_profile/edit_profile.dart';
// import 'package:star_astro/lib/screens/settings/notifications/notification.dart'
//     show NotificationScreen;
// import 'package:star_astro/lib/screens/settings/purchase/purchase_screen.dart';
// import 'package:star_astro/lib/screens/settings/setting/settings.dart';
// import 'package:star_astro/lib/screens/settings/settings_refer/settings_refer.dart';
// import 'package:star_astro/main.dart';
// import 'package:star_astro/lib/screens/home/home_screen.dart' as home_screen;
// import 'package:star_astro/lib/screens/home/page/home_page_view.dart'
//     as home_page;

// final GoRouter appRouter = GoRouter(
//   navigatorKey: navigatorKey,
//   initialLocation: '/',
//   routes: [
//     GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
//     GoRoute(
//         path: '/onboarding_screen',
//         builder: (_, __) => const OnboardingScreen()),
//     GoRoute(
//         path: '/home',
//         builder: (_, __) => home_page.HomePageView(
//               scrollController: ScrollController(),
//             )),
//     GoRoute(
//         path: '/settings_screen', builder: (_, __) => const SettingsScreen()),
//     GoRoute(path: '/credits_screen', builder: (_, __) => const CreditsScreen()),
//     GoRoute(
//         path: '/additional_settings',
//         builder: (_, __) => const AdditionalSettings()),
//     GoRoute(
//         path: '/purchase_screen', builder: (_, __) => const PurchaseScreen()),
//     GoRoute(
//         path: '/notification_screen',
//         builder: (_, __) => const NotificationScreen()),
//     GoRoute(
//         path: '/settings_refer_screen',
//         builder: (_, __) => const SettingsReferScreen()),
//     GoRoute(
//         path: '/languages_screen', builder: (_, __) => const LanguagesScreen()),
//     GoRoute(
//         path: '/app_appearance_screen',
//         builder: (_, __) => const AppAppearanceScreen()),
//     // GoRoute(
//     //     path: '/delete_account_screen',
//     //     builder: (_, __) => const DeleteAccountScreen()),

//     GoRoute(
//       name: 'edit_profile_screen',
//       path: '/edit_profile_screen',
//       builder: (_, state) {
//         final isFromLogin = state.uri.queryParameters['isFromLogin'] == 'true';
//         return EditProfileScreen(isFromLogin: isFromLogin);
//       },
//     ),

//     // GoRoute(
//     //     path: '/change_password_screen',
//     //     builder: (_, __) => const ChangePasswordScreen()),
//     GoRoute(
//         path: '/home_screen',
//         builder: (_, __) => const home_screen.HomeScreen()),
//     GoRoute(
//         path: '/pdf_report_screen',
//         builder: (_, __) => const PdfReportScreen()),

//     GoRoute(
//       path: '/pdf_download_screen',
//       builder: (context, state) {
//         final pdfReportData = state.extra as PdfReportData;
//         return PdfDownloadScreen(pdfReportData: pdfReportData);
//       },
//     ),

//     GoRoute(
//       path: '/success',
//       redirect: (context, state) async {
//         // Handle the deep link manually
//         final uri = state.uri;
//         if (uri.queryParameters.containsKey('accessToken')) {
//           final signInProvider =
//               Provider.of<SignInProvider>(context, listen: false);
//           await signInProvider.handleAuthCallback(
//             context,
//             uri.queryParameters['accessToken'],
//             uri.queryParameters['refreshToken'],
//           );
//           return '/home_screen'; // Redirect to home screen
//         }
//         return '/home_screen'; // Fallback
//       },
//     ),

//     // GoRoute(path: '/pdf_download_screen', builder: (_, __) =>  PdfDownloadScreen(pdfReportData: ,)),
//     GoRoute(
//         path: '/question_bundle_screen',
//         builder: (_, __) => const QuestionBundleScreen()),
//     GoRoute(
//         path: '/horoscope_selection_screen',
//         builder: (_, __) => const HoroscopeSelectionScreen()),
//     GoRoute(
//         path: '/payment_success_screen',
//         builder: (_, __) => const PaymentSuccessScreen()),
//     GoRoute(path: '/brahma_ai_screen', builder: (_, __) => BrahmaAiScreen()),
//     GoRoute(
//         path: '/stripe_web_view',
//         builder: (_, __) => StripeWebView(
//               url: '',
//             )),
//     GoRoute(
//         name: '/continue_with_email',
//         path: '/continue_with_email',
//         builder: (_, __) => const ContinueWithEmail()),
//     GoRoute(
//         path: '/forgot_password_screen',
//         builder: (_, __) => const ForgotPasswordScreen()),
//     GoRoute(
//         path: '/enter_password_screen',
//         builder: (_, __) => EnterPasswordScreen(
//               email: '',
//             )),
//     GoRoute(
//         path: '/sign_up_with_email_screen',
//         builder: (_, __) => const SignUpWithEmail()),
//     GoRoute(path: '/sign_in_screen', builder: (_, __) => const SignInScreen()),
//   ],
//   redirect: (context, state) async {
//     final uri = state.uri;
//     if (uri.host.contains('starastro.ai') && uri.path.contains('success')) {
//       return '/success'; // Redirect to success route for processing
//     }
//     return null;
//   },
// );
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:star_astro/lib/provider/auth/sign_in_provider.dart';
import 'package:star_astro/lib/provider/pdf/pdf_report_provider.dart';
import 'package:star_astro/lib/screens/auth/continue_with_email.dart';
import 'package:star_astro/lib/screens/auth/create_an_account.dart';
import 'package:star_astro/lib/screens/auth/enter_password.dart';
import 'package:star_astro/lib/screens/auth/forgot_password.dart';
import 'package:star_astro/lib/screens/auth/sign_in_screen.dart'
    show SignInScreen;
import 'package:star_astro/lib/screens/home/page/brahma_ai.dart';
import 'package:star_astro/lib/screens/horoscope/horoscope_selection_screen.dart';
import 'package:star_astro/lib/screens/onboarding/onboarding.dart';
import 'package:star_astro/lib/screens/onboarding/splash.dart';
import 'package:star_astro/lib/screens/pdf/pdf_download.dart'
    show PdfDownloadScreen;
import 'package:star_astro/lib/screens/pdf/pdf_report.dart';
import 'package:star_astro/lib/screens/question/payment_success_screen.dart'
    show PaymentSuccessScreen;
import 'package:star_astro/lib/screens/question/question_bundle.dart'
    show QuestionBundleScreen;
import 'package:star_astro/lib/screens/question/stripe_webview.dart';
import 'package:star_astro/lib/screens/settings/additional_settings/additional_settings.dart';
import 'package:star_astro/lib/screens/settings/additional_settings/app_appearance/app_appearance.dart'
    show AppAppearanceScreen;
import 'package:star_astro/lib/screens/settings/additional_settings/languages/languages.dart';
import 'package:star_astro/lib/screens/settings/credit/creadits.dart';
import 'package:star_astro/lib/screens/settings/edit_profile/edit_profile.dart';
import 'package:star_astro/lib/screens/settings/notifications/notification.dart'
    show NotificationScreen;
import 'package:star_astro/lib/screens/settings/purchase/purchase_screen.dart';
import 'package:star_astro/lib/screens/settings/setting/settings.dart';
import 'package:star_astro/lib/screens/settings/settings_refer/settings_refer.dart';
import 'package:star_astro/main.dart';
import 'package:star_astro/lib/screens/home/home_screen.dart' as home_screen;
import 'package:star_astro/lib/screens/home/page/home_page_view.dart'
    as home_page;

final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
    GoRoute(
        path: '/onboarding_screen',
        builder: (_, __) => const OnboardingScreen()),
    GoRoute(
        path: '/home',
        builder: (_, __) => home_page.HomePageView(
              scrollController: ScrollController(),
            )),
    GoRoute(
        path: '/settings_screen', builder: (_, __) => const SettingsScreen()),
    GoRoute(path: '/credits_screen', builder: (_, __) => const CreditsScreen()),
    GoRoute(
        path: '/additional_settings',
        builder: (_, __) => const AdditionalSettings()),
    GoRoute(
        path: '/purchase_screen', builder: (_, __) => const PurchaseScreen()),
    GoRoute(
        path: '/notification_screen',
        builder: (_, __) => const NotificationScreen()),
    GoRoute(
        path: '/settings_refer_screen',
        builder: (_, __) => const SettingsReferScreen()),
    GoRoute(
        path: '/languages_screen', builder: (_, __) => const LanguagesScreen()),
    GoRoute(
        path: '/app_appearance_screen',
        builder: (_, __) => const AppAppearanceScreen()),
    // GoRoute(
    //     path: '/delete_account_screen',
    //     builder: (_, __) => const DeleteAccountScreen()),

    GoRoute(
      name: 'edit_profile_screen',
      path: '/edit_profile_screen',
      builder: (_, state) {
        final isFromLogin = state.uri.queryParameters['isFromLogin'] == 'true';
        return EditProfileScreen(isFromLogin: isFromLogin);
      },
    ),

    // GoRoute(
    //     path: '/change_password_screen',
    //     builder: (_, __) => const ChangePasswordScreen()),
    GoRoute(
        path: '/home_screen',
        builder: (_, __) => const home_screen.HomeScreen()),
    GoRoute(
        path: '/pdf_report_screen',
        builder: (_, __) => const PdfReportScreen()),

    GoRoute(
      path: '/pdf_download_screen',
      builder: (context, state) {
        final pdfReportData = state.extra as PdfReportData;
        return PdfDownloadScreen(pdfReportData: pdfReportData);
      },
    ),

    GoRoute(
      path: '/success',
      redirect: (context, state) async {
        final uri = state.uri;
        if (uri.queryParameters.containsKey('accessToken')) {
          final signInProvider =
              Provider.of<SignInProvider>(context, listen: false);
          await signInProvider.handleAuthCallback(
            context,
            uri.queryParameters['accessToken'],
            // uri.queryParameters['refreshToken'],
          );
          return '/home_screen';
        }
        return '/home_screen';
      },
    ),

    // GoRoute(path: '/pdf_download_screen', builder: (_, __) =>  PdfDownloadScreen(pdfReportData: ,)),
    GoRoute(
        path: '/question_bundle_screen',
        builder: (_, __) => const QuestionBundleScreen()),
    GoRoute(
        path: '/horoscope_selection_screen',
        builder: (_, __) => const HoroscopeSelectionScreen()),
    GoRoute(
        path: '/payment_success_screen',
        builder: (_, __) => const PaymentSuccessScreen()),
    GoRoute(path: '/brahma_ai_screen', builder: (_, __) => BrahmaAiScreen()),
    GoRoute(
        path: '/stripe_web_view',
        builder: (_, __) => StripeWebView(
              url: '',
            )),
    GoRoute(
        name: '/continue_with_email',
        path: '/continue_with_email',
        builder: (_, __) => const ContinueWithEmail()),
    GoRoute(
        path: '/forgot_password_screen',
        builder: (_, __) => const ForgotPasswordScreen()),
    GoRoute(
        path: '/enter_password_screen',
        builder: (_, __) => EnterPasswordScreen(
              email: '',
            )),
    GoRoute(
        path: '/sign_up_with_email_screen',
        builder: (_, __) => const SignUpWithEmail()),
    GoRoute(path: '/sign_in_screen', builder: (_, __) => const SignInScreen()),
  ],
  redirect: (context, state) async {
    final uri = state.uri;
    // Accept both web and custom scheme deep links
    if ((uri.host.contains('starastro.ai') && uri.path.contains('success')) ||
        (uri.scheme == 'starastro' && uri.host == 'auth-callback')) {
      return '/success';
    }
    return null;
  },
);
