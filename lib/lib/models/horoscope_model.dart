// class HoroscopeModel {
//   HoroscopeModel({
//     this.status,
//     this.message,
//     this.data,
//   });

//   HoroscopeModel.fromJson(dynamic json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? HoroscopeData.fromJson(json['data']) : null;
//   }

//   String? status;
//   String? message;
//   HoroscopeData? data;

//   HoroscopeModel copyWith({
//     String? status,
//     String? message,
//     HoroscopeData? data,
//   }) =>
//       HoroscopeModel(
//         status: status ?? this.status,
//         message: message ?? this.message,
//         data: data ?? this.data,
//       );

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['message'] = message;
//     if (data != null) {
//       map['data'] = data?.toJson();
//     }
//     return map;
//   }
// }

// class HoroscopeData {
//   HoroscopeData({
//     this.sign,
//     this.date,
//     this.prediction,
//   });

//   HoroscopeData.fromJson(dynamic json) {
//     sign = json['sign'];
//     date = json['date'];
//     prediction = json['prediction'];
//   }

//   String? sign;
//   String? date;
//   String? prediction;

//   HoroscopeData copyWith({
//     String? sign,
//     String? date,
//     String? prediction,
//   }) =>
//       HoroscopeData(
//         sign: sign ?? this.sign,
//         date: date ?? this.date,
//         prediction: prediction ?? this.prediction,
//       );

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['sign'] = sign;
//     map['date'] = date;
//     map['prediction'] = prediction;
//     return map;
//   }
// }
class HoroscopeModel {
  String? status;
  String? message;
  HoroscopeData? data;

  HoroscopeModel({this.status, this.message, this.data});

  HoroscopeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? HoroscopeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class HoroscopeData {
  String? sign;
  String? date;
  String? prediction;

  HoroscopeData({this.sign, this.date, this.prediction});

  HoroscopeData.fromJson(Map<String, dynamic> json) {
    sign = json['sign'];
    date = json['date'];
    prediction = json['prediction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sign'] = sign;
    data['date'] = date;
    data['prediction'] = prediction;
    return data;
  }
}
