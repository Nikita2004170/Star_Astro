import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:star_astro/lib/models/user_model.dart';

class GlobalProvider with ChangeNotifier {
  UserData? _userModel;

  GlobalProvider(this._userModel);

  UserData? get userModel => _userModel;

  void updateUserModel(UserData newUserModel) {
    _userModel = newUserModel;
    notifyListeners();
  }

  String formatBirthDate() {
    final String? dob = userModel?.dateOfBirth;

    // FIRST, check for null or empty
    if (dob == null || dob.isEmpty) {
      return "";
    }

    List<String> parts = dob.split('-');

    // THEN, check if the format is correct (yyyy-mm-dd)
    if (parts.length != 3) {
      return dob; // Return the original string if format is unexpected
    }

    // Only reformat if everything is correct
    return "${parts[2]}-${parts[1]}-${parts[0]}";
  }

  String formatExpiredDate() {
    // Safely get the date string
    final String? expiresOnDate = userModel?.wallet?.expiresOn;

    // FIRST, check if the date string is null or empty
    if (expiresOnDate == null || expiresOnDate.isEmpty) {
      return "N/A"; // Return a default value
    }

    try {
      // THEN, parse it
      DateTime dateTime = DateTime.parse(expiresOnDate);
      DateFormat dateFormat = DateFormat('dd MMM, yyyy');
      return dateFormat.format(dateTime);
    } catch (e) {
      // If parsing fails for any reason, return a fallback value
      return "Invalid Date";
    }
  }
}

void refreshUserModel(BuildContext context, UserData userData) {
  // Access UserProvider
  final userProvider = Provider.of<GlobalProvider>(context, listen: false);

  // Create a new UserModel or fetch updated data
  UserData updatedUserModel = userData;

  // Update the UserProvider
  userProvider.updateUserModel(updatedUserModel);
}
