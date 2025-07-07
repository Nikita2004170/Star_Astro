import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_astro/common/utils/common_widget.dart';
import 'package:star_astro/common/utils/constanr_list.dart';
import 'package:star_astro/common/utils/global.dart';
import 'package:star_astro/lib/models/user_model.dart';
import '../../../common/utils/common_function.dart';
import '../../../di/di_services.dart';
import '../../models/const_settings.dart';
import '../../models/palces_model.dart';
import '../../repository/user_repository.dart';
import '../home/home_provider.dart';
import 'package:star_astro/lib/screens/home/home_screen.dart' as home;

class EditProfileProvider with ChangeNotifier {
  final UserRepository userRepository = GetIt.instance.get<UserRepository>();
  //Gender Selection
  final List<ConstantSettings> genderList = ConstantList.genderList;
  ConstantSettings selectedGender = ConstantList.genderList.first;

  //Day Shift Selection
  final List<ConstantSettings> shiftList = ConstantList.shiftList;
  ConstantSettings selectedShift = ConstantList.shiftList.first;

  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();

  //Date Of Birth
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController monthCtrl = TextEditingController();
  TextEditingController yearCtrl = TextEditingController();

  //Time Of Birth
  TextEditingController hourCtrl = TextEditingController();
  TextEditingController minutesCtrl = TextEditingController();
  TextEditingController secondCtrl = TextEditingController();

  //Location
  TextEditingController locationCtrl = TextEditingController();

  //Astrology
  int selectedAstrology = 0;

  //On Gender Value Change
  void onGenderChange(ConstantSettings? gender) {
    selectedGender = gender!;
    notifyListeners();
  }

  //On Shift Value Change
  void onShiftChange(ConstantSettings? gender) {
    selectedShift = gender!;
    notifyListeners();
  }

  void onAstrologyChange(int id) {
    selectedAstrology = id;
    notifyListeners();
  }

  onSaveChange(BuildContext context, {bool isFromLogin = false}) async {
    if (firstNameCtrl.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please Enter First Name");
      return;
    }
    if (lastNameCtrl.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please Enter Last Name");
      return;
    }
    if (dateCtrl.text.isEmpty ||
        monthCtrl.text.isEmpty ||
        yearCtrl.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please Enter Date Of Birth");
      return;
    }
    if (hourCtrl.text.isEmpty ||
        minutesCtrl.text.isEmpty ||
        secondCtrl.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please Enter Time Of Birth");
      return;
    }
    if (selectedCity == null) {
      Fluttertoast.showToast(msg: "Please Select City!");
      return;
    }
    if (selectedAstrology == 0) {
      Fluttertoast.showToast(msg: "Please Select Astrology!");
      return;
    }
    await _prepareEditData(context, isFromLogin: isFromLogin);
  }

  Future<void> _prepareEditData(BuildContext context,
      {bool isFromLogin = false}) async {
    final String month =
        monthCtrl.text.length < 2 ? "0${monthCtrl.text}" : monthCtrl.text;
    final String day =
        dateCtrl.text.length < 2 ? "0${dateCtrl.text}" : dateCtrl.text;
    final String hours =
        hourCtrl.text.length < 2 ? "0${hourCtrl.text}" : hourCtrl.text;
    final String minute =
        minutesCtrl.text.length < 2 ? "0${minutesCtrl.text}" : minutesCtrl.text;
    final String second =
        secondCtrl.text.length < 2 ? "0${secondCtrl.text}" : secondCtrl.text;
    final bodyData = {
      "first_name": firstNameCtrl.text,
      "last_name": lastNameCtrl.text,
      "gender": selectedGender.title?.toLowerCase() ?? "",
      "timezone": timeZone(),
      // Format ("2000-01-01")
      "date_of_birth": "${yearCtrl.text}-$month-$day",
      // Format ("02:38:00")
      "time_of_birth": "$hours:$minute:$second",
      "place_of_birth": selectedCity?.name ?? "",
      "longitude": selectedCity?.location?.first,
      "latitude": selectedCity?.location?.last,
      "preferred_astrology": selectedAstrology == 1 ? "vedic" : "western"
    };
    await _editUserDetail(context: context, bodyData, isFromLogin: isFromLogin);
  }

  void initialDataFill(BuildContext context) {
    final _ = Provider.of<GlobalProvider>(context, listen: false);
    if (_.userModel != null) {
      firstNameCtrl.text = _.userModel!.firstName ?? "";
      lastNameCtrl.text = _.userModel!.lastName ?? "";
      if (_.userModel?.gender?.toLowerCase() == "female") {
        selectedGender = ConstantList.genderList.last;
      } else {
        selectedGender = ConstantList.genderList.first;
      }
      if (_.userModel?.dateOfBirth?.isNotEmpty ?? false) {
        final dateOfBirth = _.userModel?.dateOfBirth ?? "";
        List<String> dateParts = dateOfBirth.split('-');
        dateCtrl.text = dateParts.last;
        monthCtrl.text = dateParts[1];
        yearCtrl.text = dateParts.first;
      }
      if (_.userModel?.timeOfBirth?.isNotEmpty ?? false) {
        final timeOfBirth = _.userModel?.timeOfBirth ?? "";
        List<String> timeParts = timeOfBirth.split(':');
        hourCtrl.text = timeParts.first;
        minutesCtrl.text = timeParts[1];
        secondCtrl.text = timeParts.last;
      }
      locationCtrl.text = _.userModel?.placeOfBirth ?? "";
      selectedCity = PlacesData(
        name: _.userModel?.placeOfBirth ?? "",
        displayName: _.userModel?.placeOfBirth ?? "",
        location: [
          _.userModel?.latitude ?? 0,
          _.userModel?.longitude ?? 0,
        ],
      );
      selectedAstrology =
          _.userModel?.preferredAstrology.toString().toLowerCase() == "vedic"
              ? 1
              : 2;
    }
  }

