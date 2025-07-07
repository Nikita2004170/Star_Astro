// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i27;
import 'package:flutter/material.dart' as _i28;
import 'package:star_astro/lib/provider/pdf/pdf_report_provider.dart' as _i29;
import 'package:star_astro/lib/screens/auth/continue_with_email.dart' as _i5;
import 'package:star_astro/lib/screens/auth/create_an_account.dart' as _i24;
import 'package:star_astro/lib/screens/auth/enter_password.dart' as _i10;
import 'package:star_astro/lib/screens/auth/forgot_password.dart' as _i11;
import 'package:star_astro/lib/screens/auth/sign_in_screen.dart' as _i23;
import 'package:star_astro/lib/screens/home/home_screen.dart' as _i12;
import 'package:star_astro/lib/screens/home/page/brahma_ai.dart' as _i3;
import 'package:star_astro/lib/screens/horoscope/daily_horoscope/daily_horoscope.dart'
    as _i7;
import 'package:star_astro/lib/screens/onboarding/onboarding.dart' as _i15;
import 'package:star_astro/lib/screens/onboarding/splash.dart' as _i25;
import 'package:star_astro/lib/screens/pdf/pdf_download.dart' as _i17;
import 'package:star_astro/lib/screens/pdf/pdf_report.dart' as _i18;
import 'package:star_astro/lib/screens/question/payment_success_screen.dart'
    as _i16;
import 'package:star_astro/lib/screens/question/question_bundle.dart' as _i20;
import 'package:star_astro/lib/screens/question/stripe_webview.dart' as _i26;
import 'package:star_astro/lib/screens/settings/additional_settings/additional_settings.dart'
    as _i1;
import 'package:star_astro/lib/screens/settings/additional_settings/app_appearance/app_appearance.dart'
    as _i2;
import 'package:star_astro/lib/screens/settings/additional_settings/delete_account/delete_account.dart'
    as _i8;
import 'package:star_astro/lib/screens/settings/additional_settings/languages/languages.dart'
    as _i13;
import 'package:star_astro/lib/screens/settings/credit/creadits.dart' as _i6;
import 'package:star_astro/lib/screens/settings/edit_profile/edit_profile.dart'
    as _i9;
import 'package:star_astro/lib/screens/settings/notifications/notification.dart'
    as _i14;
import 'package:star_astro/lib/screens/settings/purchase/purchase_screen.dart'
    as _i19;
import 'package:star_astro/lib/screens/settings/setting/settings.dart' as _i22;
import 'package:star_astro/lib/screens/settings/settings_refer/settings_refer.dart'
    as _i21;

/// generated route for
/// [_i1.AdditionalSettings]
class AdditionalSettings extends _i27.PageRouteInfo<void> {
  const AdditionalSettings({List<_i27.PageRouteInfo>? children})
      : super(AdditionalSettings.name, initialChildren: children);

  static const String name = 'AdditionalSettings';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i1.AdditionalSettings();
    },
  );
}

/// generated route for
/// [_i2.AppAppearanceScreen]
class AppAppearanceScreen extends _i27.PageRouteInfo<void> {
  const AppAppearanceScreen({List<_i27.PageRouteInfo>? children})
      : super(AppAppearanceScreen.name, initialChildren: children);

  static const String name = 'AppAppearanceScreen';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i2.AppAppearanceScreen();
    },
  );
}

/// generated route for
/// [_i3.BrahmaAiScreen]
class BrahmaAiScreen extends _i27.PageRouteInfo<BrahmaAiScreenArgs> {
  BrahmaAiScreen({
    _i28.Key? key,
    String? aiType,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          BrahmaAiScreen.name,
          args: BrahmaAiScreenArgs(key: key, aiType: aiType),
          initialChildren: children,
        );

  static const String name = 'BrahmaAiScreen';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BrahmaAiScreenArgs>(
        orElse: () => const BrahmaAiScreenArgs(),
      );
      return _i3.BrahmaAiScreen(key: args.key, aiType: args.aiType);
    },
  );
}

class BrahmaAiScreenArgs {
  const BrahmaAiScreenArgs({this.key, this.aiType});

  final _i28.Key? key;

  final String? aiType;

  @override
  String toString() {
    return 'BrahmaAiScreenArgs{key: $key, aiType: $aiType}';
  }
}

// /// generated route for
// /// [_i4.ChangePasswordScreen]
// class ChangePasswordScreen extends _i27.PageRouteInfo<void> {
//   const ChangePasswordScreen({List<_i27.PageRouteInfo>? children})
//       : super(ChangePasswordScreen.name, initialChildren: children);

//   static const String name = 'ChangePasswordScreen';

//   static _i27.PageInfo page = _i27.PageInfo(
//     name,
//     builder: (data) {
//       return const _i4.ChangePasswordScreen();
//     },
//   );
// }

/// generated route for
/// [_i5.ContinueWithEmail]
class ContinueWithEmail extends _i27.PageRouteInfo<void> {
  const ContinueWithEmail({List<_i27.PageRouteInfo>? children})
      : super(ContinueWithEmail.name, initialChildren: children);

