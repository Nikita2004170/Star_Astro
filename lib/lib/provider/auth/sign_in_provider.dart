import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_astro/common/utils/api_constant.dart';
import 'package:star_astro/common/utils/api_constant.dart' as AppConstants;
import 'package:star_astro/common/utils/common_function.dart';
import 'package:star_astro/common/utils/context_utility.dart';
import 'package:star_astro/common/utils/global.dart';
import 'package:star_astro/di/di_services.dart';
import 'package:star_astro/lib/models/user_model.dart';
import 'package:star_astro/lib/screens/home/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class UniServices {
  static String _success = "";
  static late AppLinks _appLinks;
  static StreamSubscription<Uri>? _linkSubscription;

  static String get success => _success;
  static bool get hasSuccess => _success.isNotEmpty;
  static void reset() => _success = "";

  static Future<void> init() async {
    _appLinks = AppLinks();

    try {
      final Uri? initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) await _uniHandler(initialUri);
    } catch (e) {
      log("Error getting initial link: $e");
    }

    _linkSubscription = _appLinks.uriLinkStream.listen((Uri uri) async {
      await _uniHandler(uri);
    }, onError: (err) {
      log("Deep link error: $err");
    });
  }

  static Future<void> _uniHandler(Uri? uri) async {
    if (uri == null) return;

    if (_isSuccessUrl(uri)) {
      await _handleAuthSuccess(uri);
    } else if (uri.path.contains('/payment') &&
        uri.queryParameters.containsKey('session_id')) {
      _handlePaymentCallback(uri);
    }
  }

  static bool _isSuccessUrl(Uri uri) {
    return uri.scheme == 'starastro' && uri.host == 'auth-callback';
  }

  static Future<void> _handleAuthSuccess(Uri uri) async {
    log("🌐 Full URI received: ${uri.toString()}");
    String? accessToken = uri.queryParameters['accessToken'];

    log('Parsed Access Token: $accessToken');

    if (accessToken != null && accessToken.isNotEmpty) {
      // Update global accessToken in AppConstants
      AppConstants.accessToken = accessToken;
      log("Updated AppConstants.accessToken: $accessToken");

      // Save token to SharedPreferences via SignInProvider
      final signInProvider = getIt.get<SignInProvider>();
      await signInProvider._saveAccessToken(accessToken);
      log("Access token saved to SharedPreferences");
    } else {
      log("No valid access token found in URI");
    }

    if (ContextUtility.context != null) {
      try {
        final signInProvider =
            Provider.of<SignInProvider>(ContextUtility.context!, listen: false);
        await signInProvider.handleAuthCallback(
            ContextUtility.context!, accessToken);
      } catch (e) {
        log("Error in SignInProvider: $e");
        _navigateToHome();
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (ContextUtility.context != null) {
          final signInProvider = Provider.of<SignInProvider>(
              ContextUtility.context!,
              listen: false);
          await signInProvider.handleAuthCallback(
              ContextUtility.context!, accessToken);
        } else {
          log("Context still unavailable, using fallback navigation");
          _navigateToHome();
        }
      });
    }
  }

  static void _navigateToHome() {
    if (ContextUtility.context != null) {
      try {
        GoRouter.of(ContextUtility.context!).go('/home_screen');
      } catch (e) {
        Navigator.of(ContextUtility.context!).push(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    }
  }

  static void _handlePaymentCallback(Uri uri) {
    final sessionId = uri.queryParameters['session_id'];
    if (sessionId != null && ContextUtility.context != null) {
      GoRouter.of(ContextUtility.context!).go('/payment_success_screen');
    }
  }

  static void dispose() {
    _linkSubscription?.cancel();
    _linkSubscription = null;
  }
}

class SignInProvider with ChangeNotifier {
  final SharedPreferences _preferences = getIt.get<SharedPreferences>();
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _navigateToHome(BuildContext context) {
    try {
      log("Navigating to HomeScreen");
      if (!context.mounted) {
        log('Error: Context not mounted for navigation');
        return;
      }
      Future.delayed(const Duration(milliseconds: 150));
      if (!context.mounted) {
        log('Error: Context became unmounted during delay');
        return;
      }
      final navigator = Navigator.of(context);

      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      } else {
        log('Error: Context not mounted for navigation');
      }
    } catch (e, stackTrace) {
      log('Navigation to HomeScreen failed: $e', stackTrace: stackTrace);
    }
  }

// 2. Improved OAuth flow with proper state handling
  Future<void> onGoogleSignInClick() async {
    try {
      _setLoading(true);
      _setError(null);

      // Clear any existing tokens before starting new auth
      await _clearAuthState();

      await _launchAuthURL();
    } catch (e) {
      _setError('Failed to launch Google Sign In: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _clearAuthState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token');
      await prefs.remove('refresh_token');
      await prefs.remove('user_data');
      // Clear any other auth-related data
    } catch (e) {
      log('Failed to clear auth state: $e');
    }
  }

  Future<void> _launchAuthURL() async {
    const url = '$BASE_URL$apiGoogle';
    final uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        final launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
        );

        if (!launched) {
          throw 'Failed to launch external browser';
        }
      } else {
        throw 'Cannot launch URL: $url';
      }
    } catch (e) {
      log('External launch failed, trying in-app: $e');

      // Fallback to in-app browser
      try {
        await launchUrl(
          uri,
          mode: LaunchMode.inAppWebView,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
        );
      } catch (fallbackError) {
        throw 'Could not launch $url: $fallbackError';
      }
    }
  }

  Future<void> handleAuthCallback(
      BuildContext context, String? accessToken) async {
    try {
      _setLoading(true);
      _setError(null);

      if (accessToken != null && accessToken.isNotEmpty) {
        log('Access token received, saving and getting user details');

        await _saveAccessToken(accessToken);
        bool success = false;
        int retryCount = 0;
        const maxRetries = 3;

        while (!success && retryCount < maxRetries) {
          try {
            await getUserDetail(context);
            success = true;
          } catch (e) {
            retryCount++;
            log('getUserDetail failed (attempt $retryCount): $e');

            if (retryCount < maxRetries) {
              await Future.delayed(Duration(seconds: retryCount * 2));
            } else {
              rethrow;
            }
          }
        }

        if (success) {
          log('Authentication successful, navigating to home');
          _navigateToHome(context);
        }
      } else {
        log('No access token received');
        _setError('Authentication failed: No access token received');
        _navigateToHome(context);
      }
    } catch (e) {
      log('Authentication error: $e');
      _setError('Authentication error: $e');
      _navigateToHome(context);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _saveAccessToken(String accessToken) async {
    await _preferences.setString("access_token", accessToken);
    await _preferences.setBool("user_logged_in", true);
    log("Access token saved successfully $accessToken");
  }

  Future<void> _clearTokens() async {
    await _preferences.remove("access_token");
    await _preferences.setBool("user_logged_in", false);
  }

  Future<void> getUserDetail(BuildContext context) async {
    log("Fetching user details...");
    try {
      final apiResponse = await Dio().get(
        "$BASE_URL$apiUser",
        options: getToken(),
      );

      if (apiResponse.data != null && apiResponse.data['status'] == 'success') {
        final data = UserModel.fromJson(apiResponse.data);
        if (data.data != null) {
          refreshUserModel(context, data.data!);
          notifyListeners();
          _navigateToHome(context); // Restart after user details are fetched
        } else {
          throw Exception('User data is null');
        }
      } else {
        throw Exception('Invalid response format or status');
      }
    } on DioException {
      await _clearTokens();
      _setError('Session expired. Please sign in again.');
      context.go('/sign_in_screen');
    } catch (e) {
      _setError('Failed to get user details: $e');
      _navigateToHome(context);
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      _setLoading(true);
      await _clearTokens();
      context.go('/sign_in_screen');
    } catch (e) {
      _setError('Error signing out: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> onEmailSignInClick(BuildContext context) async {
    try {
      context.push('/continue_with_email');
    } catch (e) {
      _setError('Navigation error: $e');
    }
  }

  Future<bool> checkExistingLogin() async {
    final isLoggedIn = _preferences.getBool("user_logged_in") ?? false;
    final token = _preferences.getString("access_token");
    return isLoggedIn && token != null && token.isNotEmpty;
  }
}
