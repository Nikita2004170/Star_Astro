// class PostChatModel {

//   String? question;
//   String? aiType;

//   PostChatModel({
//     this.question,
//     this.aiType,
//   });
//   PostChatModel.fromJson(Map<String, dynamic> json) {
//     question = json['question']?.toString();
//     aiType = json['ai_type']?.toString();
//   }
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['question'] = question;
//     data['ai_type'] = aiType;
//     return data;
//   }
// }

import 'package:star_astro/lib/models/partner_detail_model.dart';

// FIX: Rename to match the used model name
class PostChatModel {
  String? question;
  String? aiType;
  PartnerDetailsModel? partnerDetails; // <- renamed to match

  PostChatModel({
    this.question,
    this.aiType,
    this.partnerDetails,
  });

  factory PostChatModel.fromJson(Map<String, dynamic> json) {
    return PostChatModel(
      question: json['question'],
      aiType: json['ai_type'],
      // partnerDetails: json['partner_details'] != null
      //     ? PartnerDetailsModel.fromJson(json['partner_details'])
      //     : null,
    );
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'question': question,
      'ai_type': aiType,
    };

    // Include partner_details ONLY if aiType is 'relationship' and partnerDetails is not null
    if (aiType == 'relationship' && partnerDetails != null) {
      data['partner_details'] = partnerDetails!.toJson();
    }

    return data;
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'question': question,
  //     'ai_type': aiType,
  //     'partner_details': partnerDetails!.toJson(),
  //   };
  // }
}

// class PartnerDetailsModel {
//   String? gender;
//   String? dateOfBirth;
//   String? timeOfBirth;
//   double? longitude;
//   double? latitude;

//   PartnerDetailsModel({
//     this.gender,
//     this.dateOfBirth,
//     this.timeOfBirth,
//     this.longitude,
//     this.latitude,
//   });

//   factory PartnerDetailsModel.fromJson(Map<String, dynamic> json) {
//     return PartnerDetailsModel(
//       gender: json['gender'],
//       dateOfBirth: json['date_of_birth'],
//       timeOfBirth: json['time_of_birth'],
//       longitude: json['longitude']?.toDouble(),
//       latitude: json['latitude']?.toDouble(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'gender': gender,
//       'date_of_birth': dateOfBirth,
//       'time_of_birth': timeOfBirth,
//       'longitude': longitude,
//       'latitude': latitude,
//     };
//   }
// }
