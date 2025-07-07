import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReferProvider with ChangeNotifier {
  //Function for copy refer code
  void copyToClipboard(BuildContext context, String textToCopy) {
    if (textToCopy.isEmpty) return;

    Clipboard.setData(ClipboardData(text: textToCopy)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Referral code copied to clipboard!'),
          duration: Duration(seconds: 2),
        ),
      );
    }).catchError((error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to copy text.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }
}
