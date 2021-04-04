import 'package:flutter/material.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'reset_password_viewmodel.g.dart';

class ResetPasswordViewModel = _ResetPasswordViewModelBase with _$ResetPasswordViewModel;

abstract class _ResetPasswordViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  void setContext(BuildContext context) => this.context = context;
  void init() {}

  @observable
  bool isPasswordVisible = false;
  bool isPasswordVisibleAgain = false;

  @action
  void seePassword(){
    isPasswordVisible = !isPasswordVisible;
    
  }
 
  String validatePassword(String value){
    Pattern  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    if(!regExp.hasMatch(value) || value == null || value.length < 8)
      return 'Enter valid password.';
    else
        return null;
  }
  String comparePassword(String value, String newValue){
    if(value != newValue)
      return 'Passwords does not match, please enter again.';
    else
      return null;
  }
  void navigateLoginPage() {
    navigation.navigateToPage(path: NavigationConstants.LOGIN_VIEW);
  }
}