  static const String name = 'ContinueWithEmail';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i5.ContinueWithEmail();
    },
  );
}

/// generated route for
/// [_i6.CreditsScreen]
class CreditsScreen extends _i27.PageRouteInfo<void> {
  const CreditsScreen({List<_i27.PageRouteInfo>? children})
      : super(CreditsScreen.name, initialChildren: children);

  static const String name = 'CreditsScreen';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i6.CreditsScreen();
    },
  );
}

/// generated route for
/// [_i7.DailyHoroscopeScreen]
class DailyHoroscopeScreen extends _i27.PageRouteInfo<void> {
  const DailyHoroscopeScreen({List<_i27.PageRouteInfo>? children})
      : super(DailyHoroscopeScreen.name, initialChildren: children);

  static const String name = 'DailyHoroscopeScreen';

  // static _i27.PageInfo page = _i27.PageInfo(
  //   name,
  //   builder: (data) {
  //     // return const _i7.DailyHoroscopeScreen();
  //   },
  // );
}

/// generated route for
/// [_i8.DeleteAccountScreen]
// class DeleteAccountScreen extends _i27.PageRouteInfo<void> {
//   const DeleteAccountScreen({List<_i27.PageRouteInfo>? children})
//       : super(DeleteAccountScreen.name, initialChildren: children);

//   static const String name = 'DeleteAccountScreen';

//   static _i27.PageInfo page = _i27.PageInfo(
//     name,
//     builder: (data) {
//       return const _i8.DeleteAccountScreen();
//     },
//   );
// }

/// generated route for
/// [_i9.EditProfileScreen]
class EditProfileScreen extends _i27.PageRouteInfo<EditProfileScreenArgs> {
  EditProfileScreen({
    _i28.Key? key,
    bool isFromLogin = false,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          EditProfileScreen.name,
          args: EditProfileScreenArgs(key: key, isFromLogin: isFromLogin),
          initialChildren: children,
        );

  static const String name = 'EditProfileScreen';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditProfileScreenArgs>(
        orElse: () => const EditProfileScreenArgs(),
      );
      return _i9.EditProfileScreen(
        key: args.key,
        isFromLogin: args.isFromLogin,
      );
    },
  );
}

class EditProfileScreenArgs {
  const EditProfileScreenArgs({this.key, this.isFromLogin = false});

  final _i28.Key? key;

  final bool isFromLogin;

  @override
  String toString() {
    return 'EditProfileScreenArgs{key: $key, isFromLogin: $isFromLogin}';
  }
}

/// generated route for
/// [_i10.EnterPasswordScreen]
class EnterPasswordScreen extends _i27.PageRouteInfo<EnterPasswordScreenArgs> {
  EnterPasswordScreen({
    _i28.Key? key,
    required String email,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          EnterPasswordScreen.name,
          args: EnterPasswordScreenArgs(key: key, email: email),
          initialChildren: children,
        );

  static const String name = 'EnterPasswordScreen';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EnterPasswordScreenArgs>();
      return _i10.EnterPasswordScreen(key: args.key, email: args.email);
    },
  );
}

class EnterPasswordScreenArgs {
  const EnterPasswordScreenArgs({this.key, required this.email});

  final _i28.Key? key;

  final String email;

  @override
  String toString() {
    return 'EnterPasswordScreenArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i11.ForgotPasswordScreen]
class ForgotPasswordScreen extends _i27.PageRouteInfo<void> {
  const ForgotPasswordScreen({List<_i27.PageRouteInfo>? children})
      : super(ForgotPasswordScreen.name, initialChildren: children);

  static const String name = 'ForgotPasswordScreen';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i11.ForgotPasswordScreen();
    },
  );
}

/// generated route for
/// [_i12.HomeScreen]
class HomeScreen extends _i27.PageRouteInfo<void> {
  const HomeScreen({List<_i27.PageRouteInfo>? children})
      : super(HomeScreen.name, initialChildren: children);

  static const String name = 'HomeScreen';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i12.HomeScreen();
    },
  );
}

/// generated route for
/// [_i13.LanguagesScreen]
class LanguagesScreen extends _i27.PageRouteInfo<void> {
  const LanguagesScreen({List<_i27.PageRouteInfo>? children})
      : super(LanguagesScreen.name, initialChildren: children);

  static const String name = 'LanguagesScreen';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i13.LanguagesScreen();
    },
  );
}

/// generated route for
/// [_i14.NotificationScreen]
class NotificationScreen extends _i27.PageRouteInfo<void> {
  const NotificationScreen({List<_i27.PageRouteInfo>? children})
      : super(NotificationScreen.name, initialChildren: children);

  static const String name = 'NotificationScreen';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i14.NotificationScreen();
    },
  );
}

/// generated route for
/// [_i15.OnboardingScreen]
class OnboardingScreen extends _i27.PageRouteInfo<void> {
  const OnboardingScreen({List<_i27.PageRouteInfo>? children})
      : super(OnboardingScreen.name, initialChildren: children);

