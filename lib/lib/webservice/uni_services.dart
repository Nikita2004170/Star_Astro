// // import 'dart:developer';

// // import 'package:flutter/services.dart';
// // import 'package:star_astro/common/utils/context_utility.dart';
// // import 'package:uni_links/uni_links.dart';

// // import '../../app_route.dart';
// // import '../../app_route.gr.dart';

// // class UniServices {
// //   static String _success = "";

// //   static String get success => _success;

// //   static bool get hasSuccess => _success.isNotEmpty;

// //   static void reset() => _success = "";

// //   static init() async {
// //     try {
// //       final Uri? uri = await getInitialUri();
// //       log("Initial URI: $uri"); // Log the URI for debugging
// //       uniHandler(uri);
// //     } on PlatformException catch (e) {
// //       log("Failed to received");
// //     } on FormatException catch (e) {
// //       log("Wrong format");
// //     } catch (e) {
// //       log("Unknown exception: $e");
// //     }

// //     uriLinkStream.listen((Uri? uri) async {
// //       log("URI Stream triggered with: $uri"); // Log when the stream receives a new URI
// //       uniHandler(uri);
// //     }, onError: (err) {
// //       log("On Unilink Error : $err");
// //     });
// //   }

// //   static uniHandler(Uri? uri) {
// //     if (uri == null || uri.queryParameters.isEmpty) return;

// //     Map<String, dynamic> params = uri.queryParameters;
// //     String? sessionId =
// //         params['session_id']; // Extracting session_id from the query parameters

// //     log("Unilink received success: $sessionId : ${ContextUtility.context}");

// //     if (sessionId != null) {
// //       log("Current routes: ${appRouter.stack}");
// //       appRouter.replace(const PaymentSuccessScreen());
// //     } else {
// //       log("Success parameter not true: $sessionId");
// //     }
// //   }
// // }

// // final AppRouter appRouter = AppRouter(); // Create an instance of your AppRouter
// import 'dart:developer';

// import 'package:flutter/services.dart';
// import 'package:star_astro/common/utils/context_utility.dart';
// import 'package:app_links/app_links.dart';

// import '../../app_route.dart';
// import '../../app_route.gr.dart';

// class UniServices {
//   static String _success = "";
//   static late AppLinks _appLinks;

//   static String get success => _success;

//   static bool get hasSuccess => _success.isNotEmpty;

//   static void reset() => _success = "";

//   static init() async {
//     _appLinks = AppLinks();

//     try {
//       final Uri? uri = await _appLinks.getInitialLink();
//       log("Initial URI: $uri"); // Log the URI for debugging
//       uniHandler(uri);
//     } on PlatformException catch (e) {
//       log("Failed to received");
//     } on FormatException catch (e) {
//       log("Wrong format");
//     } catch (e) {
//       log("Unknown exception: $e");
//     }

//     // Listen to incoming links when the app is already running
//     _appLinks.uriLinkStream.listen((Uri uri) async {
//       log("URI Stream triggered with: $uri"); // Log when the stream receives a new URI
//       uniHandler(uri);
//     }, onError: (err) {
//       log("On Unilink Error : $err");
//     });
//   }

//   static uniHandler(Uri? uri) {
//     if (uri == null || uri.queryParameters.isEmpty) return;

//     Map<String, dynamic> params = uri.queryParameters;
//     String? sessionId =
//         params['session_id']; // Extracting session_id from the query parameters

//     log("Unilink received success: $sessionId : ${ContextUtility.context}");

//     if (sessionId != null) {
//       log("Current routes: ${appRouter.stack}");
//       appRouter.replace(const PaymentSuccessScreen());
//     } else {
//       log("Success parameter not true: $sessionId");
//     }
//   }
// }

// final AppRouter appRouter = AppRouter(); // Create an instance of your AppRouter
