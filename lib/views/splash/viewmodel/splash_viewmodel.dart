import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/constants/app_constants/app_constants.dart';
import 'package:medication_app_v0/core/constants/enums/shared_preferences_enum.dart';
import 'package:medication_app_v0/core/constants/navigation/navigation_constants.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

part 'splash_viewmodel.g.dart';

class SplashViewModel = _SplashViewModelBase with _$SplashViewModel;

abstract class _SplashViewModelBase with Store, BaseViewModel {
  SharedPreferences sharedPreferences;
  void setContext(BuildContext context) => this.context = context;
  void init() {
    initSharedPreferences();
    //String currentLocaleString = context.locale.toString();
    //sharedPreferences.setString(
    //   SharedPreferencesEnum.LOCALE.toString(), context.locale.toString());
    //print("${context.locale}");
    //currentLocaleString.split("_");
    //context.locale = Locale(currentLocaleString[0], currentLocaleString[1]);
  }

  Future initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void navigateLogin() {
    navigation.navigateToPage(path: NavigationConstants.LOGIN_VIEW);
  }

  @action
  void changeLanguageOnPress(BuildContext context) {
    if (context.locale.countryCode
            .compareTo(AppConstants.EN_LOCALE.countryCode) ==
        0)
      context.setLocale(AppConstants.TR_LOCALE);
    else if (context.locale.countryCode
            .compareTo(AppConstants.TR_LOCALE.countryCode) ==
        0) context.setLocale(AppConstants.EN_LOCALE);

    sharedPreferences.setString(
        SharedPreferencesEnum.LOCALE.toString(), context.locale.toString());
  }
}
