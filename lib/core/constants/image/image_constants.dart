class ImageConstants {
  static ImageConstants _instance;

  static ImageConstants get instance {
    if (_instance == null) _instance = ImageConstants._init();
    return _instance;
  }

  ImageConstants._init();

  String get heartPulse => toPng("heartpulse");
  String get googleLogo => toPng("google_logo");
  String get splashLogo => toPng("splash");
  String get trFlag => toPng("tr_flag");
  String get ukFlag => toPng("uk_flag");

  String toPng(String name) => "assets/images/$name.png";
}
