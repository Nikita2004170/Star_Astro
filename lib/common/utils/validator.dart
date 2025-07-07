import 'package:flutter/services.dart';

class Validator {
  static List<TextInputFormatter> onlyCharacter = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
  ];

  static List<TextInputFormatter> onlyNumber(
          {int? length, int? min, int? max}) =>
      <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        if (length != null) LengthLimitingTextInputFormatter(length),
        if (min != null && max != null)
          RangeTextInputFormatter(min: min, max: max),
      ];
}

// Custom Input Formatter to restrict the value to 1-31
class RangeTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  RangeTextInputFormatter({this.min = 1, this.max = 31});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueText = newValue.text;

    // Check if the input is a number and within the range
    if (newValueText.isEmpty || int.tryParse(newValueText) == null) {
      return newValue.copyWith(text: '');
    }

    final int value = int.parse(newValueText);
    if (value < min) {
      return oldValue;
    } else if (value > max) {
      return oldValue;
    }

    return newValue;
  }
}
