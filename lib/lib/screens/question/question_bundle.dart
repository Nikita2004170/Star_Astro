import 'dart:convert';
import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/common/utils/common_widget.dart';
import 'package:star_astro/lib/screens/question/stripe_webview.dart';
import 'package:star_astro/widgets/app_text.dart';
import '../../../common/utils/api_constant.dart';
import '../../../common/utils/app_string.dart';
import '../../../common/utils/global.dart';
import '../../../widgets/app_scaffold.dart';
import '../../../widgets/settings_app_bar.dart';
import '../../models/plan_model.dart';
import '../../models/razorpay_order.dart';
import '../../models/stripe_order.dart';
import '../../provider/home/home_provider.dart';
import '../../provider/question/question_bundle_provider.dart';
import '../../razorpay_service/payment_service.dart';
import 'item_view/question_bundle_item_view.dart';
import 'widget/payment_mode_dialog.dart';

@RoutePage()
class QuestionBundleScreen extends StatefulWidget {
  const QuestionBundleScreen({super.key});

  @override
  State<QuestionBundleScreen> createState() => _QuestionBundleScreenState();
}

class _QuestionBundleScreenState extends State<QuestionBundleScreen> {
  final Razorpay razorpay = Razorpay();
  final PaymentService _paymentService = PaymentService();

