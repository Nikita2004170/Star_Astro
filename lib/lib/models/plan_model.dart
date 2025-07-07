class PlanModel {
  PlanModel({
    this.status,
    this.message,
    this.data,
  });

  PlanModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PlanData.fromJson(v));
      });
    }
  }

  String? status;
  String? message;
  List<PlanData>? data;

  PlanModel copyWith({
    String? status,
    String? message,
    List<PlanData>? data,
  }) =>
      PlanModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class PlanData {
  PlanData({
    this.name,
    this.priceInr,
    this.priceUsd,
    this.noOfCredit,
  });

  PlanData.fromJson(dynamic json) {
    name = json['name'];
    priceInr = json['price_inr'];
    priceUsd = json['price_usd'];
    noOfCredit = json['no_of_credit'];
  }

  String? name;
  num? priceInr;
  num? priceUsd;
  num? noOfCredit;

  PlanData copyWith({
    String? name,
    num? priceInr,
    num? priceUsd,
    num? noOfCredit,
  }) =>
      PlanData(
        name: name ?? this.name,
        priceInr: priceInr ?? this.priceInr,
        priceUsd: priceUsd ?? this.priceUsd,
        noOfCredit: noOfCredit ?? this.noOfCredit,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['price_inr'] = priceInr;
    map['price_usd'] = priceUsd;
    map['no_of_credit'] = noOfCredit;
    return map;
  }
}
