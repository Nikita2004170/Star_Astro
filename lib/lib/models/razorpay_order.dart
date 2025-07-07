class RazorpayOrder {
  RazorpayOrder({
    this.status,
    this.message,
    this.data,
  });

  RazorpayOrder.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? RazorpayOrderData.fromJson(json['data']) : null;
  }

  String? status;
  String? message;
  RazorpayOrderData? data;

  RazorpayOrder copyWith({
    String? status,
    String? message,
    RazorpayOrderData? data,
  }) =>
      RazorpayOrder(
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

class RazorpayOrderData {
  RazorpayOrderData({
    this.user,
    this.amount,
    this.currency,
    this.promoCode,
    this.discountFactor,
    this.netAmount,
    this.credits,
    this.paymentGateway,
    this.status,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.orderId,
  });

  RazorpayOrderData.fromJson(dynamic json) {
    user = json['user'];
    amount = json['amount'];
    currency = json['currency'];
    promoCode = json['promo_code'];
    discountFactor = json['discount_factor'];
    netAmount = json['net_amount'];
    credits = json['credits'];
    paymentGateway = json['payment_gateway'];
    status = json['status'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    orderId = json['order_id'];
  }

  String? user;
  num? amount;
  String? currency;
  String? promoCode;
  num? discountFactor;
  num? netAmount;
  num? credits;
  String? paymentGateway;
  String? status;
  String? id;
  String? createdAt;
  String? updatedAt;
  num? v;
  String? orderId;

  RazorpayOrderData copyWith({
    String? user,
    num? amount,
    String? currency,
    String? promoCode,
    num? discountFactor,
    num? netAmount,
    num? credits,
    String? paymentGateway,
    String? status,
    String? id,
    String? createdAt,
    String? updatedAt,
    num? v,
    String? orderId,
  }) =>
      RazorpayOrderData(
        user: user ?? this.user,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
        promoCode: promoCode ?? this.promoCode,
        discountFactor: discountFactor ?? this.discountFactor,
        netAmount: netAmount ?? this.netAmount,
        credits: credits ?? this.credits,
        paymentGateway: paymentGateway ?? this.paymentGateway,
        status: status ?? this.status,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        orderId: orderId ?? this.orderId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = user;
    map['amount'] = amount;
    map['currency'] = currency;
    map['promo_code'] = promoCode;
    map['discount_factor'] = discountFactor;
    map['net_amount'] = netAmount;
    map['credits'] = credits;
    map['payment_gateway'] = paymentGateway;
    map['status'] = status;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['order_id'] = orderId;
    return map;
  }
}