  Timer? debounce;
  List<PlacesData> cities = [];
  PlacesData? selectedCity;

  onSearchChanged(String query) async {
    if (debounce?.isActive ?? false) debounce!.cancel();

    // Debounce to limit API calls after the user stops typing for 300ms
    debounce = Timer(const Duration(milliseconds: 300), () async {
      if (query.length >= 3) {
        // Make API call
        await getPlaces(query);
        cities = placeDataList;
        notifyListeners();
      } else {
        cities = [];
        notifyListeners();
      }
    });
  }

  onSelectCity(PlacesData city) {
    locationCtrl.text = city.displayName ?? "";
    selectedCity = city;
    placeDataList.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    locationCtrl.dispose();
    debounce?.cancel();
    super.dispose();
  }

  //Api Calling
  final UserRepository _userDetail = getIt.get<UserRepository>();

  Future<void> _editUserDetail(Map<String, dynamic> reqBody,
      {required BuildContext context, bool isFromLogin = false}) async {
    try {
      await showProgressDialog(context);
      log(reqBody.toString());
      final signUpModel = await _userDetail.editUserDetail(reqBody);
      Navigator.pop(context);
      if (signUpModel != null) {
        // Update provider with new user data so UI reflects changes immediately
        updateUser(signUpModel.data);

        // If you use a global user model, update it as well
        final globalProvider =
            Provider.of<GlobalProvider>(context, listen: false);
        // Convert UpdateUserData to UserData before updating globalProvider
        if (signUpModel.data != null) {
          globalProvider.updateUserModel(
            UserData(
              firstName: signUpModel.data?.firstName ?? "",
              lastName: signUpModel.data?.lastName ?? "",
              gender: signUpModel.data?.gender ?? "",
              dateOfBirth: signUpModel.data?.dateOfBirth ?? "",
              timeOfBirth: signUpModel.data?.timeOfBirth ?? "",
              placeOfBirth: signUpModel.data?.placeOfBirth ?? "",
              latitude: signUpModel.data?.latitude ?? 0,
              longitude: signUpModel.data?.longitude ?? 0,
              preferredAstrology: signUpModel.data?.preferredAstrology ?? "",
              // ...add other fields as needed...
            ),
          );
        }

        Provider.of<HomeProvider>(context, listen: false)
            .getUserDetail(context);

        log(reqBody.toString());
        if (isFromLogin) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => home.HomeScreen()));
          final SharedPreferences preferences = getIt.get<SharedPreferences>();
          await preferences.setBool("is_login", false);
        } else {
          Fluttertoast.showToast(msg: "Information Updated!");
        }
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await refreshToken();
        await _editUserDetail(
          reqBody,
          context: context,
        );
      }
    } catch (e) {
      Navigator.pop(context);
      log(e.toString());
    }
  }

  List<PlacesData> placeDataList = [];

  Future<void> getPlaces(String search) async {
    try {
      Map<String, dynamic> queryParams = {
        "q": search,
        "limit": 10,
        "exclude": ["address", "other_names"],
      };
      final searchResult = await _userDetail.getPlaces(queryParams);
      if (searchResult != null) {
        placeDataList = searchResult.data ?? [];
        notifyListeners();
      }
    } on DioException catch (e) {
      log("Dio Exception : ${e.error}");
      if (e.response?.statusCode == 401) {
        await refreshToken();
        await getPlaces(search);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void updateUser(dynamic userProfile) {
    // Update fields based on the new user profile data
    // Adjust field names/types as per your actual user model
    firstNameCtrl.text = userProfile?.firstName ?? "";
    lastNameCtrl.text = userProfile?.lastName ?? "";
    if (userProfile?.gender?.toLowerCase() == "female") {
      selectedGender = ConstantList.genderList.last;
    } else {
      selectedGender = ConstantList.genderList.first;
    }
    if (userProfile?.dateOfBirth?.isNotEmpty ?? false) {
      final dateOfBirth = userProfile?.dateOfBirth ?? "";
      List<String> dateParts = dateOfBirth.split('-');
      dateCtrl.text = dateParts.last;
      monthCtrl.text = dateParts[1];
      yearCtrl.text = dateParts.first;
    }
    if (userProfile?.timeOfBirth?.isNotEmpty ?? false) {
      final timeOfBirth = userProfile?.timeOfBirth ?? "";
      List<String> timeParts = timeOfBirth.split(':');
      hourCtrl.text = timeParts.first;
      minutesCtrl.text = timeParts[1];
      secondCtrl.text = timeParts.last;
    }
    locationCtrl.text = userProfile?.placeOfBirth ?? "";
    selectedCity = PlacesData(
      name: userProfile?.placeOfBirth ?? "",
      displayName: userProfile?.placeOfBirth ?? "",
      location: [
        userProfile?.latitude ?? 0,
        userProfile?.longitude ?? 0,
      ],
    );
    selectedAstrology =
        userProfile?.preferredAstrology.toString().toLowerCase() == "vedic"
            ? 1
            : 2;
    notifyListeners();
  }
}
//}
