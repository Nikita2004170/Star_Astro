class UpdateUserModel {
  UpdateUserModel({
    this.status,
    this.message,
    this.data,
  });

  UpdateUserModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UpdateUserData.fromJson(json['data']) : null;
  }

  String? status;
  String? message;
  UpdateUserData? data;

  UpdateUserModel copyWith({
    String? status,
    String? message,
    UpdateUserData? data,
  }) =>
      UpdateUserModel(
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

class UpdateUserData {
  UpdateUserData({
    this.fcmTokens,
    this.wallet,
    this.id,
    this.signinMethod,
    this.email,
    this.referralId,
    this.isVerified,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.lastLogin,
    this.mobile,
    this.dateOfBirth,
    this.firstName,
    this.gender,
    this.lastName,
    this.latitude,
    this.longitude,
    this.placeOfBirth,
    this.timeOfBirth,
    this.timezone,
    this.preferredAstrology,
  });

  UpdateUserData.fromJson(dynamic json) {
    fcmTokens = json['fcm_tokens'] != null
        ? FcmTokens.fromJson(json['fcm_tokens'])
        : null;
    wallet = json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null;
    id = json['_id'];
    signinMethod = json['signin_method'];
    email = json['email'];
    referralId = json['referralId'];
    isVerified = json['is_verified'];
    profileImage = json['profile_image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    lastLogin = json['last_login'];
    mobile = json['mobile'];
    dateOfBirth = json['date_of_birth'];
    firstName = json['first_name'];
    gender = json['gender'];
    lastName = json['last_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    placeOfBirth = json['place_of_birth'];
    timeOfBirth = json['time_of_birth'];
    timezone = json['timezone'];
    preferredAstrology = json['preferred_astrology'];
  }

  FcmTokens? fcmTokens;
  Wallet? wallet;
  String? id;
  String? signinMethod;
  String? email;
  String? referralId;
  bool? isVerified;
  String? profileImage;
  String? createdAt;
  String? updatedAt;
  num? v;
  String? lastLogin;
  String? mobile;
  String? dateOfBirth;
  String? firstName;
  String? gender;
  String? lastName;
  num? latitude;
  num? longitude;
  String? placeOfBirth;
  String? timeOfBirth;
  num? timezone;
  String? preferredAstrology;

  UpdateUserData copyWith({
    FcmTokens? fcmTokens,
    Wallet? wallet,
    String? id,
    String? signinMethod,
    String? email,
    String? referralId,
    bool? isVerified,
    String? profileImage,
    String? createdAt,
    String? updatedAt,
    num? v,
    String? lastLogin,
    String? mobile,
    String? dateOfBirth,
    String? firstName,
    String? gender,
    String? lastName,
    num? latitude,
    num? longitude,
    String? placeOfBirth,
    String? timeOfBirth,
    num? timezone,
    String? preferredAstrology,
  }) =>
      UpdateUserData(
        fcmTokens: fcmTokens ?? this.fcmTokens,
        wallet: wallet ?? this.wallet,
        id: id ?? this.id,
        signinMethod: signinMethod ?? this.signinMethod,
        email: email ?? this.email,
        referralId: referralId ?? this.referralId,
        isVerified: isVerified ?? this.isVerified,
        profileImage: profileImage ?? this.profileImage,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        lastLogin: lastLogin ?? this.lastLogin,
        mobile: mobile ?? this.mobile,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        firstName: firstName ?? this.firstName,
        gender: gender ?? this.gender,
        lastName: lastName ?? this.lastName,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        placeOfBirth: placeOfBirth ?? this.placeOfBirth,
        timeOfBirth: timeOfBirth ?? this.timeOfBirth,
        timezone: timezone ?? this.timezone,
        preferredAstrology: preferredAstrology ?? this.preferredAstrology,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (fcmTokens != null) {
      map['fcm_tokens'] = fcmTokens?.toJson();
    }
    if (wallet != null) {
      map['wallet'] = wallet?.toJson();
    }
    map['_id'] = id;
    map['signin_method'] = signinMethod;
    map['email'] = email;
    map['referralId'] = referralId;
    map['is_verified'] = isVerified;
    map['profile_image'] = profileImage;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['last_login'] = lastLogin;
    map['mobile'] = mobile;
    map['date_of_birth'] = dateOfBirth;
    map['first_name'] = firstName;
    map['gender'] = gender;
    map['last_name'] = lastName;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['place_of_birth'] = placeOfBirth;
    map['time_of_birth'] = timeOfBirth;
    map['timezone'] = timezone;
    map['preferred_astrology'] = preferredAstrology;
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
    this.web,
  });

  FcmTokens.fromJson(dynamic json) {
    web = json['web'] != null ? Web.fromJson(json['web']) : null;
  }

  Web? web;

  FcmTokens copyWith({
    Web? web,
  }) =>
      FcmTokens(
        web: web ?? this.web,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
