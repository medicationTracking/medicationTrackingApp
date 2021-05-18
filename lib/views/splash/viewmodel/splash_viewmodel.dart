import 'package:firebase_auth/firebase_auth.dart';
import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/constants/app_constants/app_constants.dart';
import 'package:medication_app_v0/core/constants/navigation/navigation_constants.dart';
import 'package:mobx/mobx.dart';
import 'package:easy_localization/easy_localization.dart';

part 'splash_viewmodel.g.dart';

class SplashViewModel = _SplashViewModelBase with _$SplashViewModel;

abstract class _SplashViewModelBase with Store, BaseViewModel {
  @observable
  bool isLoading = false;
  void setContext(BuildContext context) => this.context = context;
  void init() {
    asyncInit();
  }

  Future<void> asyncInit() async {
    await Future.delayed(Duration(seconds: 2));
    await Future.microtask(() => splashLoginButtonOnPress());
  }
  void navigateLogin() {
    navigation.navigateToPageClear(path: NavigationConstants.LOGIN_VIEW);
  }

  void navigateHome() {
    navigation.navigateToPageClear(path: NavigationConstants.HOME_VIEW);
  }

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

  Future<void> splashLoginButtonOnPress() async {
    FirebaseAuth.instance.currentUser == null
        ? navigateLogin()
        : navigateHome();
  }

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }
}
