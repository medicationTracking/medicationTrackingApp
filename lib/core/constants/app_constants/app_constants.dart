import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppConstants {
  static const TR_LOCALE = Locale("tr", "TR");
  static const EN_LOCALE = Locale("en", "US");
  static const LANG_PATH = 'assets/lang';
  static const SUPPORTED_LOCALES = [EN_LOCALE, TR_LOCALE];
  static const TURKEY_CENTER_LAT_LONG = LatLng(38.9637, 35.2433);
}
