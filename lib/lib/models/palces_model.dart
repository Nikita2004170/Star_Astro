class PlacesModel {
  PlacesModel({
    this.status,
    this.message,
    this.data,
  });

  PlacesModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PlacesData.fromJson(v));
      });
    }
  }

  String? status;
  String? message;
  List<PlacesData>? data;

  PlacesModel copyWith({
    String? status,
    String? message,
    List<PlacesData>? data,
  }) =>
      PlacesModel(
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

class PlacesData {
  PlacesData({
    this.id,
    this.name,
    this.displayName,
    this.type,
    this.location,
  });

  PlacesData.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    displayName = json['display_name'];
    type = json['type'];
    location = json['location'] != null ? json['location'].cast<num>() : [];
  }

  String? id;
  String? name;
  String? displayName;
  String? type;
  List<num>? location;

  PlacesData copyWith({
    String? id,
    String? name,
    String? displayName,
    String? type,
    List<num>? location,
  }) =>
      PlacesData(
        id: id ?? this.id,
        name: name ?? this.name,
        displayName: displayName ?? this.displayName,
        type: type ?? this.type,
        location: location ?? this.location,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['display_name'] = displayName;
    map['type'] = type;
    map['location'] = location;
    return map;
  }
}
