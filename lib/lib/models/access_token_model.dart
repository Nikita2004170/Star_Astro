class AccessTokenModel {
  AccessTokenModel({
    this.status,
    this.message,
    this.data,
  });

  AccessTokenModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? AccessTokenData.fromJson(json['data']) : null;
  }

  String? status;
  String? message;
  AccessTokenData? data;

  AccessTokenModel copyWith({
    String? status,
    String? message,
    AccessTokenData? data,
  }) =>
      AccessTokenModel(
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

class AccessTokenData {
  AccessTokenData({
    this.accessToken,
  });

  AccessTokenData.fromJson(dynamic json) {
    accessToken = json['accessToken'];
  }

  String? accessToken;

  AccessTokenData copyWith({
    String? accessToken,
  }) =>
      AccessTokenData(
        accessToken: accessToken ?? this.accessToken,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = accessToken;
    return map;
  }
}
