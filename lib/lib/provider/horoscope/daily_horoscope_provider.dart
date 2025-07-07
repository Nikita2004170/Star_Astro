import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:star_astro/lib/models/horoscope_model.dart';
import 'package:star_astro/lib/repository/horoscope_repository.dart';
import '../../../common/utils/common_function.dart';
import '../../../di/di_services.dart';

class DailyHoroscopeProvider with ChangeNotifier {
  final PageController pageController = PageController(); // Add PageController
  int currentPage = 0; // Keep track of the current page

  onSelectPage(int value) {
    currentPage = value;
    notifyListeners();
  }

  //On Share Click Event
  onShareClick() {}

  //Api Calling
  final HoroscopeRepository _horoscopeRepo = getIt.get<HoroscopeRepository>();
  HoroscopeData? horoscopeData;
  List<List<String>> predictionList = [];

  Future<void> getHoroscope({
    force = false,
    required String astrology,
    required String sign,
  }) async {
    log('getHoroscope() called in Provider');
    try {
      final queryParams = {"tz": timeZone()};
      log('Query Params: $queryParams');
      log('Astrology: $astrology, Sign: $sign');

      final horoscope =
          await _horoscopeRepo.getHoroscope(queryParams, astrology, sign);
      log('API Call Success, Horoscope Data: ${horoscope.data}');

      horoscopeData = horoscope.data;
      final horoscopeList =
          horoscopeData?.prediction?.split(RegExp(r'(?<=\.)\s*')) ?? [];
      await makeAPairOfItems(horoscopeList);
      notifyListeners();
    } catch (e, s) {
      log('Error in getHoroscope: $e');
      log('Stack: $s');
    }
  }

  // Future<void> getHoroscope({
  //   force = false,
  //   required String astrology,
  //   required String sign,
  // }) async {
  //   try {
  //     final queryParams = {"tz": timeZone()};
  //     log('astrology is: ${astrology}');
  //     log('params is: ${queryParams.toString()}');

  //     final horoscope =
  //         await _horoscopeRepo.getHoroscope(queryParams, astrology, sign);

  //     //Fill List Data
  //     horoscopeData = horoscope.data;
  //     final horoscopeList =
  //         horoscopeData?.prediction?.split(RegExp(r'(?<=\.)\s*')) ?? [];
  //     await makeAPairOfItems(horoscopeList);
  //     notifyListeners();
  //   } on DioException catch (e) {
  //     if (e.response?.statusCode == 401) {
  //       await refreshToken();
  //       await getHoroscope(
  //         astrology: astrology,
  //         sign: sign,
  //       );
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  void onTapDown(TapDownDetails details, BuildContext context) {
    // Get the screen width
    final screenWidth = MediaQuery.of(context).size.width;
    // Get the tap position
    final tapPosition = details.globalPosition.dx;
    if (tapPosition < screenWidth / 2) {
      //On Left Click
      if (currentPage >= 0) {
        currentPage--;
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      //On Right Click
      if (currentPage < predictionList.length) {
        currentPage++;
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  Future<void> makeAPairOfItems(List<String> items) async {
    List<List<String>> pairs = [];
    for (int i = 0; i < items.length; i += 4) {
      // Check if there are 4 items remaining
      if (i + 3 < items.length) {
        pairs.add([items[i], items[i + 1], items[i + 2], items[i + 3]]);
      } else {
        // If less than 4 items remain, add the remaining items
        pairs.add(items.sublist(i));
      }
    }
    predictionList = pairs;
    notifyListeners();
  }
}
