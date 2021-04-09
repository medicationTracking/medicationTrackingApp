import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/constants/navigation/navigation_constants.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'verify_mail_code_viewmodel.g.dart';

class VerifyMailCodeViewModel = _VerifyMailCodeViewModelBase with _$VerifyMailCodeViewModel;

abstract class _VerifyMailCodeViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {}

  void navigateResetPasswordPage() {
    navigation.navigateToPage(path: NavigationConstants.RESET_PASSWORD_VIEW);
  }
}