  String _razorPayOrderId = "";
  bool _isIndianUser = false;
  bool _isLoadingCountry = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final provider =
          Provider.of<QuestionBundleProvider>(context, listen: false);
      initializeRazorPay();
      await _fetchLocationData();
      provider.getPlans(context);
    });
  }

  Future<void> _fetchLocationData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token') ?? '';
      log(token);

      final response = await http.get(
        Uri.parse('https://api.test.starastrogpt.com/ip2location'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        log('Response Body: ${response.body}');
        final Map<String, dynamic> data = json.decode(response.body);
        log('Decoded JSON: $data');

        if (data['status'] == 'success' && data['data'] != null) {
          final String countryCode = data['data']['countryCode'] ?? '';
          setState(() {
            _isIndianUser = countryCode == 'IN';
            _isLoadingCountry = false;
          });
        } else {
          _handleLocationError();
        }
      } else {
        _handleLocationError();
      }
    } catch (e) {
      _handleLocationError();
    }
  }

  void _handleLocationError() {
    setState(() {
      _isIndianUser = false; // Default to USD
      _isLoadingCountry = false;
    });
    log('Failed to fetch location data. Defaulting to USD pricing.');
  }

  initializeRazorPay() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessEvent);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentFailureEvent);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleWalletResponse);
  }

  Future<void> initiatePayment(
    PlanData plan, {
    bool upi = false,
    bool card = false,
    String? promoCode,
    required BuildContext context,
  }) async {
    // Show loading indicator
    showProgressDialog(context);

    // Create a local variable to store whether the widget is still mounted
    final navigator = Navigator.of(context);

    // Create Order
    final RazorpayOrderData? orderResponse =
        await _paymentService.createRazorPayOrder(
      planName: plan.name ?? "",
      promoCode: promoCode,
    );

    // Check if the widget is still mounted before dismissing the dialog
    if (navigator.mounted) {
      // Hide loading indicator
      navigator.pop();
    }

    if (orderResponse != null && orderResponse.orderId != null) {
      _razorPayOrderId = orderResponse.orderId ?? "";

      // Open Razorpay Payment Session
      openRazorPaySession(
        context,
        plan.name ?? "",
        plan.name ?? "",
        upi: upi,
        card: card,
        upiId: promoCode,
      );
    } else {
      // Check if the widget is still mounted before showing the snackbar
      Fluttertoast.showToast(msg: "Failed to create order. Please try again.");
    }
  }

  @override
  void openRazorPaySession(
    BuildContext context,
    String productName,
    String productDescription, {
    bool upi = false,
    bool card = false,
    String? upiId,
  }) {
    try {
      final _ = Provider.of<GlobalProvider>(context, listen: false);
      final Map<String, dynamic> options = {
        'key': razorPayKey,
        'order_id': _razorPayOrderId,
        'retry': {'enabled': true, 'max_count': 1},
        'send_sms_hash': true,
        'external': {
          'wallets': ['paytm'],
        },
        'prefill': {
          'contact': _.userModel?.mobile ?? "",
          'email': _.userModel?.email ?? "",
          if (upiId != null) 'vpa': upiId,
        },
        'method': {
          'upi': upi,
          'card': card,
          'netbanking': false,
          'wallet': false,
          'emi': false,
          'apple_pay': false,
          'paylater': false,
        },
      };
      razorpay.open(options);
    } catch (error) {
      log("error ==>$error");
    }
  }

  void handlePaymentFailureEvent(
      PaymentFailureResponse paymentFailureResponse) {
    log("handlePaymentFailureEvent...");

    /// here just show the payment failure message with the help of snackbar.
    Fluttertoast.showToast(msg: paymentFailureResponse.message.toString());
  }

  void handlePaymentSuccessEvent(PaymentSuccessResponse response) async {
    // Verify Payment on Backend
    log("handlePaymentSuccessEvent...");

    await _paymentVerify();
  }

  Future<void> _paymentVerify({String? orderId}) async {
    bool isVerified = await _paymentService.verifyPayment(
      orderId ?? _razorPayOrderId,
    );

    if (isVerified) {
      log("isVerified : $isVerified");
      Provider.of<HomeProvider>(context, listen: false).getUserDetail(context);
      Fluttertoast.showToast(msg: "Payment Successfully Done");

      // TODO: Update your app's state, e.g., grant access to purchased content
    } else {
      Fluttertoast.showToast(
          msg: "Payment verification failed. Please contact support.");
    }
  }

  void handleWalletResponse(ExternalWalletResponse externalWalletResponse) {
    String chosenWallet =
        externalWalletResponse.walletName ?? ""; // Capture chosen wallet name
    switch (chosenWallet) {
      case 'paytm':
        // Display specific information for Paytm
        break;
      case 'freecharge':
        // Display specific information for Freecharge
        break;
      default:
    }
  }

  //Stripe
  StripeOrderData? _stripePayOrder;

  Future<void> stripeMakePayment(
    PlanData plan, {
    required BuildContext context,
    String? promoCode,
  }) async {
    try {
      // Show loading indicator
      showProgressDialog(context);

      // Create a local variable to store whether the widget is still mounted
      final navigator = Navigator.of(context);
      final scaffoldMessenger = ScaffoldMessenger.of(context);

      // Create Order
      final StripeOrderData? orderResponse =
          await _paymentService.createStripeOrder(
        planName: plan.name ?? "",
        promoCode: promoCode,
      );
      log("Stripe order detail : ${orderResponse?.toJson()}");
      // Check if the widget is still mounted before dismissing the dialog
      if (navigator.mounted) {
        // Hide loading indicator
        navigator.pop();
      }

      if (orderResponse != null && orderResponse.orderId != null) {
        _stripePayOrder = orderResponse;
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  StripeWebView(url: _stripePayOrder?.stripeUrl ?? "")),
        );
        if (result != null) {
          await _paymentVerify(orderId: result);
        }

        // await _openStripeSession(context);
      } else {
        // Check if the widget is still mounted before showing the snackbar
        if (scaffoldMessenger.mounted) {
          Fluttertoast.showToast(
              msg: "Failed to create order. Please try again.");
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: _buildQuestionView(context),
    );
  }

  Widget _buildQuestionView(BuildContext context) {
    final questionBundleProvider =
        Provider.of<QuestionBundleProvider>(context, listen: false);
    return SafeArea(
      child: Column(
        children: [
          SettingsAppBar(
            title: AppString.questionBundle.toUpperCase(),
            leadingIcon: Icons.arrow_back_ios,
          ),
          Expanded(
            child: Consumer<QuestionBundleProvider>(
              builder: (context, provider, child) {
                // Filter plans based on country code
                final filteredPlans = provider.planDataList.where((plan) {
                  if (_isIndianUser) {
                    // Indian user: Show plans that do NOT start with "sub"
                    return !(plan.name?.startsWith('sub') ?? false);
                  } else {
                    // Non-Indian user: Show plans that start with "sub"
                    return plan.name?.startsWith('sub') ?? false;
                  }
                }).toList();

                if (_isLoadingCountry) {
                  // Show loading indicator while country code is being fetched
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (filteredPlans.isEmpty) {
                  // Show message if no plans are available
                  return const Center(
                    child: AppText(
                      'No plans available for your location.',
                      fontSize: 16.0,
                      textColor: SDColors.settingsTextWhite,
                    ),
                  );
                }

                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: .8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 24,
                    crossAxisCount: 2,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  itemCount: filteredPlans.length,
                  itemBuilder: (BuildContext ctx, index) {
                    final plan = filteredPlans[index];
                    return QuestionBundleItemView(
                      plan: plan,
                      isIndianUser: _isIndianUser,
                      isLoading: _isLoadingCountry,
                      onTap: () {
                        showPaymentModeBottomSheet(
                          context,
                          questionBundleProvider,
                          onUpiClick: (promoCode) async {
                            await initiatePayment(
                              plan,
                              upi: (_isIndianUser == true) ? true : false,
                              promoCode: promoCode,
                              context: context,
                            );
                          },
                          onClickCard: (promoCode) async {
                            await stripeMakePayment(
                              plan,
                              promoCode: promoCode,
                              context: context,
                            );
                          },
                          isIndianUser: _isIndianUser,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
