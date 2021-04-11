import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';

import 'color_theme.dart';

class AppThemeLight extends AppTheme {
  static AppThemeLight _instance = AppThemeLight._init();
  static AppThemeLight get instance => _instance;
  AppThemeLight._init();

  ThemeData get theme {
    return ThemeData(
        primaryColor: ColorTheme.PRIMARY_BLUE,
        //fontFamily: AppConstants.FONT_SOURCE_SANS,
        scaffoldBackgroundColor: ColorTheme.GREY_LIGHT,
        bottomAppBarTheme: BottomAppBarTheme(
          color: ColorTheme.BACKGROUND_WHITE,
          shape: CircularNotchedRectangle(),
        ),
        primaryIconTheme: IconThemeData(color: ColorTheme.PRIMARY_BLUE),
        cursorColor: ColorTheme.PRIMARY_RED,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: ColorTheme.PRIMARY_BLUE),
        colorScheme: colorScheme(),
        focusColor: ColorTheme.BACKGROUND_WHITE,
        //inputDecorationTheme: AppInputTheme.instance.buildInputDecorationTheme,
        tabBarTheme: tabBarTheme(),
        errorColor: ColorTheme.PRIMARY_RED,
        //textTheme: _textTheme,
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: ColorTheme.GREY_LIGHT,
          iconTheme: IconThemeData(color: Colors.black),
          brightness: Brightness.light,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(ColorTheme
                    .PRIMARY_BLUE) // TODO HAL�L BURAYA BAKARSAN SEN�N BUTONLARIN RENG�N� ANLARSIN
                )),
        //primaryTextTheme: _primaryTextTheme,
        iconTheme: IconThemeData(color: ColorTheme.PRIMARY_BLUE),
        buttonTheme: buttonThemeData(),
        inputDecorationTheme: InputDecorationTheme(
            filled: true, fillColor: ColorTheme.BACKGROUND_WHITE));
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

class AppTheme {
  ThemeData theme; //gereksiz gibi düşünmek lazım
}
