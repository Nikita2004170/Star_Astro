class RazorpayVerify {
  RazorpayVerify({
    this.status,
    this.message,
    this.data,
  });

  RazorpayVerify.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? RazorpayVerifyData.fromJson(json['data']) : null;
  }

  String? status;
  String? message;
  RazorpayVerifyData? data;

  RazorpayVerify copyWith({
    String? status,
    String? message,
    RazorpayVerifyData? data,
  }) =>
      RazorpayVerify(
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

class RazorpayVerifyData {
  RazorpayVerifyData({
    this.status,
    this.id,
  });

  RazorpayVerifyData.fromJson(dynamic json) {
    status = json['status'];
    id = json['_id'];
  }

  String? status;
  String? id;

  RazorpayVerifyData copyWith({
    String? status,
    String? id,
  }) =>
      RazorpayVerifyData(
        status: status ?? this.status,
        id: id ?? this.id,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['_id'] = id;
    return map;
  }
}
