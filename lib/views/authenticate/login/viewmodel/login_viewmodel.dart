import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/constants/navigation/navigation_constants.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';
part 'login_viewmodel.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> formState;
  GlobalKey<ScaffoldState> scaffoldState;
  TextEditingController mailController;
  TextEditingController passwordController;

  void setContext(BuildContext context) => this.context = context;
  void init() {
    mailController = TextEditingController();
    passwordController = TextEditingController();
    scaffoldState =  GlobalKey();
    formState = GlobalKey();
  }

  void dispose(){
    mailController.dispose();
    passwordController.dispose();
  }

  @observable
  bool isLoading = false;
  @observable
  bool isPasswordVisible = false;

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
      return 'Enter a valid email address';
    else
      return null;
  }

  void navigateSingupPage() {
    navigation.navigateToPage(path: NavigationConstants.SIGNUP_VIEW);
  }
}
