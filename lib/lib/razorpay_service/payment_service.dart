import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:star_astro/common/utils/api_constant.dart';
import 'package:star_astro/lib/models/razorpay_order.dart';
import 'package:star_astro/lib/models/razorpay_verify.dart';

import '../../common/utils/common_function.dart';
import '../models/stripe_order.dart';

// Replace with your backend URL
const String backendBaseUrl = 'https://your-backend.com/api';

class PaymentService {
  final dio = Dio();

  // Create Razorpay Order
  Future<RazorpayOrderData?> createRazorPayOrder({
    String? promoCode,
    required String planName,
  }) async {
    const url = '$BASE_URL$razorpayOrder';
    try {
      final bodyData = {
        "plan": planName,
        if (promoCode != null && promoCode.isNotEmpty) "promo_code": promoCode,
      };
      final response = await dio.post(
        url,
        data: bodyData,
        options: getToken(),
      );

      if (response.statusCode == 200) {
        final data = RazorpayOrder.fromJson(response.data);
        return data.data;
      } else {
        return null;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await refreshToken();
        await createRazorPayOrder(planName: planName);
      }
    } catch (e) {
      log('Create Order Exception: $e');
      return null;
    }
    return null;
  }

  // Verify Payment
  Future<bool> verifyPayment(String orderId) async {
    final url = '$BASE_URL$paymentVerify$orderId';
    try {
      final response = await dio.get(
        url,
        options: getToken(),
      );
      log("Response of api : $response");
      if (response.statusCode == 200) {
        final data = RazorpayVerify.fromJson(response.data);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await refreshToken();
        await verifyPayment(orderId);
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Create Stripe Order
  Future<StripeOrderData?> createStripeOrder({
    String? promoCode,
    required String planName,
  }) async {
    const url = '$BASE_URL$paymentOrder';
    try {
      final bodyData = {
        "plan": planName,
        if (promoCode != null && promoCode.isNotEmpty) "promo_code": promoCode,
      };
      final response = await dio.post(
        url,
        data: bodyData,
        options: getToken(),
      );

      if (response.statusCode == 200) {
        final data = StripeOrder.fromJson(response.data);
        return data.data;
      } else {
        return null;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await refreshToken();
        await createStripeOrder(planName: planName);
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
