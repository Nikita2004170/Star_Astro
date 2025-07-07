import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OtpService {
  static final OtpService _instance = OtpService._internal();
  factory OtpService() => _instance;
  OtpService._internal();

  final String _apiKey = "99011005-3bde-11f0-a562-0200cd936042"; 

  Future<bool> sendOtp(String phoneNumber, BuildContext context) async {
    try {
    
      if (!phoneNumber.startsWith('+')) {
        phoneNumber = '+91$phoneNumber'; 
      }
      
      final Uri url = Uri.parse(
        'https://2factor.in/API/V1/$_apiKey/SMS/$phoneNumber/AUTOGEN3/Bhaada_OTP_Verification'
      );
      
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      
      if (responseData['Status'] == 'Success') {
        return true;
      } else {
        // Show error message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to send OTP: ${responseData['Details']}')),
          );
        }
        return false;
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sending OTP: $e')),
        );
      }
      return false;
    }
  }

  Future<bool> verifyOtp(String phoneNumber, String otpEntered, BuildContext context) async {
    try {
      
      if (!phoneNumber.startsWith('+')) {
        phoneNumber = '+91$phoneNumber'; 
      }
      
      final Uri url = Uri.parse(
        'https://2factor.in/API/V1/$_apiKey/SMS/VERIFY3/$phoneNumber/$otpEntered'
      );
      
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      
      if (responseData['Status'] == 'Success') {
        return true;
      } else {
        // OTP verification failed
        return false;
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error verifying OTP: $e')),
        );
      }
      return false;
    }
  }
}