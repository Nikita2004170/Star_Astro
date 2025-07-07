import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_astro/lib/screens/home/home_screen.dart' as home;
import 'package:star_astro/common/utils/colors.dart';
import 'package:star_astro/common/utils/styles.dart';
import 'package:star_astro/common/utils/validator.dart';
import 'package:star_astro/lib/provider/settings/edit_profile_provider.dart';
import 'package:star_astro/widgets/app_drop_down.dart';
import 'package:star_astro/widgets/app_text.dart';
import '../../../../common/utils/app_string.dart';
import '../../../../widgets/app_gradiant_button.dart';
import '../../../../widgets/app_scaffold.dart';
import '../../../models/const_settings.dart';
import 'components/profile_edit_text.dart';
import 'components/profile_text.dart';

// @RoutePage()
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, this.isFromLogin = false});

  final bool isFromLogin;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Add validation error messages
  String? _firstNameError;
  String? _lastNameError;
  String? _genderError;
  String? _dateError;
  String? _monthError;
  String? _yearError;
  String? _hourError;
  String? _minuteError;
  String? _secondError;
  String? _locationError;
  String? _astrologyError;

  @override
  void initState() {
    super.initState();
    Provider.of<EditProfileProvider>(context, listen: false)
        .initialDataFill(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => home.HomeScreen()));
        return false;
      },
      child: AppScaffold(
        body: _buildEditProfileView(context),
      ),
    );
  }

  Widget _buildEditProfileView(BuildContext context) {
    final editProfileProvider =
        Provider.of<EditProfileProvider>(context, listen: false);
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => home.HomeScreen()),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: SDColors.whiteColor,
                    ),
                  ),
                  Expanded(
                    child: AppText(
                      AppString.editProfile.toUpperCase(),
                      textColor: SDColors.whiteColor.withOpacity(0.7),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: sora,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 48.0),
                ],
              ),
            ),

            // SettingsAppBar(
            //   title: AppString.editProfile.toUpperCase(),
            //   leadingIcon: Icons.arrow_back_ios,
            // ),
            const SizedBox(
              height: 8.0,
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                children: [
                  // First Name Field
                  const ProfileText(title: AppString.firstName),
                  const SizedBox(height: 8.0),
                  ProfileEditText(
                    controller: editProfileProvider.firstNameCtrl,
                    inputFormatters: Validator.onlyCharacter,
                    hintText: AppString.firstNameHint,
                  ),
                  if (_firstNameError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        _firstNameError!,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20.0),

                  // Last Name Field
                  const ProfileText(title: AppString.lastName),
                  const SizedBox(height: 8.0),
                  ProfileEditText(
                    controller: editProfileProvider.lastNameCtrl,
                    inputFormatters: Validator.onlyCharacter,
                    hintText: AppString.lastNameHint,
                  ),
                  if (_lastNameError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        _lastNameError!,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20.0),

                  // Gender Field
                  const ProfileText(title: AppString.gender),
                  const SizedBox(height: 8.0),
                  Consumer<EditProfileProvider>(
                    builder: (context, provider, child) {
                      return AppDropDown(
                        items: editProfileProvider.genderList
                            .map<DropdownMenuItem<ConstantSettings>>(
                          (ConstantSettings value) {
                            return DropdownMenuItem<ConstantSettings>(
                              value: value,
                              child: AppText(
                                value.title ?? "",
                                textColor: SDColors.settingsTextWhite,
                              ),
                            );
                          },
                        ).toList(),
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: SDColors.settingsTextWhite.withOpacity(0.5),
                        ),
                        value: editProfileProvider.selectedGender,
                        onChange: (type) {
                          editProfileProvider.onGenderChange(type);
                          setState(() {
                            _genderError = null;
                          });
                        },
                      );
                    },
                  ),
                  if (_genderError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        _genderError!,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20.0),

                  // Date of Birth Field
                  const ProfileText(title: AppString.dateOfBirth),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfileEditText(
                              controller: editProfileProvider.dateCtrl,
                              inputFormatters: Validator.onlyNumber(
                                length: 2,
                                min: 1,
                                max: 31,
                              ),
                              keyboardType: TextInputType.number,
                              hintText: AppString.day,
                            ),
                            if (_dateError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  _dateError!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfileEditText(
                              controller: editProfileProvider.monthCtrl,
                              inputFormatters: Validator.onlyNumber(
                                length: 2,
                                min: 1,
                                max: 12,
                              ),
                              keyboardType: TextInputType.number,
                              hintText: AppString.month,
                            ),
                            if (_monthError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  _monthError!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfileEditText(
                              controller: editProfileProvider.yearCtrl,
                              inputFormatters: Validator.onlyNumber(length: 4),
                              hintText: AppString.year,
                              keyboardType: TextInputType.number,
                            ),
                            if (_yearError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  _yearError!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),

                  // Time of Birth Field
                  const ProfileText(title: AppString.timeOfBirth),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfileEditText(
                              controller: editProfileProvider.hourCtrl,
                              hintText: "HH",
                              keyboardType: TextInputType.number,
                              inputFormatters: Validator.onlyNumber(
                                length: 2,
                                min: 1,
                                max: 12,
                              ),
                            ),
                            if (_hourError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  _hourError!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfileEditText(
                              controller: editProfileProvider.minutesCtrl,
                              hintText: "MM",
                              keyboardType: TextInputType.number,
                              inputFormatters: Validator.onlyNumber(
                                length: 2,
                                min: 0,
                                max: 59,
                              ),
                            ),
                            if (_minuteError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  _minuteError!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfileEditText(
                              controller: editProfileProvider.secondCtrl,
                              keyboardType: TextInputType.number,
                              inputFormatters: Validator.onlyNumber(
                                length: 2,
                                min: 0,
                                max: 59,
                              ),
                              hintText: "SS",
                            ),
                            if (_secondError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  _secondError!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Consumer<EditProfileProvider>(
                          builder: (context, provider, child) {
                            return AppDropDown(
                              items: editProfileProvider.shiftList
                                  .map<DropdownMenuItem<ConstantSettings>>(
                                (ConstantSettings value) {
                                  return DropdownMenuItem<ConstantSettings>(
                                    value: value,
                                    child: AppText(
                                      value.title ?? "",
                                      textColor: SDColors.settingsTextWhite,
                                    ),
                                  );
                                },
                              ).toList(),
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 10.0),
                              value: editProfileProvider.selectedShift,
                              onChange: (type) =>
                                  editProfileProvider.onShiftChange(type),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),

                  // Location Field
                  const ProfileText(title: AppString.location),
                  const SizedBox(height: 8.0),
                  ProfileEditText(
                    controller: editProfileProvider.locationCtrl,
                    hintText: AppString.locationHint,
                    onChanged: (value) {
                      editProfileProvider.onSearchChanged(value);
                      setState(() {
                        _locationError = null;
                      });
                    },
                  ),
                  if (_locationError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        _locationError!,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  const SizedBox(height: 5.0),

                  // Location Search Results
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
                  const SizedBox(height: 20),

                  // Astrology Field
                  const ProfileText(title: "Astrology"),
                  const SizedBox(height: 8.0),
                  Container(
                    decoration: BoxDecoration(
                      color: SDColors.editProfileFill,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Consumer<EditProfileProvider>(
                      builder: (context, provider, child) {
                        return Row(
                          children: [
                            _astrologyType(
                              "Vedic",
                              isSelected: provider.selectedAstrology == 1,
                              onTap: () {
                                provider.onAstrologyChange(1);
                                setState(() {
                                  _astrologyError = null;
                                });
                              },
                            ),
                            _astrologyType(
                              "Western",
                              isSelected: provider.selectedAstrology == 2,
                              onTap: () {
                                provider.onAstrologyChange(2);
                                setState(() {
                                  _astrologyError = null;
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  if (_astrologyError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        _astrologyError!,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
            AppGradiantButton(
              onTap: () => _validateAndSave(context, editProfileProvider),
              title: AppString.saveChanges,
            ),
          ],
        ),
      ),
    );
  }

  // Validation method
  void _validateAndSave(BuildContext context, EditProfileProvider provider) {
    bool isValid = true;

    // Reset all errors
    setState(() {
      _firstNameError = null;
      _lastNameError = null;
      _genderError = null;
      _dateError = null;
      _monthError = null;
      _yearError = null;
      _hourError = null;
      _minuteError = null;
      _secondError = null;
      _locationError = null;
      _astrologyError = null;
    });

    // Validate First Name
    if (provider.firstNameCtrl.text.trim().isEmpty) {
      _firstNameError = "First name is required";
      isValid = false;
    }

    // Validate Last Name
    if (provider.lastNameCtrl.text.trim().isEmpty) {
      _lastNameError = "Last name is required";
      isValid = false;
    }

    // Validate Date
    if (provider.dateCtrl.text.trim().isEmpty) {
      _dateError = "Day is required";
      isValid = false;
    } else {
      int? day = int.tryParse(provider.dateCtrl.text.trim());
      if (day == null || day < 1 || day > 31) {
        _dateError = "Invalid day";
        isValid = false;
      }
    }

    // Validate Month
    if (provider.monthCtrl.text.trim().isEmpty) {
      _monthError = "Month is required";
      isValid = false;
    } else {
      int? month = int.tryParse(provider.monthCtrl.text.trim());
      if (month == null || month < 1 || month > 12) {
        _monthError = "Invalid month";
        isValid = false;
      }
    }

    // Validate Year
    if (provider.yearCtrl.text.trim().isEmpty) {
      _yearError = "Year is required";
      isValid = false;
    } else {
      int? year = int.tryParse(provider.yearCtrl.text.trim());
      int currentYear = DateTime.now().year;
      if (year == null || year < 1900 || year > currentYear) {
        _yearError = "Invalid year";
        isValid = false;
      }
    }

    // Validate Hour
    if (provider.hourCtrl.text.trim().isEmpty) {
      _hourError = "Hour is required";
      isValid = false;
    } else {
      int? hour = int.tryParse(provider.hourCtrl.text.trim());
      if (hour == null || hour < 1 || hour > 12) {
        _hourError = "Invalid hour";
        isValid = false;
      }
    }

    // Validate Minutes
    if (provider.minutesCtrl.text.trim().isEmpty) {
      _minuteError = "Minutes required";
      isValid = false;
    } else {
      int? minute = int.tryParse(provider.minutesCtrl.text.trim());
      if (minute == null || minute < 0 || minute > 59) {
        _minuteError = "Invalid minute";
        isValid = false;
      }
    }

    // Validate Seconds
    if (provider.secondCtrl.text.trim().isEmpty) {
      _secondError = "Seconds required";
      isValid = false;
    } else {
      int? second = int.tryParse(provider.secondCtrl.text.trim());
      if (second == null || second < 0 || second > 59) {
        _secondError = "Invalid second";
        isValid = false;
      }
    }

    // Validate Location
    if (provider.locationCtrl.text.trim().isEmpty) {
      _locationError = "Location is required";
      isValid = false;
    }

    // Validate Astrology
    if (provider.selectedAstrology == 0) {
      _astrologyError = "Please select astrology type";
      isValid = false;
    }

    setState(() {});

    if (isValid) {
      // All validations passed, proceed with save
      provider.onSaveChange(context, isFromLogin: widget.isFromLogin);
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields correctly'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Widget _astrologyType(
    String title, {
    bool isSelected = false,
    GestureTapCallback? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? SDColors.purpule : SDColors.transparent,
            borderRadius: BorderRadius.circular(6.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          alignment: Alignment.center,
          child: AppText(
            title,
            textColor: SDColors.whiteColor,
            fontSize: 14.0,
            fontFamily: sora,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
