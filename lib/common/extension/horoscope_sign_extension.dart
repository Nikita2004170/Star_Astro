import '../utils/images.dart';

extension HoroscopeSignExtension on String {
  String getHoroscopeSign() {
    return switch (toLowerCase()) {
      "aquarius" => Images.aquarius,
      "aries" => Images.aries,
      "cancer" => Images.cancer,
      "capricorn" => Images.capricorn,
      "gemini" => Images.gemini,
      "leo" => Images.leo,
      "libra" => Images.libra,
      "pisces" => Images.pisces,
      "sagittarius" => Images.sagittarius,
      "scorpio" => Images.scorpio,
      "taurus" => Images.taurus,
      "virgo" => Images.virgo,
      _ => "",
    };
  }
}
