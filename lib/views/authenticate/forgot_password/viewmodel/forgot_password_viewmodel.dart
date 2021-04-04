import 'package:flutter/material.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'forgot_password_viewmodel.g.dart';

class ForgotPasswordViewModel = _ForgotPasswordViewModelBase with _$ForgotPasswordViewModel;

abstract class _ForgotPasswordViewModelBase with Store, BaseViewModel {
  GlobalKey<ScaffoldState> scaffoldState;
  TextEditingController mailController;
  void setContext(BuildContext context) => this.context = context;
  void init() {
    mailController = TextEditingController();
    scaffoldState =  GlobalKey();
  }

  void dispose(){
    mailController.dispose();
  }

  String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return 'Enter a valid email address.';
    else
      return null;
  }

  void navigateLoginPage() {
    navigation.navigateToPage(path: NavigationConstants.LOGIN_VIEW);
  }
  void navigateVerifyMailCodePage() {
    navigation.navigateToPage(path: NavigationConstants.VERIFY_MAIL_CODE_VIEW);
  }
}