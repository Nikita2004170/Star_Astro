import 'package:flutter/material.dart';
import 'package:star_astro/widgets/app_scaffold.dart';
import 'otp_varification_screen.dart';
import 'package:star_astro/common/utils/images.dart';

class PhoneEntryScreen extends StatefulWidget {
  const PhoneEntryScreen({super.key});

  @override
  State<PhoneEntryScreen> createState() => _PhoneEntryScreenState();
}

class _PhoneEntryScreenState extends State<PhoneEntryScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  final OtpService _otpService = OtpService();

  // Phone number validation
  bool _isValidPhoneNumber(String phone) {
    // Remove any spaces or special characters
    String cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');

    // Check if it's a valid 10-digit Indian number
    if (cleanPhone.length == 10 && cleanPhone.startsWith(RegExp(r'[6-9]'))) {
      return true;
    }

    // Check if it's already in international format
    if (cleanPhone.length == 12 && cleanPhone.startsWith('91')) {
      return true;
    }

    return false;
  }

  void _sendOtp() async {
    String phoneNumber = _controller.text.trim();

    // Validate phone number
    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your mobile number')),
      );
      return;
    }

    if (!_isValidPhoneNumber(phoneNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter a valid 10-digit mobile number')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      bool success = await _otpService.sendOtp(phoneNumber, context);

      if (success) {
        // Navigate to OTP verification screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OtpVerificationScreen(phone: phoneNumber),
          ),
        );
      }
    } catch (e) {
      // Error is already handled in the service
      print('Error sending OTP: $e');
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
    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Center(
                child: Image.asset(
                  Images.appBarLogo,
                  height: 60,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Enter your\nMobile Number",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(color: Colors.white),
                      maxLength: 10,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF1E1E1E),
                        hintText: 'Enter 10-digit mobile number',
                        prefixText: '+91 ',
                        prefixStyle: const TextStyle(color: Colors.white),
                        prefixIcon:
                            const Icon(Icons.phone, color: Colors.white),
                        hintStyle: const TextStyle(color: Colors.grey),
                        counterText: '', // Hide character counter
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xFFFF9F50), width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _sendOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9F50),
                        disabledBackgroundColor: Colors.grey,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Sending OTP...",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            )
                          : const Text(
                              "Send OTP",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "We'll send you a verification code on this number",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
