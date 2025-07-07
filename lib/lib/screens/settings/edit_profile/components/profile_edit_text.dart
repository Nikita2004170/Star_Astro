import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../common/utils/colors.dart';
import '../../../../../common/utils/styles.dart';
import '../../../../../widgets/edit_text.dart';

class ProfileEditText extends StatelessWidget {
  const ProfileEditText({
    super.key,
    required this.controller,
    this.inputFormatters,
    this.hintText,
    this.onChanged,
    this.keyboardType,
  });

  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      cursorColor: SDColors.settingsTextWhite.withOpacity(0.5),
      fontSize: 14.0,
      fontFamily: sora,
      fillColor: SDColors.editProfileFill,
      fontWeight: FontWeight.w400,
      textColor: SDColors.settingsTextWhite,
      hintText: hintText,
      hintColor: SDColors.settingsTextWhite.withOpacity(0.5),
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      keyboardType: keyboardType,
    );
  }
}
