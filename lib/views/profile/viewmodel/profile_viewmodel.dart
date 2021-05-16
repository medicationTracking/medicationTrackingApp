import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:medication_app_v0/core/constants/navigation/navigation_constants.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:mobx/mobx.dart';
part 'profile_viewmodel.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> profileFormState;
  TextEditingController profileNameController;
  TextEditingController profileSurnameController;
  TextEditingController profileAgeController;
  TextEditingController profileWeightcontroller;
  TextEditingController profileGenderController;
  TextEditingController profileMailController;
  TextEditingController profilePasswordController;

  String chosenValue;
  @observable
  bool isPasswordVisible = false;

  void setContext(BuildContext context) => this.context = context;
  void init(){
    profileFormState = GlobalKey();
    profileNameController =TextEditingController();
    profileSurnameController =TextEditingController();
    profileAgeController = TextEditingController();
    profileWeightcontroller = TextEditingController();
    profileGenderController = TextEditingController();
    profileMailController = TextEditingController();
    profilePasswordController = TextEditingController();
  }

   String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return LocaleKeys.profile_MAIL_ERROR_TEXT.locale;
    else
      return null;
  }

  String validatePassword(String value){
    Pattern  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    if(!regExp.hasMatch(value) || value == null || value.length < 8){
        return LocaleKeys.profile_PASSWORD_ERROR_TEXT.locale;
    }
    else
      return null;
  }

  @action
  void seePassword() {
    isPasswordVisible = !isPasswordVisible;
  }

  void navigateForgotPasswordPage() {
    navigation.navigateToPage(path: NavigationConstants.FORGOT_PASSWORD_VIEW);
  }



}