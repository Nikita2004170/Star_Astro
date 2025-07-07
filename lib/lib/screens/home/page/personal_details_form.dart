import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:star_astro/common/utils/app_string.dart';
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/common/utils/styles.dart';
import 'package:star_astro/common/utils/validator.dart';
import 'package:star_astro/lib/models/partner_detail_model.dart';
import 'package:star_astro/lib/provider/settings/edit_profile_provider.dart';
import 'package:star_astro/lib/screens/home/page/brahma_ai.dart';
import 'package:star_astro/lib/screens/settings/edit_profile/components/profile_edit_text.dart';
import 'package:star_astro/widgets/app_text.dart';
import 'package:star_astro/widgets/app_gradiant_button.dart';
import 'package:star_astro/widgets/app_scaffold.dart';
import 'package:star_astro/widgets/settings_app_bar.dart';

class PersonalDetailsForm extends StatefulWidget {
  final Function(PartnerDetailsModel) onContinue;

  const PersonalDetailsForm({super.key, required this.onContinue});

  @override
  State<PersonalDetailsForm> createState() => _PersonalDetailsFormState();
}

class _PersonalDetailsFormState extends State<PersonalDetailsForm> {
  final firstNameCtrl = TextEditingController();
  final locationCtrl = TextEditingController();
  final dayCtrl = TextEditingController();
  final monthCtrl = TextEditingController();
  final yearCtrl = TextEditingController();
  final hourCtrl = TextEditingController();
  final minuteCtrl = TextEditingController();
  final secondCtrl = TextEditingController();

  String selectedGender = 'Male';
  String selectedShift = 'AM';
  String? selectedCity;

  List<String> genderList = ['Male', 'Female'];
  List<String> shiftList = ['AM', 'PM'];

  // Error variables for validation
  String? _firstNameError;
  String? _genderError;
  String? _dayError;
  String? _monthError;
  String? _yearError;
  String? _hourError;
  String? _minuteError;
  String? _secondError;
  String? _locationError;

  @override
  void initState() {
    super.initState();
    locationCtrl.addListener(() {
      final provider = Provider.of<EditProfileProvider>(context, listen: false);
      provider.onSearchChanged(locationCtrl.text);
    });
  }

