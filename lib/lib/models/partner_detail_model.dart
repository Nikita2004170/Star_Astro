class PartnerDetailsModel {
  final String gender;
  final String dateOfBirth; // Format: YYYY-MM-DD
  dynamic timeOfBirth; // Format: HH:MM:SS
  final double longitude;
  final double latitude;
  final double timezone;

  PartnerDetailsModel({
    required this.gender,
    required this.dateOfBirth,
    required this.timeOfBirth,
    required this.longitude,
    required this.latitude,
    required this.timezone,
  });

  Map<String, dynamic> toJson() {
    return {
      "gender": gender,
      "date_of_birth": dateOfBirth,
      "time_of_birth": timeOfBirth,
      "longitude": longitude,
      "latitude": latitude,
      "timezone": timezone,
    };
  }

  factory PartnerDetailsModel.fromJson(Map<String, dynamic> json) {
    return PartnerDetailsModel(
      gender: json["gender"] ?? '',
      dateOfBirth: json["date_of_birth"] ?? '',
      timeOfBirth: json["time_of_birth"] ?? '',
      longitude: (json["longitude"] as num?)?.toDouble() ?? 0.0,
      latitude: (json["latitude"] as num?)?.toDouble() ?? 0.0,
      timezone: (json["timezone"] as num?)?.toDouble() ?? 0.0,
    );
  }
}
