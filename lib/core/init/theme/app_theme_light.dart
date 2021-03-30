import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/init/theme/app_theme.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';

class AppThemeLight extends AppTheme{
 static AppThemeLight _instance =  AppThemeLight._init();
 static AppThemeLight get instance => _instance;
 AppThemeLight._init();

 ThemeData get theme {
  return ThemeData(
      primaryColor: ColorTheme.GREY_HUNTER,
      //fontFamily: AppConstants.FONT_SOURCE_SANS,
      scaffoldBackgroundColor: ColorTheme.GREY_LIGHT,
      cursorColor: ColorTheme.PRIMARY_RED,
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: ColorTheme.PRIMARY_RED),
      colorScheme: colorScheme(),
      //inputDecorationTheme: AppInputTheme.instance.buildInputDecorationTheme,
      tabBarTheme: tabBarTheme(),
      errorColor: ColorTheme.PRIMARY_RED,
      //textTheme: _textTheme,
      appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
      iconTheme: IconThemeData(color: ColorTheme.GREY_DARK),
      brightness: Brightness.light),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:MaterialStateProperty.all<Color>(ColorTheme.GREY_DARK) // TODO HALÝL BURAYA BAKARSAN SENÝN BUTONLARIN RENGÝNÝ ANLARSIN
        )
      ),
      //primaryTextTheme: _primaryTextTheme,
      buttonTheme: buttonThemeData(),
    );
 }

 ColorScheme colorScheme() {
  return ColorScheme.light(
      error: ColorTheme.PRIMARY_RED,
      onBackground: ColorTheme.INPUT_BORDER_COLOR,
      onSurface: ColorTheme.GREY_DARK,
      secondary: Colors.white,
      onPrimary: ColorTheme.GREY_LIGHT,
      secondaryVariant: ColorTheme.GREY_HINT,
      onError: Colors.yellow);
 }

 ButtonThemeData buttonThemeData() {
  return ButtonThemeData(
   padding: EdgeInsets.all(20),
   colorScheme: ColorScheme.light(
    primary: ColorTheme.RED_BUTTON,
    surface: Colors.white,
    secondaryVariant: ColorTheme.GREY_HINT,
    secondary: ColorTheme.GREY_HINT,
   ),
  );
 }

 TabBarTheme tabBarTheme() {
  return TabBarTheme(
   labelPadding: EdgeInsets.all(5),
   //labelStyle: _textTheme.headline5.copyWith(fontWeight: FontWeight.bold),
   //unselectedLabelStyle: _textTheme.subtitle1.copyWith(fontSize: AppTextTheme.instance.buildSubtitle2.fontSize),
   labelColor: ColorTheme.GREY_DARK,
   indicator: BoxDecoration(border: Border.all(style: BorderStyle.none)),
   unselectedLabelColor: ColorTheme.GREY_HUNTER.withOpacity(0.5),
  );
 }
}