import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/common/utils/constanr_list.dart';
import 'package:star_astro/common/utils/global.dart';
import 'package:star_astro/lib/models/user_model.dart';
import 'package:star_astro/lib/repository/base_repository.dart';
import 'package:star_astro/lib/screens/home/page/brahma_ai.dart';
import 'package:star_astro/lib/screens/question/question_bundle.dart';
import 'package:star_astro/lib/screens/settings/setting/settings.dart';
import 'package:star_astro/widgets/app_text.dart';
import '../../../common/utils/api_constant.dart';
import '../../../common/utils/images.dart';
import '../../../common/utils/styles.dart';
import '../../models/const_settings.dart';
import '../pdf/pdf_report_provider.dart';

class HomeProvider extends BaseRepository with ChangeNotifier {
  List<ConstantSettings> homeBottomList = ConstantList.homeBottomList;
  int selectedBottomId = ConstantList.homeBottomList.first.id;
  String name = "";

  List<PdfDemoModel> pdfDemoModel = [
    PdfDemoModel(
      id: 1,
      type: 3,
      pdfReportData: [
        PdfReportData(
          id: 1,
          image: Images.brahmaAi,
          title: "Brahma AI",
        ),
        PdfReportData(
          id: 1,
          image: Images.hanumanAi,
          title: "Hanuman AI",
        ),
        PdfReportData(
          id: 2,
          image: Images.careerAi,
          title: "Career AI",
        ),
        PdfReportData(
          id: 3,
          image: Images.relationAi,
          title: "Relationship AI",
        ),
        PdfReportData(
          id: 4,
          image: Images.numerologyAi,
          title: "Numerology AI",
        ),
      ],
    ),
  ];

