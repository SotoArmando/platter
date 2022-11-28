import 'dart:io';

class AdHelper {
  // static String get bannerAdUnitId {
  //   if (Platform.isAndroid) {
  //     return "ca-app-pub-6964849932542974/8150898353";
  //   } else if (Platform.isIOS) {
  //     return "ca-app-pub-6964849932542974/2295936447";
  //   } else {
  //     throw UnsupportedError("Unsupported platform");
  //   }
  // }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6964849932542974/8150898353";
    } else if (Platform.isIOS) {
      return "ca-app-pub-6964849932542974/2295936447";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
