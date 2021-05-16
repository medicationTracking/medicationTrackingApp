import 'package:medication_app_v0/core/constants/navigation/navigation_constants.dart';

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
<<<<<<< HEAD
  String get pill1Logo => toPng("pill1");
  String get pill2Logo => toPng("pill2");
  String get pill4Logo => toPng("pill4");
  String get pill3Logo => toPng("pill3");
=======
  String get profileAvatar => toPng("profile_avatar");
>>>>>>> account_page

  String toPng(String name) => "assets/images/$name.png";
}
