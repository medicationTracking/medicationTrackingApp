import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/constants/app_constants/app_constants.dart';
import 'package:medication_app_v0/core/constants/navigation/navigation_constants.dart';
import 'package:mobx/mobx.dart';
import 'package:easy_localization/easy_localization.dart';

part 'splash_viewmodel.g.dart';

class SplashViewModel = _SplashViewModelBase with _$SplashViewModel;

abstract class _SplashViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {}

  void navigateLogin() {
    navigation.navigateToPage(path: NavigationConstants.LOGIN_VIEW);
  }

  @action
  void changeLanguage(BuildContext context) {
    if (context.locale.countryCode
            .compareTo(AppConstants.EN_LOCALE.countryCode) ==
        0) {
      context.setLocale(AppConstants.TR_LOCALE);
    } else if (context.locale.countryCode
            .compareTo(AppConstants.TR_LOCALE.countryCode) ==
        0) {
      context.setLocale(AppConstants.EN_LOCALE);
    }
  }
}