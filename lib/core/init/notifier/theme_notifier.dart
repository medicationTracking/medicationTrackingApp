import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/constants/enums/app_theme_enum.dart';
import 'package:medication_app_v0/core/init/theme/app_theme_light.dart';

class ThemeNotifier extends ChangeNotifier{
  ThemeData get currentTheme => _currentTheme;
  ThemeData _currentTheme= AppThemeLight.instance.theme;
  void changeTheme(AppThemes theme){
    if(theme == AppThemes.LIGHT){
      _currentTheme = AppThemeLight.instance.theme;
    }
    else if(theme == AppThemes.DARK){
      _currentTheme = ThemeData.dark();
    }
    notifyListeners();
  }
}