import 'package:flutter/material.dart';
import 'package:star_astro/common/utils/images.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:star_astro/lib/screens/home/home_screen.dart';
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
          'https://2factor.in/API/V1/$_apiKey/SMS/$phoneNumber/AUTOGEN3/Star_Astro_Otp');

      final response = await http.get(url);
      final responseData = json.decode(response.body);

      if (responseData['Status'] == 'Success') {
        return true;
      } else {
        // Show error message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Failed to send OTP: ${responseData['Details']}')),
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

  Future<bool> verifyOtp(
      String phoneNumber, String otpEntered, BuildContext context) async {
    try {
      if (!phoneNumber.startsWith('+')) {
        phoneNumber = '+91$phoneNumber';
      }

      final Uri url = Uri.parse(
          'https://2factor.in/API/V1/$_apiKey/SMS/VERIFY3/$phoneNumber/$otpEntered');

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

class OtpVerificationScreen extends StatefulWidget {
  final String phone;
  const OtpVerificationScreen({super.key, required this.phone});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final OtpService _otpService = OtpService();
  bool _isLoading = false;

  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());

  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  int _resendCountdown = 21;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startResendCountdown() {
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (_resendCountdown == 0) return false;
      setState(() => _resendCountdown--);
      return true;
    });
  }

  void _verifyOtp() async {
    String otp = _otpControllers.map((c) => c.text).join();

    if (otp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the full 4-digit OTP")),
      );
      return;
    }

    bool isVerified = await OtpService().verifyOtp(widget.phone, otp, context);

    if (isVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP Verified Successfully")),
      );

      // Navigate to HomeScreen using Navigator.push
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP or Verification Failed")),
      );
    }
  }

  void _sendOtp() async {
    setState(() {
      _isLoading = true;
      _resendCountdown = 21;
    });

    try {
      bool success = await _otpService.sendOtp(widget.phone, context);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP resent successfully')),
        );
        _startResendCountdown();
      }
    } catch (e) {
      // Already handled inside OtpService
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: SDColors.backgroundColor,
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     Color.fromRGBO(51, 206, 255, 0.85),
          //     Color.fromRGBO(214, 51, 255, 0),
          //   ],
          // ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Center(
                  child: Image.asset(
                    Images.appBarLogo,
                    height: 60,
                  ),
                ),
              ), // Replace with your logo asset
              const SizedBox(height: 30),
              const Text(
                "Enter OTP",
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Enter 4-digit verification code sent to your\nphone number +91 ${widget.phone}",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Edit",
                    style: TextStyle(color: Color(0xFFFF9F50))),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: const Color(0xFF1E1E1E),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onChanged: (value) {
                        if (value.length == 1 && index < 3) {
                          FocusScope.of(context)
                              .requestFocus(_focusNodes[index + 1]);
                        } else if (value.isEmpty && index > 0) {
                          FocusScope.of(context)
                              .requestFocus(_focusNodes[index - 1]);
                        }
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _verifyOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9F50),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Verify",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              const SizedBox(height: 20),
              const Text("Trouble receiving code?",
                  style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: _resendCountdown == 0 && !_isLoading ? _sendOtp : null,
                child: Text(
                  _resendCountdown == 0
                      ? "RESEND OTP"
                      : "00:${_resendCountdown.toString().padLeft(2, '0')} RESEND OTP",
                  style: TextStyle(
                    color: _resendCountdown == 0 && !_isLoading
                        ? const Color(0xFFFF9F50)
                        : Colors.white38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// }
