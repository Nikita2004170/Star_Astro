import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:one_context/one_context.dart';
import 'package:star_astro/common/utils/api_constant.dart';
import 'package:star_astro/common/utils/common_function.dart';
import 'package:star_astro/common/utils/context_utility.dart';
import 'package:star_astro/lib/models/get_chat_model.dart';
import 'package:star_astro/lib/models/post_chat_model.dart';
import 'package:star_astro/lib/screens/auth/sign_in_screen.dart';
import 'base_repository.dart';

abstract class ChatRepository {
  Future<GetChatModel> postChat(PostChatModel data, String endpoint);
}

class ChatRepositoryImp extends BaseRepository implements ChatRepository {
  @override
  Future<GetChatModel> postChat(PostChatModel data, String endpoint) async {
    var responseModel = GetChatModel();
    try {
      if (!await isConnected()) {
        responseModel.message = "No internet connection";
        return responseModel;
      }

      log(data.toString().toString());
      print("Payload: ${data.toJson()}");

      final response = await dio.post(
        "https://api.test.starastrogpt.com/chat/$endpoint",
        options: _barrier.copyWith(
          validateStatus: (status) => status != null && status < 500,
        ),
        data: data.toJson(),
      );

      print(response);

      print("https://api.test.starastrogpt.com/chat/$endpoint");
      print(data.toString());

      logger.log(Level.info, "Calling chat endpoint: $endpoint");

      log("response of chat: ${response.data}");

      final responseJson = returnResponse(response);
      responseModel = GetChatModel.fromJson(responseJson);
    } on DioException catch (e, t) {
      print(responseModel);
      if (e.error is SocketException) {
        responseModel.message = "Connectivity error";
      }
      log("DioError: ${e.toString()}");
      log("StackTrace: ${t.toString()}");
      returnResponseError(e);
      return responseModel;
    } on SocketException {
      responseModel.message = "Socket exception occurred";
    } catch (e, t) {
      final context =
          OneContext.instance.key.currentContext ?? ContextUtility.context;
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("Please Login Again"),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignInScreen(),
        ),
      );
      log("General error: ${e.toString()}");
      log("General error: ${t.toString()}");
    }

    return responseModel;
  }

  Options get _barrier {
    return Options(
      headers: {
        'Authorization': accessToken,
        'Content-Type': 'application/json',
      },
    );
  }
}

// class ChatRepositoryImp extends BaseRepository implements ChatRepository {
//   @override
//   Future<GetChatModel> postChat(PostChatModel data, String endpoint) async {
//     var responseModel = GetChatModel();
//     try {
//       if (!await isConnected()) {
//         responseModel.message = "No internet connection";
//         return responseModel;
//       }
//       final response = await dio.post(
//         "chat/${endpoint}",
//         options: _barrier,
//         data: data.toJson(),
//       );

//       log("response of chat: $response");
//       final responseJson = returnResponse(response);
//       responseModel = GetChatModel.fromJson(responseJson);
//     } on DioError catch (e, t) {
//       if (e.error is SocketException) {
//         responseModel.message = ".connectivityError";
//       }
//       log(e.toString());
//       log(t.toString());
//       returnResponseError(e);
//       return responseModel;
//     } on SocketException {
//       handleSocketException(
//         postChat,
//         null,
//         provider: Provider.of<DailyHoroscopeProvider>(
//           OneContext.instance.context!,
//           listen: false,
//         ),
//       );
//     } catch (e) {
//       log(e.toString());
//     }

//     return responseModel;
//   }

//   Options get _barrier {
//     return Options(
//       headers: {
//         'Authorization': accessToken,
//       },
//     );
//   }
// }
