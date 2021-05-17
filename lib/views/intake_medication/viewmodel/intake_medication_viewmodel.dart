import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';
part 'intake_medication_viewmodel.g.dart';

class IntakeMedicationViewModel = _IntakeMedicationViewModelBase
    with _$IntakeMedicationViewModel;

abstract class _IntakeMedicationViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {
    period = getPeriodList().first;
    times = 1;
  }

  @observable
  String selectedTime;

  @observable
  DateTime date;

  @observable
  int times;

  @action
  void incrementTimes(int x) {
    times += x;
    if (times < 1) times = 1;
  }

  @observable
  String period;

  @action
  void setPeriod(String value) {
    period = value;
  }

  List<String> getPeriodList() {
    return <String>["Günde", "Haftada", "Ayda"];
  }

  Future<void> pickTime() async {
    TimeOfDay picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setSelectedTime(picked);
  }

  @action
  void setSelectedTime(TimeOfDay time) {
    String tempMinute;
    time.minute < 10
        ? tempMinute = "0${time.minute}"
        : tempMinute = time.minute.toString();
    selectedTime = "${time.hour}:$tempMinute";
  }

  @action
  pickDate(BuildContext context) async {
    DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2024));
    date = pickedDate;
  }
}
