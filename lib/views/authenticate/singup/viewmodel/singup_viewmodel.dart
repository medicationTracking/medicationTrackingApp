import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:medication_app_v0/core/constants/navigation/navigation_constants.dart';
import 'package:mobx/mobx.dart';

part 'singup_viewmodel.g.dart';

class SignupViewModel = _SignupViewModelBase with _$SignupViewModel;

abstract class _SignupViewModelBase with Store, BaseViewModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> singupFormState = GlobalKey();

  @observable
  DateTime _date = DateTime.now();

  DateTime get date => _date;

  String get getDate => formatDate(_date, [dd, '/', mm, '/', yyyy]);

  set date(DateTime date) {
    _date = date;
  }

  void setContext(BuildContext context) => this.context = context;
  void init() {}
  //contorllerleri nerede dispose edeceğim???

  pickDate(BuildContext context) async {
    DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(1980),
        firstDate: DateTime(1920),
        lastDate: DateTime(2020));
    _changeDate(pickedDate);
    print(date);
  }

  @action
  void _changeDate(DateTime pickedDate) {
    if (pickedDate != null) {
      date = pickedDate;
    }
  }

  String emptyCheck(String value) {
    if (value == null || value.isEmpty) {
      return "This form required!";
    }
    return null;
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
}