  void onBottomItemClick(int selectedId, BuildContext context) {
    if (selectedId == 2) {
      final globalProvider =
          Provider.of<GlobalProvider>(context, listen: false);
      final balance = globalProvider.userModel?.wallet?.balance ?? 0;

      if (balance == 0) {
        // Show dialog for insufficient credits
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1A2B4D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: const Text(
                'Insufficient Credits',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Sora',
                ),
              ),
              content: const Text(
                'You do not have enough credits. Please purchase more to continue.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: 'Sora',
                ),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuestionBundleScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Buy Credits',
                    style: TextStyle(
                      color: Color(0xFF1A2B4D),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Sora',
                    ),
                  ),
                ),
              ],
            );
          },
        );
        return; // Stop further execution
      }

      // Proceed with navigation if balance is sufficient
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BrahmaAiScreen(aiType: 'brahma'),
        ),
      );
    } else if (selectedId == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsScreen()),
      );
    } else if (selectedId == 1) {
      selectedBottomId = selectedId;
      notifyListeners();
    }
  }

  // void onBottomItemClick(int selectedId, BuildContext context) {
  //   if (selectedId == 2) {
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => BrahmaAiScreen(
  //                   aiType: 'brahma',
  //                 )));
  //   } else if (selectedId == 3) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => SettingsScreen()));
  //     // context.push('/additional_settings');
  //     // context.push('/edit_profile_screen?isFromLogin=true');
  //   } else if (selectedId == 1) {
  //     selectedBottomId = selectedId;
  //     notifyListeners();
  //   }
  // }

  onBannerItemClick(BuildContext context) {
    context.push('/pdf_report_screen');
  }

  onHorizontalItemClick(BuildContext context) {
    context.push('/horoscope_selection_screen');
  }

  onClickBalance(BuildContext context) {
    context.push('/question_bundle_screen');
  }

  dateDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF090d2c),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            height: 300.0,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: const DecorationImage(
                image: AssetImage(Images.perfectDateDialogBack),
                fit: BoxFit.cover,
                repeat: ImageRepeat.noRepeat,
              ),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      Images.cancelWithBack,
                      height: 24.0,
                      width: 24.0,
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                Column(
                  children: [
                    const AppText(
                      "Looking for Perfect Date?",
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                      fontFamily: sora,
                      textColor: SDColors.pdfReportText,
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    const AppText(
                      "Astro Dating is here",
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: sora,
                      textColor: SDColors.horoscopeTitle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B3651),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            "join the waitlist",
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: source,
                            textColor: SDColors.whiteColor,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: SDColors.whiteColor,
                            size: 20.0,
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  rattingDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF090d2c),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppText(
                  "How was the experience?",
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300,
                  fontFamily: sora,
                  textColor: SDColors.pdfReportText,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ignoreGestures: true,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        "Very Bad",
                        fontSize: 14.0,
                        textColor: SDColors.homeGrey,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        fontFamily: sora,
                      ),
                      AppText(
                        "Very Good",
                        fontSize: 14.0,
                        textColor: SDColors.homeGrey,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        fontFamily: sora,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  //Api Calling
  Future<void> getUserDetail(
    BuildContext context, {
    bool isEdited = false,
  }) async {
    try {
      final _ = Provider.of<GlobalProvider>(context, listen: false);

      log(accessToken.toString());

      if (!await isConnected()) throw const SocketException("noInternet");
      final apiResponse = await Dio().get(
        "$BASE_URL$apiUser",
        options: Options(headers: {'Authorization': accessToken}),
      );

      if (apiResponse.data != null && apiResponse.data['status'] == 'success') {
        name = _.userModel?.firstName ?? "";
        final data = UserModel.fromJson(apiResponse.data);
        if (data.data != null) {
          refreshUserModel(context, data.data!);
          notifyListeners();
        }
      }
    } on DioException {
      // if (e.response?.statusCode == 401) {
      //   await refreshToken();
      //   await getUserDetail(context);
      // }
    } catch (e) {
      log("Get User Detail Exception :$e");
    }
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Future<void> initFcmToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   DateTime? lastTokenGenerationDate =
  //       DateTime.tryParse(prefs.getString('lastTokenGenerationDate') ?? '');
  //   String? fcmToken = prefs.getString("fcmToken");
  //   if (fcmToken == null && lastTokenGenerationDate == null) {
  //     getToken();
  //   } else if (DateTime.now().difference(lastTokenGenerationDate!).inDays >=
  //       30) {
  //     // await listenForTokenRefresh();
  //   }
  // }

  // void getToken() async {
  //   try {
  //     String? token = await _firebaseMessaging.getToken();

  //     await setupFcmToken(token);
  //     log("Stored for 30 days .... : ${token}");
  //       } catch (e) {
  //     log("Error in token generate : ${e.toString()}");
  //   }
  // }
  void getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        await setupFcmToken(token);
        log("FCM token sent: $token");
      } else {
        log("FCM token is null and was not sent.");
      }
    } catch (e) {
      log("Error generating token: ${e.toString()}");
    }
  }

  // Future<void> listenForTokenRefresh() async {
  //   _firebaseMessaging.onTokenRefresh.listen((newToken) async {
  //     log("FCM Token refreshed: $newToken");
  //     await setupFcmToken(newToken);
  //   });
  // }

  Future<void> setupFcmToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final dio = Dio();
      const url = "$BASE_URL$notification/mobile";

      final headers = {
        'Authorization': prefs.getString("access_token") ?? '',
      };

      final response = await dio.post(
        url,
        data: {"token": token},
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        log("✅ FCM token updated successfully");
        await prefs.setString("fcmToken", token);
        await prefs.setString(
            'lastTokenGenerationDate', DateTime.now().toIso8601String());
      } else {
        log("⚠️ Unexpected response: ${response.statusCode}");
      }
    } on DioException catch (e) {
      log("❌ Error setting FCM token: ${e.response?.statusCode}");
      Fluttertoast.showToast(msg: e.response?.data['data'] ?? 'Error');
    } catch (e) {
      log("❌ Exception in setting FCM token: $e");
    }
  }
}
