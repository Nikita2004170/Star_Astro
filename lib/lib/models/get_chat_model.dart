class Wallet {

  int? balance;
  String? expiresOn;

  Wallet({
    this.balance,
    this.expiresOn,
  });
  Wallet.fromJson(Map<String, dynamic> json) {
    balance = json['balance']?.toInt();
    expiresOn = json['expiresOn']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['balance'] = balance;
    data['expiresOn'] = expiresOn;
    return data;
  }
}

class GetChatUtil {
  String? role;
  String? text;
  String? Id;
  String? createdAt;
  String? updatedAt;

  GetChatUtil({
    this.role,
    this.text,
    this.Id,
    this.createdAt,
    this.updatedAt,
  });
  GetChatUtil.fromJson(Map<String, dynamic> json) {
    role = json['role']?.toString();
    text = json['text']?.toString();
    Id = json['_id']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['role'] = role;
    data['text'] = text;
    data['_id'] = Id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class GetChatDataModel {
  String? user;
  String? title;
  List<GetChatUtil>? chats;
  String? Id;
  String? createdAt;
  String? updatedAt;
  Wallet? wallet;
  GetChatDataModel({
    this.user,
    this.title,
    this.chats,
    this.Id,
    this.createdAt,
    this.updatedAt,
    this.wallet,
  });
  GetChatDataModel.fromJson(Map<String, dynamic> json) {
    user = json['user']?.toString();
    title = json['title']?.toString();
    if (json['chats'] != null) {
      final v = json['chats'];
      final arr0 = <GetChatUtil>[];
      v.forEach((v) {
        arr0.add(GetChatUtil.fromJson(v));
      });
      chats = arr0;
    }
    Id = json['_id']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    wallet = (json['wallet'] != null) ? Wallet.fromJson(json['wallet']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user'] = user;
    data['title'] = title;
    if (chats != null) {
      final v = chats;
      final arr0 = [];
      v?.forEach((v) {
        arr0.add(v.toJson());
      });
      data['chats'] = arr0;
    }
    data['_id'] = Id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (wallet != null) {
      data['wallet'] = wallet?.toJson();
    }
    return data;
  }
}

class GetChatModel {
  String? status;
  String? message;
  GetChatDataModel? data;

  GetChatModel({
    this.status,
    this.message,
    this.data,
  });
  GetChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    message = json['message']?.toString();
    data =
        (json['data'] != null) ? GetChatDataModel.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data?.toJson();
      return data;
  }
}