  @override
  void dispose() {
    firstNameCtrl.dispose();
    locationCtrl.dispose();
    dayCtrl.dispose();
    monthCtrl.dispose();
    yearCtrl.dispose();
    hourCtrl.dispose();
    minuteCtrl.dispose();
    secondCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SettingsAppBar(
              title: "Partner Details",
              leadingIcon: Icons.arrow_back_ios,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 10),
                  _label("Partner First Name"),
                  const SizedBox(height: 8),
                  _buildTextField(firstNameCtrl, "Enter first name",
                      Validator.onlyCharacter, _firstNameError),
                  if (_firstNameError != null)
                    _buildErrorText(_firstNameError!),
                  const SizedBox(height: 20),
                  _label("Gender"),
                  const SizedBox(height: 8),
                  _buildDropdown(genderList, selectedGender, (value) {
                    setState(() {
                      selectedGender = value!;
                      _genderError = null;
                    });
                  }),
                  if (_genderError != null) _buildErrorText(_genderError!),
                  const SizedBox(height: 20),
                  _label("Date of Birth"),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _dobField(dayCtrl, "DD", 2, 1, 31, _dayError),
                      const SizedBox(width: 8),
                      _dobField(monthCtrl, "MM", 2, 1, 12, _monthError),
                      const SizedBox(width: 8),
                      _dobField(yearCtrl, "YYYY", 4, 1900, 2025, _yearError),
                    ],
                  ),
                  if (_dayError != null ||
                      _monthError != null ||
                      _yearError != null)
                    _buildErrorText(
                        _dayError ?? _monthError ?? _yearError ?? ""),
                  const SizedBox(height: 20),
                  _label("Time of Birth"),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _dobField(hourCtrl, "HH", 2, 1, 12, _hourError),
                      const SizedBox(width: 8),
                      _dobField(minuteCtrl, "MM", 2, 0, 59, _minuteError),
                      const SizedBox(width: 8),
                      _dobField(secondCtrl, "SS", 2, 0, 59, _secondError),
                      const SizedBox(width: 8),
                      Expanded(
                        child:
                            _buildDropdown(shiftList, selectedShift, (value) {
                          setState(() => selectedShift = value!);
                        }),
                      ),
                    ],
                  ),
                  if (_hourError != null ||
                      _minuteError != null ||
                      _secondError != null)
                    _buildErrorText(
                        _hourError ?? _minuteError ?? _secondError ?? ""),
                  const SizedBox(height: 20),
                  _label("Place of Birth"),
                  const SizedBox(height: 8),
                  Consumer<EditProfileProvider>(
                    builder: (context, editProfileProvider, _) {
                      return ProfileEditText(
                        controller: locationCtrl, // Use local controller
                        hintText: AppString.locationHint,
                        onChanged: (value) {
                          editProfileProvider.onSearchChanged(value);
                          setState(() {
                            _locationError = null;
                            selectedCity = null;
                          });
                        },
                      );
                    },
                  ),
                  if (_locationError != null) _buildErrorText(_locationError!),
                  const SizedBox(height: 5.0),
                  Consumer<EditProfileProvider>(
                    builder: (context, provider, child) {
                      if (provider.cities.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Container(
                        decoration: BoxDecoration(
                          color: SDColors.editProfileFill,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        constraints: const BoxConstraints(maxHeight: 200),
                        child: ListView.builder(
                          itemCount: provider.cities.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final city = provider.cities[index];
                            return ListTile(
                              onTap: () {
                                provider.onSelectCity(city);
                                setState(() {
                                  locationCtrl.text = city.displayName ?? "";
                                  selectedCity = city.displayName;
                                  _locationError = null;
                                });
                              },
                              title: AppText(
                                city.displayName ?? "",
                                textColor: SDColors.whiteColor,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            AppGradiantButton(
              title: "Continue",
              onTap: _handleContinue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return AppText(
      text,
      fontSize: 14,
      fontFamily: sora,
      fontWeight: FontWeight.w400,
      textColor: SDColors.settingsTextWhite,
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String hint,
      [List<TextInputFormatter>? inputFormatters,
      String? errorText,
      ValueChanged<String>? onChanged]) {
    return Container(
      decoration: BoxDecoration(
        color: SDColors.editProfileFill,
        borderRadius: BorderRadius.circular(12),
        border:
            errorText != null ? Border.all(color: Colors.red, width: 1) : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: ctrl,
        inputFormatters: inputFormatters,
        keyboardType: inputFormatters == Validator.onlyCharacter
            ? TextInputType.text
            : TextInputType.number,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
              color: SDColors.whiteColor.withOpacity(0.5), fontSize: 14),
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (onChanged != null && ctrl == locationCtrl) {
            onChanged(value);
          }
          setState(() {
            if (ctrl == firstNameCtrl) _firstNameError = null;
            if (ctrl == dayCtrl) _dayError = null;
            if (ctrl == monthCtrl) _monthError = null;
            if (ctrl == yearCtrl) _yearError = null;
            if (ctrl == hourCtrl) _hourError = null;
            if (ctrl == minuteCtrl) _minuteError = null;
            if (ctrl == secondCtrl) _secondError = null;
          });
        },
      ),
    );
  }

  Widget _dobField(TextEditingController ctrl, String hint, int length,
      [int min = 0, int max = 9999, String? errorText]) {
    return Expanded(
      child: _buildTextField(
        ctrl,
        hint,
        [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(length),
          // Allow partial input during typing
          TextInputFormatter.withFunction((oldValue, newValue) {
            if (newValue.text.isEmpty) return newValue;
            final num? value = int.tryParse(newValue.text);
            if (value == null) return oldValue;
            return newValue;
          }),
        ],
        errorText,
      ),
    );
  }

  Widget _buildDropdown(
      List<String> items, String value, ValueChanged<String?> onChange) {
    return Container(
      decoration: BoxDecoration(
        color: SDColors.editProfileFill,
        borderRadius: BorderRadius.circular(12),
        border: _genderError != null
            ? Border.all(color: Colors.red, width: 1)
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButton<String>(
        value: value,
        icon: Icon(Icons.keyboard_arrow_down_rounded,
            color: SDColors.whiteColor.withOpacity(0.5)),
        underline: const SizedBox(),
        isExpanded: true,
        dropdownColor: SDColors.editProfileFill,
        onChanged: onChange,
        items: items.map((e) {
          return DropdownMenuItem(
            value: e,
            child: AppText(
              e,
              textColor: SDColors.settingsTextWhite,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildErrorText(String error) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 12),
      child: AppText(
        error,
        textColor: Colors.red,
        fontSize: 12,
      ),
    );
  }

  bool _validateForm() {
    bool isValid = true;

    // Validate First Name
    if (firstNameCtrl.text.trim().isEmpty) {
      setState(() {
        _firstNameError = "First name is required";
      });
      isValid = false;
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(firstNameCtrl.text.trim())) {
      setState(() {
        _firstNameError = "Only letters are allowed";
      });
      isValid = false;
    }

    // Validate Gender
    if (selectedGender.isEmpty) {
      setState(() {
        _genderError = "Gender is required";
      });
      isValid = false;
    }

    // Validate Date of Birth
    if (dayCtrl.text.isEmpty) {
      setState(() {
        _dayError = "Day is required";
      });
      isValid = false;
    } else {
      int? day = int.tryParse(dayCtrl.text);
      if (day == null || day < 1 || day > 31) {
        setState(() {
          _dayError = "Invalid day (1-31)";
        });
        isValid = false;
      }
    }

    if (monthCtrl.text.isEmpty) {
      setState(() {
        _monthError = "Month is required";
      });
      isValid = false;
    } else {
      int? month = int.tryParse(monthCtrl.text);
      if (month == null || month < 1 || month > 12) {
        setState(() {
          _monthError = "Invalid month (1-12)";
        });
        isValid = false;
      }
    }

    if (yearCtrl.text.isEmpty) {
      setState(() {
        _yearError = "Year is required";
      });
      isValid = false;
    } else {
      int? year = int.tryParse(yearCtrl.text);
      if (year == null || year < 1900 || year > 2025) {
        setState(() {
          _yearError = "Invalid year (1900-2025)";
        });
        isValid = false;
      }
    }

    // Validate Time of Birth
    if (hourCtrl.text.isEmpty) {
      setState(() {
        _hourError = "Hour is required";
      });
      isValid = false;
    } else {
      int? hour = int.tryParse(hourCtrl.text);
      if (hour == null || hour < 1 || hour > 12) {
        setState(() {
          _hourError = "Invalid hour (1-12)";
        });
        isValid = false;
      }
    }

    if (minuteCtrl.text.isEmpty) {
      setState(() {
        _minuteError = "Minute is required";
      });
      isValid = false;
    } else {
      int? minute = int.tryParse(minuteCtrl.text);
      if (minute == null || minute < 0 || minute > 59) {
        setState(() {
          _minuteError = "Invalid minute (0-59)";
        });
        isValid = false;
      }
    }

    if (secondCtrl.text.isEmpty) {
      setState(() {
        _secondError = "Second is required";
      });
      isValid = false;
    } else {
      int? second = int.tryParse(secondCtrl.text);
      if (second == null || second < 0 || second > 59) {
        setState(() {
          _secondError = "Invalid second (0-59)";
        });
        isValid = false;
      }
    }

    // Validate Location
    if (selectedCity == null || locationCtrl.text.trim().isEmpty) {
      setState(() {
        _locationError = "Location is required";
      });
      isValid = false;
    }

    return isValid;
  }

  void _handleContinue() {
    if (_validateForm()) {
      final dateOfBirth =
          "${yearCtrl.text}-${monthCtrl.text.padLeft(2, '0')}-${dayCtrl.text.padLeft(2, '0')}";
      final timeOfBirth =
          "${hourCtrl.text.padLeft(2, '0')}:${minuteCtrl.text.padLeft(2, '0')}:${secondCtrl.text.padLeft(2, '0')}";

      final partnerModel = PartnerDetailsModel(
        latitude: 77.5946,
        longitude: 77.5946,
        timezone: 5.5,
        gender: selectedGender.toLowerCase(),
        dateOfBirth: dateOfBirth,
        timeOfBirth: timeOfBirth,
      );

      widget.onContinue(partnerModel);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BrahmaAiScreen(
            partnerDetail: partnerModel,
            aiType: "relationship",
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields correctly'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
