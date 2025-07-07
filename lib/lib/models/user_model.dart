class UserModel {
  UserModel({
    this.status,
    this.message,
    this.data,
  });

  UserModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  String? status;
  String? message;
  UserData? data;

  UserModel copyWith({
    String? status,
    String? message,
    UserData? data,
  }) =>
      UserModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class UserData {
  UserData({
    this.signinMethod,
    this.email,
    this.referralId,
    this.mobile,
    this.isVerified,
    this.otp,
    this.otpCreatedAt,
    this.firstName,
    this.lastName,
    this.gender,
    this.timezone,
    this.dateOfBirth,
    this.timeOfBirth,
    this.placeOfBirth,
    this.longitude,
    this.latitude,
    this.preferredAstrology,
    this.fcmTokens,
    this.profileImage,
    this.wallet,
    this.lastLogin,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  UserData.fromJson(dynamic json) {
    signinMethod = json['signin_method'];
    email = json['email'];
    referralId = json['referralId'];
    mobile = json['mobile'];
    isVerified = json['is_verified'];
    otp = json['otp'];
    otpCreatedAt = json['otp_created_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    timezone = json['timezone'];
    dateOfBirth = json['date_of_birth'];
    timeOfBirth = json['time_of_birth'];
    placeOfBirth = json['place_of_birth'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    preferredAstrology = json['preferred_astrology'];
    fcmTokens = json['fcm_tokens'] != null
        ? FcmTokens.fromJson(json['fcm_tokens'])
        : null;
    profileImage = json['profile_image'];
    wallet = json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null;
    lastLogin = json['last_login'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  String? signinMethod;
  String? email;
  String? referralId;
  String? mobile;
  bool? isVerified;
  num? otp;
  String? otpCreatedAt;
  String? firstName;
  String? lastName;
  String? gender;
  num? timezone;
  String? dateOfBirth;
  String? timeOfBirth;
  String? placeOfBirth;
  num? longitude;
  num? latitude;
  String? preferredAstrology;
  FcmTokens? fcmTokens;
  String? profileImage;
  Wallet? wallet;
  String? lastLogin;
  String? id;
  String? createdAt;
  String? updatedAt;

  UserData copyWith({
    String? signinMethod,
    String? email,
    String? referralId,
    String? mobile,
    bool? isVerified,
    num? otp,
    String? otpCreatedAt,
    String? firstName,
    String? lastName,
    String? gender,
    num? timezone,
    String? dateOfBirth,
    String? timeOfBirth,
    String? placeOfBirth,
    num? longitude,
    num? latitude,
    String? preferredAstrology,
    FcmTokens? fcmTokens,
    String? profileImage,
    Wallet? wallet,
    String? lastLogin,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) =>
      UserData(
        signinMethod: signinMethod ?? this.signinMethod,
        email: email ?? this.email,
        referralId: referralId ?? this.referralId,
        mobile: mobile ?? this.mobile,
        isVerified: isVerified ?? this.isVerified,
        otp: otp ?? this.otp,
        otpCreatedAt: otpCreatedAt ?? this.otpCreatedAt,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        gender: gender ?? this.gender,
        timezone: timezone ?? this.timezone,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        timeOfBirth: timeOfBirth ?? this.timeOfBirth,
        placeOfBirth: placeOfBirth ?? this.placeOfBirth,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        preferredAstrology: preferredAstrology ?? this.preferredAstrology,
        fcmTokens: fcmTokens ?? this.fcmTokens,
        profileImage: profileImage ?? this.profileImage,
        wallet: wallet ?? this.wallet,
        lastLogin: lastLogin ?? this.lastLogin,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['signin_method'] = signinMethod;
    map['email'] = email;
    map['referralId'] = referralId;
    map['mobile'] = mobile;
    map['is_verified'] = isVerified;
    map['otp'] = otp;
    map['otp_created_at'] = otpCreatedAt;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['gender'] = gender;
    map['timezone'] = timezone;
    map['date_of_birth'] = dateOfBirth;
    map['time_of_birth'] = timeOfBirth;
    map['place_of_birth'] = placeOfBirth;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    map['preferred_astrology'] = preferredAstrology;
    if (fcmTokens != null) {
      map['fcm_tokens'] = fcmTokens?.toJson();
    }
    map['profile_image'] = profileImage;
    if (wallet != null) {
      map['wallet'] = wallet?.toJson();
    }
    map['last_login'] = lastLogin;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}

class Wallet {
  Wallet({
    this.balance,
    this.expiresOn,
  });

  Wallet.fromJson(dynamic json) {
    balance = json['balance'];
    expiresOn = json['expiresOn'];
  }

  num? balance;
  String? expiresOn;

  Wallet copyWith({
    num? balance,
    String? expiresOn,
  }) =>
      Wallet(
        balance: balance ?? this.balance,
        expiresOn: expiresOn ?? this.expiresOn,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['balance'] = balance;
    map['expiresOn'] = expiresOn;
    return map;
  }
}

class FcmTokens {
  FcmTokens({
    this.mobile,
    this.web,
  });

  FcmTokens.fromJson(dynamic json) {
    mobile = json['mobile'] != null ? Mobile.fromJson(json['mobile']) : null;
    web = json['web'] != null ? Web.fromJson(json['web']) : null;
  }

  Mobile? mobile;
  Web? web;

  FcmTokens copyWith({
    Mobile? mobile,
    Web? web,
  }) =>
      FcmTokens(
        mobile: mobile ?? this.mobile,
        web: web ?? this.web,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (mobile != null) {
      map['mobile'] = mobile?.toJson();
    }
    if (web != null) {
      map['web'] = web?.toJson();
    }
    return map;
  }
}

class Web {
  Web({
    this.token,
    this.updatedAt,
    this.id,
  });

  Web.fromJson(dynamic json) {
    token = json['token'];
    updatedAt = json['updated_at'];
    id = json['_id'];
  }

  String? token;
  String? updatedAt;
  String? id;

  Web copyWith({
    String? token,
    String? updatedAt,
    String? id,
  }) =>
      Web(
        token: token ?? this.token,
        updatedAt: updatedAt ?? this.updatedAt,
        id: id ?? this.id,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['updated_at'] = updatedAt;
    map['_id'] = id;
    return map;
  }
}

class Mobile {
  Mobile({
    this.token,
    this.updatedAt,
    this.id,
  });

  Mobile.fromJson(dynamic json) {
    token = json['token'];
    updatedAt = json['updated_at'];
    id = json['_id'];
  }

  String? token;
  String? updatedAt;
  String? id;

  Mobile copyWith({
    String? token,
    String? updatedAt,
    String? id,
  }) =>
      Mobile(
        token: token ?? this.token,
        updatedAt: updatedAt ?? this.updatedAt,
        id: id ?? this.id,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['updated_at'] = updatedAt;
    map['_id'] = id;
    return map;
  }
}
