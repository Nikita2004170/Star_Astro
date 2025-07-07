// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:firebase_performance/firebase_performance.dart';
// import 'package:logger/logger.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:bot_toast/bot_toast.dart';
// import 'package:star_astro/common/utils/api_constant.dart';

// import '../../app_route.dart';
// import '../../common/utils/common_function.dart';
// import '../../di/di_services.dart';
// import 'api_constants.dart';

// class DioSettings {
//   late Dio dio;
//   late Logger logger;
//   late SharedPreferences preferences;

//   final _map = <int, HttpMetric>{};
//   final _appRouter = getIt.get<AppRouter>();

//   DioSettings(
//       {required this.dio, required this.logger, required this.preferences}) {
//     initDioSettings();
//   }

//   initDioSettings() {
//     dio.options = BaseOptions(baseUrl: BASE_URL);
//     dio.interceptors.add(
//       LogInterceptor(
//         requestHeader: true,
//         responseHeader: true,
//         request: true,
//         requestBody: true,
//         responseBody: true,
//       ),
//     );

//     dio.interceptors.add(InterceptorsWrapper(onRequest: (
//       RequestOptions options,
//       RequestInterceptorHandler handler,
//     ) async {
//       try {
//         final metric = FirebasePerformance.instance.newHttpMetric(
//             options.uri.normalized(), options.method.asHttpMethod()!);

//         final requestKey = options.extra.hashCode;
//         _map[requestKey] = metric;

//         final requestContentLength = defaultRequestContentLength(options);
//         await metric.start();
//         metric.requestPayloadSize = requestContentLength;
//       } catch (_) {}

//       if (options.method == "GET") {
//         logger.d("Request",
//             error: "Path -> ${_appRouter.current.path} \n${options.method} -> ${options.path} -> ${json.encode(options.queryParameters)}");
//       } else {
//         logger.d("Request",
//             error: "Path -> ${_appRouter.current.name} \n${options.method} -> ${options.path} -> ${options.data is FormData ? (options.data as FormData).fields : options.data.toString()}");
//       }

//       return handler.next(options); //continue
//     }, onResponse: (
//       Response response,
//       ResponseInterceptorHandler handler,
//     ) async {
//       try {
//         final requestKey = response.requestOptions.extra.hashCode;
//         final metric = _map[requestKey];
//         metric?.setResponse(response, defaultResponseContentLength);
//         await metric?.stop();
//         _map.remove(requestKey);
//       } catch (_) {}

//       logger.d("Response",
//           error: "Path -> ${_appRouter.current.name} \n${response.data.toString()}");
//       return handler.next(response); // continue
//     }, onError: (
//       DioException e,
//       ErrorInterceptorHandler handler,
//     ) async {
//       try {
//         final requestKey = e.requestOptions.extra.hashCode;
//         final metric = _map[requestKey];
//         metric?.setResponse(e.response!, defaultResponseContentLength);
//         await metric?.stop();
//         _map.remove(requestKey);
//       } catch (_) {}

//       if (e.response?.statusCode == CODE_UNAUTHORISED) {
//         //Initiate the logout process.
//         final _appRouter = getIt.get<AppRouter>();
//         BotToast.showText(text: e.response?.data['message']);
//         resetAllProvidersValue(_appRouter.navigatorKey.currentContext!);
//       }
//       logger.e("Error", error: e.message);
//       return handler.next(e); //continue
//     }));
//   }

//   ///Helper Methods

//   Future<Map<String, dynamic>> header(
//       {contentType = "application/json"}) async {
//     Map<String, dynamic> header = {};
//     return header;
//   }

//   Object authHeader({contentType = "application/json"}) {
//     try {
//       // var userToken = preferences.getString(PREF_USER_TOKEN);
//       // logger.log(Logger.level, "User token: $userToken");

//       Map<String, dynamic> header = {};
//       return header;
//     } catch (e) {
//       return header(contentType: "application/json");
//     }
//   }
// }

// extension _UriHttpMethod on Uri {
//   String normalized() {
//     return "$scheme://$host$path";
//   }
// }

// extension _StringHttpMethod on String {
//   HttpMethod? asHttpMethod() {
//     switch (toUpperCase()) {
//       case "POST":
//         return HttpMethod.Post;
//       case "GET":
//         return HttpMethod.Get;
//       case "DELETE":
//         return HttpMethod.Delete;
//       case "PUT":
//         return HttpMethod.Put;
//       case "PATCH":
//         return HttpMethod.Patch;
//       case "OPTIONS":
//         return HttpMethod.Options;
//       default:
//         return null;
//     }
//   }
// }

// extension _ResponseHttpMetric on HttpMetric {
//   void setResponse(
//       Response value, ResponseContentLengthMethod responseContentLengthMethod) {
//     final responseContentLength = responseContentLengthMethod(value);
//     responsePayloadSize = responseContentLength;
//     final contentType = value.headers.value.call(Headers.contentTypeHeader);
//     if (contentType != null) {
//       responseContentType = contentType;
//     }
//     if (value.statusCode != null) {
//       httpResponseCode = value.statusCode;
//     }
//   }
// }

