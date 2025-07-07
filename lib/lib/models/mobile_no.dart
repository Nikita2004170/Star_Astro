import 'package:star_astro/lib/models/base_model.dart';

class MobileNoModel extends BaseModel {
  @override
  String? message;
  Data? data;

  MobileNoModel({this.message, this.data});

  MobileNoModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? messageId;

  Data({this.messageId});

  Data.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messageId'] = messageId;
    return data;
  }
}
