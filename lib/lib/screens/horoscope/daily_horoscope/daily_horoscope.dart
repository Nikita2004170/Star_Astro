import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_astro/common/utils/app_string.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/common/utils/images.dart';
import 'package:star_astro/common/utils/styles.dart';
import 'package:star_astro/widgets/app_scaffold.dart';
import 'package:star_astro/widgets/app_text.dart';
import 'package:star_astro/widgets/settings_app_bar.dart';

class DailyHoroscopeScreen extends StatefulWidget {
  final String astrologySystem;
  final String zodiacSign;
  final String timezone;

  const DailyHoroscopeScreen(
      {super.key,
      required this.astrologySystem,
      required this.zodiacSign,
      required this.timezone});

  @override
  State<DailyHoroscopeScreen> createState() => _DailyHoroscopeState();
}

class _DailyHoroscopeState extends State<DailyHoroscopeScreen> {
  List<List<String>> predictionList = [];
  String? sign;
  int currentPage = 0;
  PageController pageController = PageController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchHoroscope(
        widget.astrologySystem.toLowerCase(), widget.zodiacSign.toLowerCase());
  }

  Future<void> fetchHoroscope(String astrology, String sign) async {
    try {
      developer
          .log('Starting fetchHoroscope: astrology=$astrology, sign=$sign, ');
      setState(() {
        isLoading = true;
      });

      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token') ?? '';
      developer
          .log('Access token: ${accessToken.isEmpty ? "empty" : "present"}');

      final Dio dio = Dio();
      final queryParams = {"tz": 5.5};
      final String url =
          'https://api.test.starastrogpt.com/horoscope/$astrology/$sign';
      developer.log('Request URL: $url, Query params: $queryParams');

      final response = await dio.get(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      developer.log('Response status code: ${response.statusCode}');
      developer.log('Response data: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data['data'];
        developer.log('Response data field: $responseData');

        if (responseData != null && response.data['status'] == 'success') {
          setState(() {
            this.sign = responseData['sign'] ?? sign;
            predictionList = [
              [responseData['prediction'] ?? 'No prediction available']
            ];
            isLoading = false;
          });
          developer.log(
              'Horoscope fetched successfully: sign=${this.sign}, predictionList=$predictionList');
        } else {
          developer.log(
              'No data or invalid response status: status=${response.data['status']}');
          setState(() {
            predictionList = [
              ['No data available']
            ];
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to fetch horoscope data')),
          );
        }
      } else {
        developer
            .log('Failed to fetch data: Status code ${response.statusCode}');
        setState(() {
          predictionList = [
            ['Failed to fetch data']
          ];
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch horoscope data')),
        );
      }
    } catch (e, stackTrace) {
      developer.log('Error fetching horoscope: $e', stackTrace: stackTrace);
      setState(() {
        predictionList = [
          ['Error fetching horoscope. Please try again.']
        ];
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsAppBar(
              title: AppString.todayHoroscope.toUpperCase(),
              leadingIcon: Icons.arrow_back_ios,
              actionImage: Images.share,
              onActionPressed: () {
                // Implement share logic here
                developer.log('Share button pressed');
              },
            ),
            const SizedBox(height: 8.0),
            Row(
              children: List.generate(
                predictionList.length,
                (index) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Image.asset(
                      currentPage == index
                          ? Images.horoscopeTab1
                          : Images.horoscopeTab2,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : predictionList.isEmpty
                      ? const Center(
                          child: Text(
                            "Prediction List is Empty",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : PageView.builder(
                          itemCount: predictionList.length,
                          controller: pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (value) {
                            setState(() {
                              currentPage = value;
                            });
                            developer.log('Page changed to: $currentPage');
                          },
                          itemBuilder: (context, index) {
                            return Container(
                              color: SDColors.backgroundColor,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 15.0),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Image.asset(
                                          (sign?.getHoroscopeSign()) ??
                                              Images.fallbackHoroscope,
                                          height: 78.0,
                                          width: 72.0,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            developer.log(
                                                'Error loading horoscope image: $error');
                                            return const Icon(Icons.error,
                                                color: Colors.red);
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      AppText(
                                        sign ?? "Unknown Sign",
                                        fontFamily: sora,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        textColor: SDColors.horoscopeTitle
                                            .withOpacity(0.7),
                                      ),
                                      const SizedBox(height: 10.0),
                                      ...predictionList[index]
                                          .map(
                                            (prediction) => Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16.0),
                                              child: AppText(
                                                prediction,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: sora,
                                                textColor:
                                                    SDColors.settingsTextWhite,
                                              ),
                                            ),
                                          )
                                          ,
                                      // Add extra padding at bottom for better scrolling experience
                                      const SizedBox(height: 100.0),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          predictionList.isNotEmpty && currentPage < predictionList.length - 1
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (currentPage < predictionList.length - 1) {
                              currentPage++;
                              pageController.animateToPage(
                                currentPage,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          });
                          developer.log(
                              'Tap to Know More pressed, new page: $currentPage');
                        },
                        child: AppText(
                          AppString.tapToKnowMore.toUpperCase(),
                          fontSize: 12,
                          textColor: SDColors.whiteColor,
                          fontWeight: FontWeight.w600,
                          fontFamily: sora,
                        ),
                      ),
                    ],
                  ),
                )
              : null,
    );
  }
}

// Extension method for getting horoscope sign image (assumed)
extension HoroscopeSignExtension on String {
  String getHoroscopeSign() {
    // Example mapping, adjust based on your implementation
    final map = {
      'aries': Images.aries,
      'taurus': Images.taurus,
        'gemini': Images.gemini,
      'cancer': Images.cancer,
      'leo': Images.leo,
      'virgo': Images.virgo,
      'libra': Images.libra,
      'scorpio': Images.scorpio,
      'sagittarius': Images.sagittarius,
      'capricorn': Images.capricorn,
      'aquarius': Images.aquarius,
      'pisces': Images.pisces,
      'fallback': Images.fallbackHoroscope,
      // Add other zodiac signs here
    };
    return map[toLowerCase()] ?? '';
  }
}