  static const String name = 'OnboardingScreen';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i15.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i16.PaymentSuccessScreen]
class PaymentSuccessScreen extends _i27.PageRouteInfo<void> {
  const PaymentSuccessScreen({List<_i27.PageRouteInfo>? children})
      : super(PaymentSuccessScreen.name, initialChildren: children);

  static const String name = 'PaymentSuccessScreen';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i16.PaymentSuccessScreen();
    },
  );
}

/// generated route for
/// [_i17.PdfDownloadScreen]
class PdfDownloadScreen extends _i27.PageRouteInfo<PdfDownloadScreenArgs> {
  PdfDownloadScreen({
    _i28.Key? key,
    required _i29.PdfReportData pdfReportData,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          PdfDownloadScreen.name,
          args: PdfDownloadScreenArgs(key: key, pdfReportData: pdfReportData),
          initialChildren: children,
        );

  static const String name = 'PdfDownloadScreen';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PdfDownloadScreenArgs>();
      return _i17.PdfDownloadScreen(
        key: args.key,
        pdfReportData: args.pdfReportData,
      );
    },
  );
}

class PdfDownloadScreenArgs {
  const PdfDownloadScreenArgs({this.key, required this.pdfReportData});

  final _i28.Key? key;

  final _i29.PdfReportData pdfReportData;

  @override
  String toString() {
    return 'PdfDownloadScreenArgs{key: $key, pdfReportData: $pdfReportData}';
  }
}

/// generated route for
/// [_i18.PdfReportScreen]
class PdfReportScreen extends _i27.PageRouteInfo<void> {
  const PdfReportScreen({List<_i27.PageRouteInfo>? children})
      : super(PdfReportScreen.name, initialChildren: children);

  static const String name = 'PdfReportScreen';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i18.PdfReportScreen();
    },
  );
}

/// generated route for
/// [_i19.PurchaseScreen]
class PurchaseScreen extends _i27.PageRouteInfo<void> {
  const PurchaseScreen({List<_i27.PageRouteInfo>? children})
      : super(PurchaseScreen.name, initialChildren: children);

  static const String name = 'PurchaseScreen';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i19.PurchaseScreen();
    },
  );
}

/// generated route for
/// [_i20.QuestionBundleScreen]
class QuestionBundleScreen extends _i27.PageRouteInfo<void> {
  const QuestionBundleScreen({List<_i27.PageRouteInfo>? children})
      : super(QuestionBundleScreen.name, initialChildren: children);

  static const String name = 'QuestionBundleScreen';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i20.QuestionBundleScreen();
    },
  );
}

/// generated route for
/// [_i21.SettingsReferScreen]
class SettingsReferScreen extends _i27.PageRouteInfo<void> {
  const SettingsReferScreen({List<_i27.PageRouteInfo>? children})
      : super(SettingsReferScreen.name, initialChildren: children);

  static const String name = 'SettingsReferScreen';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i21.SettingsReferScreen();
    },
  );
}

/// generated route for
/// [_i22.SettingsScreen]
class SettingsScreen extends _i27.PageRouteInfo<void> {
  const SettingsScreen({List<_i27.PageRouteInfo>? children})
      : super(SettingsScreen.name, initialChildren: children);

  static const String name = 'SettingsScreen';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i22.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i23.SignInScreen]
class SignInScreen extends _i27.PageRouteInfo<void> {
  const SignInScreen({List<_i27.PageRouteInfo>? children})
      : super(SignInScreen.name, initialChildren: children);

  static const String name = 'SignInScreen';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i23.SignInScreen();
    },
  );
}

/// generated route for
/// [_i24.SignUpWithEmail]
class SignUpWithEmail extends _i27.PageRouteInfo<void> {
  const SignUpWithEmail({List<_i27.PageRouteInfo>? children})
      : super(SignUpWithEmail.name, initialChildren: children);

  static const String name = 'SignUpWithEmail';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i24.SignUpWithEmail();
    },
  );
}

/// generated route for
/// [_i25.SplashScreen]
class SplashScreen extends _i27.PageRouteInfo<void> {
  const SplashScreen({List<_i27.PageRouteInfo>? children})
      : super(SplashScreen.name, initialChildren: children);

  static const String name = 'SplashScreen';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i25.SplashScreen();
    },
  );
}

/// generated route for
/// [_i26.StripeWebView]
class StripeWebView extends _i27.PageRouteInfo<StripeWebViewArgs> {
  StripeWebView({
    _i28.Key? key,
    required String url,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          StripeWebView.name,
          args: StripeWebViewArgs(key: key, url: url),
          initialChildren: children,
        );

  static const String name = 'StripeWebView';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StripeWebViewArgs>();
      return _i26.StripeWebView(key: args.key, url: args.url);
    },
  );
}

class StripeWebViewArgs {
  const StripeWebViewArgs({this.key, required this.url});

  final _i28.Key? key;

  final String url;

  @override
  String toString() {
    return 'StripeWebViewArgs{key: $key, url: $url}';
  }
}
