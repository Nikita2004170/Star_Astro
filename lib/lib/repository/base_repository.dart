// import 'dart:convert';
// import 'dart:io';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:star_astro/app.dart';

// import '../../di/di_services.dart';

// class BaseRepository {
//   var connectivity = getIt.get<Connectivity>();
//   SharedPreferences preferences = getIt.get<SharedPreferences>();
//   final dio = getIt.get<Dio>();

//   isConnected() async {
//     return (await connectivity.checkConnectivity()) != ConnectivityResult.none;
//   }

//   dynamic returnResponse(Response response) {
//     switch (response.statusCode) {
//       case 200:
//       case 201:
//         return response.data;

//       default:
//         // BotToast.showText(text: response.statusMessage);
//         var responseJson = json.decode(response.toString());
//         return responseJson;
//     }
//   }

//   dynamic returnResponseError(DioError error) {
//     switch (error.response?.statusCode) {
//       case 200:
//       case 201:
//         var responseJson = json.decode(error.toString());
//         return responseJson;

//       default:
//         // BotToast.showText(text: error.response.statusMessage);
//         var responseJson = json.decode(error.toString());
//         return responseJson;
//     }
//   }

//   handleSocketException(Function functionTobeCalled, Map<String, dynamic>? body,
//       {ChangeNotifier? provider, shouldAddInList = true}) {
//     // if (shouldAddInList) {
//     //   StarAstro.listOfPendingFunctions.add(ConnectivityErrorModel(
//     //       function: functionTobeCalled, reqBody: body, provider: provider!));
//     // }
//     // SampleRouters().openNoInternetConnectionScreen();
//     throw const SocketException("no Internet");
//   }
// }

// class ConnectivityErrorModel {
//   Function? function;
//   Map<String, dynamic>? reqBody;
//   ChangeNotifier? provider;

//   ConnectivityErrorModel({this.function, this.reqBody, this.provider});

//   ConnectivityErrorModel.fromJson(Map<String, dynamic> json) {
//     function = json['function'];
//     reqBody = json['reqBody'];
//     provider = json['provider'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['function'] = function;
//     data['reqBody'] = reqBody;
//     data['provider'] = provider;
//     return data;
//   }
// }
// base_repository.dart
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../di/di_services.dart';

class BaseRepository {
  final Connectivity connectivity = getIt.get<Connectivity>();
  final Dio dio = getIt.get<Dio>();
  SharedPreferences? _preferences; // Nullable, initialized later

  BaseRepository();

  Future<SharedPreferences> getPreferences() async {
    _preferences ??= await getIt.getAsync<SharedPreferences>();
    return _preferences!;
  }

  Future<bool> isConnected() async {
    return (await connectivity.checkConnectivity()) != ConnectivityResult.none;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      default:
        var responseJson = json.decode(response.toString());
        return responseJson;
    }
  }

  dynamic returnResponseError(DioException error) {
    switch (error.response?.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(error.toString());
        return responseJson;
      default:
        var responseJson = json.decode(error.toString());
        return responseJson;
    }
  }

  handleSocketException(Function functionTobeCalled, Map<String, dynamic>? body,
      {ChangeNotifier? provider, shouldAddInList = true}) {
    throw const SocketException("no Internet");
  }
}

class ConnectivityErrorModel {
  Function? function;
  Map<String, dynamic>? reqBody;
  ChangeNotifier? provider;

  ConnectivityErrorModel({this.function, this.reqBody, this.provider});

  ConnectivityErrorModel.fromJson(Map<String, dynamic> json) {
    function = json['function'];
    reqBody = json['reqBody'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['function'] = function;
    data['reqBody'] = reqBody;
    data['provider'] = provider;
    return data;
  }
}
