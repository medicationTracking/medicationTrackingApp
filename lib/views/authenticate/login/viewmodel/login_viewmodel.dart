import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medication_app_v0/core/constants/app_constants/app_constants.dart';
import 'package:medication_app_v0/core/constants/navigation/navigation_constants.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';
import 'package:medication_app_v0/core/init/services/auth_manager.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';
part 'login_viewmodel.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> formState;
  GlobalKey<ScaffoldState> scaffoldState;
  TextEditingController mailController;
  TextEditingController passwordController;

  @observable
  bool isLoading = false;
  @observable
  bool isPasswordVisible = false;

  void setContext(BuildContext context) => this.context = context;
  void init() async {
    changeLoading();
    mailController = TextEditingController();
    passwordController = TextEditingController();
    scaffoldState = GlobalKey();
    formState = GlobalKey();
    changeLoading();
  }

  void dispose() {
    mailController.dispose();
    passwordController.dispose();
  }

  @action
  void seePassword() {
    isPasswordVisible = !isPasswordVisible;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return LocaleKeys.authentication_MAIL_ERROR_TEXT.locale;
    else
      return null;
  }

  void navigateSingupPage() {
    navigation.navigateToPage(path: NavigationConstants.SIGNUP_VIEW);
  }

  void changeLanguageOnPress(BuildContext context) {
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

  void navigateHomePage() {
    navigation.navigateToPageClear(path: NavigationConstants.HOME_VIEW);
  }

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  //if login Failed,show snackbar, go to homepage
  Future<void> loginWithGoogle() async {
    await AuthManager.instance.googleAuth() == null
        ? loginFailedSnackBar()
        : navigateHomePage();
  }

  //if login Failed,show snackbar, go to home page
  Future<void> loginEmailAndPassword() async {
    if (formState.currentState.validate()) {
      await AuthManager.instance
                  .appAuth(mailController.text, passwordController.text) ==
              null
          ? loginFailedSnackBar()
          : navigateHomePage();
    }
  }

  //notify the user that login failed.
  void loginFailedSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Login Failed!!"),
      backgroundColor: ColorTheme.PRIMARY_RED,
    ));
  }
}
