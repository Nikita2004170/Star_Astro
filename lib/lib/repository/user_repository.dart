import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:one_context/one_context.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_astro/common/utils/api_constant.dart';
import 'package:star_astro/lib/provider/home/home_provider.dart';
import 'package:star_astro/lib/provider/settings/edit_profile_provider.dart';

import '../../common/utils/common_function.dart';
import '../../di/di_services.dart';
import '../models/access_token_model.dart';
import '../models/palces_model.dart';
import '../models/update_user_model.dart';
import 'base_repository.dart';

abstract class UserRepository {
  Future<UpdateUserModel?> editUserDetail(Map<String, dynamic> reqBody);

  Future<AccessTokenModel> getAccessToken();

  Future<PlacesModel?> getPlaces(Map<String, dynamic> queryParams);
}

class UserRepositoryImp extends BaseRepository implements UserRepository {
  @override
  @override
  Future<UpdateUserModel> editUserDetail(Map<String, dynamic> reqBody) async {
    var responseModel = UpdateUserModel();
    try {
      if (!await isConnected()) throw const SocketException("noInternet");

      // 🔍 LOGGING: request data
      log("[UserRepository] PUT $apiUser");
      log("[UserRepository] Request Body: ${reqBody.toString()}");

      final response = await dio.put(
        "https://api.test.starastrogpt.com/user",
        data: reqBody,
        options: getToken(),
      );

      // 🔍 LOGGING: raw response
      log("[UserRepository] Response Status: ${response.statusCode}");
      log("[UserRepository] Response Data: ${response.data}");
      log("[UserRepository] Response Data: $Options");

      final responseJson = returnResponse(response);
      responseModel = UpdateUserModel.fromJson(responseJson);

      // 🔍 LOGGING: parsed model
      log("[UserRepository] Parsed UpdateUserModel: ${responseModel.toJson()}");

      // Update the EditProfileProvider with new user data so UI reflects changes immediately
      final context = OneContext.instance.context;
      if (context != null) {
        final editProfileProvider =
            Provider.of<EditProfileProvider>(context, listen: false);
        editProfileProvider.updateUser(
            responseModel.data); // Implement this method in your provider
      }

      return responseModel;
    } on DioException catch (e) {
      // 🔍 LOGGING: error
      log("[UserRepository] DioError: ${e.message}");
      log("[UserRepository] DioError Response: ${e.response?.data}");

      //Fluttertoast.showToast(msg: e.response?.data['data'] ?? "");

      if (e.error is SocketException) {
        responseModel.message = ".connectivityError";
      }

      returnResponseError(e);
      return responseModel;
    } on SocketException {
      log("[UserRepository] SocketException: No internet");

      handleSocketException(
        editUserDetail,
        reqBody,
        provider: Provider.of<EditProfileProvider>(
          OneContext.instance.context!,
          listen: false,
        ),
      );
    } catch (e) {
      log("[UserRepository] Unknown Error: $e");
      // Fluttertoast.showToast(msg: e.toString());
    }

    return responseModel;
  }

  @override
  Future<AccessTokenModel> getAccessToken() async {
    var responseModel = AccessTokenModel();
    try {
      if (!await isConnected()) throw const SocketException("noInternet");
      final SharedPreferences preferences = getIt.get<SharedPreferences>();
      var refreshToken = preferences.getString("refresh_token");
      final headers = {'Cookie': refreshToken};
      final response =
          await dio.get(apiUser, options: Options(headers: headers));

      final responseJson = returnResponse(response);
      responseModel = AccessTokenModel.fromJson(responseJson);
      if (responseModel.status == "success") {
        accessToken = responseModel.data?.accessToken ?? "";
      }
      return responseModel;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        responseModel.message = ".connectivityError";
      }
      returnResponseError(e);
      return responseModel;
    } on SocketException {
      handleSocketException(getAccessToken, null,
          provider: Provider.of<HomeProvider>(OneContext.instance.context!,
              listen: false));
    } catch (e) {
      log(e.toString());
    }

    return responseModel;
  }

  @override
  Future<PlacesModel> getPlaces(Map<String, dynamic> queryParams) async {
    var responseModel = PlacesModel();
    try {
      if (!await isConnected()) throw const SocketException("noInternet");
      final response = await Dio()
          .get(searchPlaces, options: getToken(), queryParameters: queryParams);

      log(queryParams.toString());

      final responseJson = returnResponse(response);
      responseModel = PlacesModel.fromJson(responseJson);
      return responseModel;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        responseModel.message = ".connectivityError";
      }
      returnResponseError(e);
      return responseModel;
    } on SocketException {
      handleSocketException(getAccessToken, null,
          provider: Provider.of<HomeProvider>(OneContext.instance.context!,
              listen: false));
    } catch (e) {
      log(e.toString());
    }

    return responseModel;
  }
}
