class StringResource {
  static String get noInternet => getString('noInternet');

  static String get connectivityError => getString('connectivityError');

  static String get somethingWrong => getString('somethingWrong');

  static String getString(key) {
    try {
      return key;
    } catch (e) {
      return "Something went wrong";
    }
  }
}
