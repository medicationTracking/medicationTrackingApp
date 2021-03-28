import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'singup_viewmodel.g.dart';

class SignupViewModel = _SignupViewModelBase with _$SignupViewModel;

abstract class _SignupViewModelBase with Store, BaseViewModel {
  @observable
  DateTime _date = DateTime.now();

  DateTime get date => _date;

  String get getDate => formatDate(_date, [dd, '/', mm, '/', yyyy]);

  set date(DateTime date) {
    _date = date;
  }

  void setContext(BuildContext context) => this.context = context;
  void init() {}

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
}
