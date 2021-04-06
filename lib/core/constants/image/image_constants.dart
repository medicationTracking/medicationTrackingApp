class ImageConstants {
  static ImageConstants _instance;

  static ImageConstants get instance {
    if (_instance == null) _instance = ImageConstants._init();
    return _instance;
  }

  ImageConstants._init();

  String get heartPulse => toPng("heartpulse");
  String get googleLogo => toPng("google_logo");

  String toPng(String name) => "assets/images/$name.png";
}