// typedef ResponseContentLengthMethod = int Function(Response options);

// int defaultResponseContentLength(Response response) {
//   if (response.data is String) {
//     return (response.headers.toString().length) + response.data?.length as int;
//   } else {
//     return 0;
//   }
// }

// typedef RequestContentLengthMethod = int Function(RequestOptions options);

// int defaultRequestContentLength(RequestOptions options) {
//   try {
//     if (options.data is String || options.data is Map) {
//       return options.headers.toString().length +
//           (options.data?.toString().length ?? 0);
//     }
//   } catch (_) {
//     return 0;
//   }
//   return 0;
// }
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bot_toast/bot_toast.dart';

import 'package:star_astro/common/utils/api_constant.dart';
import 'package:star_astro/lib/webservice/api_constants.dart';
import '../../common/utils/common_function.dart';
import '../../main.dart'; // assuming navigatorKey is defined here

class DioSettings {
  late Dio dio;
  late Logger logger;
  late SharedPreferences preferences;

  final _map = <int, HttpMetric>{};

  DioSettings({
    required this.dio,
    required this.logger,
    required this.preferences,
  }) {
    initDioSettings();
  }

  void initDioSettings() {
    dio.options = BaseOptions(baseUrl: BASE_URL);

    dio.interceptors.add(
      LogInterceptor(
        requestHeader: true,
        responseHeader: true,
        request: true,
        requestBody: true,
        responseBody: true,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            final metric = FirebasePerformance.instance.newHttpMetric(
              options.uri.normalized(),
              options.method.asHttpMethod()!,
            );

            final requestKey = options.extra.hashCode;
            _map[requestKey] = metric;

            final requestContentLength = defaultRequestContentLength(options);
            await metric.start();
            metric.requestPayloadSize = requestContentLength;
          } catch (_) {}

          logger.d(
            "Request",
            error:
                "${options.method} -> ${options.path} -> ${options.method == "GET" ? json.encode(options.queryParameters) : options.data is FormData ? (options.data as FormData).fields : options.data.toString()}",
          );

          return handler.next(options);
        },
        onResponse: (response, handler) async {
          try {
            final requestKey = response.requestOptions.extra.hashCode;
            final metric = _map[requestKey];
            metric?.setResponse(response, defaultResponseContentLength);
            await metric?.stop();
            _map.remove(requestKey);
          } catch (_) {}

          logger.d(
            "Response",
            error:
                "${response.requestOptions.method} -> ${response.requestOptions.path} -> ${response.data.toString()}",
          );
          return handler.next(response);
        },
        onError: (e, handler) async {
          try {
            final requestKey = e.requestOptions.extra.hashCode;
            final metric = _map[requestKey];
            metric?.setResponse(e.response!, defaultResponseContentLength);
            await metric?.stop();
            _map.remove(requestKey);
          } catch (_) {}

          if (e.response?.statusCode == CODE_UNAUTHORISED) {
            BotToast.showText(text: e.response?.data['message'] ?? "Unauthorized");
            final context = navigatorKey.currentContext;
            if (context != null) {
              resetAllProvidersValue(context);
            }
          }

          logger.e("Error", error: e.message);
          return handler.next(e);
        },
      ),
    );
  }

  Future<Map<String, dynamic>> header({
    contentType = "application/json",
  }) async {
    return {};
  }

  Object authHeader({contentType = "application/json"}) {
    try {
      return {};
    } catch (_) {
      return header(contentType: "application/json");
    }
  }
}

extension _UriHttpMethod on Uri {
  String normalized() {
    return "$scheme://$host$path";
  }
}

extension _StringHttpMethod on String {
  HttpMethod? asHttpMethod() {
    switch (toUpperCase()) {
      case "POST":
        return HttpMethod.Post;
      case "GET":
        return HttpMethod.Get;
      case "DELETE":
        return HttpMethod.Delete;
      case "PUT":
        return HttpMethod.Put;
      case "PATCH":
        return HttpMethod.Patch;
      case "OPTIONS":
        return HttpMethod.Options;
      default:
        return null;
    }
  }
}

extension _ResponseHttpMetric on HttpMetric {
  void setResponse(
    Response value,
    ResponseContentLengthMethod responseContentLengthMethod,
  ) {
    final responseContentLength = responseContentLengthMethod(value);
    responsePayloadSize = responseContentLength;
    final contentType = value.headers.value(Headers.contentTypeHeader);
    if (contentType != null) {
      responseContentType = contentType;
    }
    if (value.statusCode != null) {
      httpResponseCode = value.statusCode!;
    }
  }
}

typedef ResponseContentLengthMethod = int Function(Response options);

int defaultResponseContentLength(Response response) {
  if (response.data is String) {
    return ((response.headers.toString().length) + (response.data?.length ?? 0)).toInt();
  } else {
    return 0;
  }
}

typedef RequestContentLengthMethod = int Function(RequestOptions options);

int defaultRequestContentLength(RequestOptions options) {
  try {
    if (options.data is String || options.data is Map) {
      return options.headers.toString().length +
          (options.data?.toString().length ?? 0);
    }
  } catch (_) {
    return 0;
  }
  return 0;
}
