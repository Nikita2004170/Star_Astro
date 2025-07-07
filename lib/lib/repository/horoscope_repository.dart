import 'dart:io';

import 'package:dio/dio.dart';
import 'package:star_astro/common/utils/api_constant.dart';
import '../models/horoscope_model.dart';
import 'base_repository.dart';

abstract class HoroscopeRepository {
  Future<HoroscopeModel> getHoroscope(
      Map<String, dynamic> queryParams, String astrology, String sign);
}

class HoroscopeRepositoryImp extends BaseRepository
    implements HoroscopeRepository {
  @override
  @override
  Future<HoroscopeModel> getHoroscope(
      Map<String, dynamic> queryParams, String astrology, String sign) async {
    var responseModel = HoroscopeModel();
    try {
      print(astrology);
      print(queryParams);
      print(sign);
      if (!await isConnected()) {
        responseModel.message = ".connectivityError";
        return responseModel;
      }

      final response = await dio.get(
        "$apiHoroscope/$astrology/$sign",
        options: _barrier,
        // queryParameters: queryParams,
      );

      print('Raw API Response: ${response.data}');
      final responseJson = returnResponse(response);
      print('Parsed Response: $responseJson');
      responseModel = HoroscopeModel.fromJson(responseJson);

      return responseModel;
    } on DioException catch (e) {
      print('DioError: ${e.message}, Response: ${e.response?.data}');
      responseModel.message =
          e.response?.data['message'] ?? 'Error fetching horoscope';
      return responseModel;
    } on SocketException {
      print('SocketException: No internet connection');
      responseModel.message = ".connectivityError";
      return responseModel;
    } catch (e) {
      print('Unexpected error: $e');
      responseModel.message = 'Unexpected error occurred';
      return responseModel;
    }
  }

  Options get _barrier {
    return Options(
      headers: {
        'Authorization': accessToken,
      },
    );
  }
}
