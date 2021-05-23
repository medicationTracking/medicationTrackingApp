import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:medication_app_v0/core/constants/enums/shared_preferences_enum.dart';
import 'package:medication_app_v0/core/init/cache/shared_preferences_manager.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';
import 'package:medication_app_v0/views/Inventory/model/inventory_model.dart';
import 'package:medication_app_v0/views/home/Calendar/model/reminder.dart';
import 'package:mobx/mobx.dart';
part 'intake_medication_viewmodel.g.dart';

class IntakeMedicationViewModel = _IntakeMedicationViewModelBase
    with _$IntakeMedicationViewModel;

abstract class _IntakeMedicationViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {
    period = getPeriodList().first;
    times = 1;
    numberOfReminderController = TextEditingController();
  }

  TextEditingController numberOfReminderController;
  final SharedPreferencesManager _sharedPreferencesManager =
      SharedPreferencesManager.instance;

  @observable
  String selectedTime;

  TimeOfDay _selectedtime;

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
    return <String>[
      LocaleKeys.reminder_PERIOD_DAILY.locale,
      LocaleKeys.reminder_PERIOD_WEEKLY.locale,
      LocaleKeys.reminder_PERIOD_MONTHLY.locale
    ];
  }

  Future<void> pickTime() async {
    TimeOfDay picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setSelectedTime(picked);
    _selectedtime = picked;
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

  Future<bool> saveMedicationIntakeButtonOnPress(
      InventoryModel medication) async {
    List<ReminderModel> modelsList = getListOfReminderModel(medication);
    return await storeNewReminders(modelsList);
  }

  Future<bool> storeNewReminders(List<ReminderModel> listOfNewReminder) async {
    try {
      //get old reminders
      List<String> jsonsInPrefs = await _sharedPreferencesManager
          .getStringListValue(SharedPreferencesKey.REMINDERMODELS);

      //add new reminders to the old reminders List.
      listOfNewReminder.forEach((value) {
        jsonsInPrefs.add(value.toJson());
      });

      //save to sharedPreferences
      await _sharedPreferencesManager.setListValue(
          SharedPreferencesKey.REMINDERMODELS, jsonsInPrefs);
      return true;
    } catch (e) {
      return false;
    }
  }

  List<ReminderModel> getListOfReminderModel(InventoryModel medication) {
    List<ReminderModel> reminderModelList = [];
    //default 10 alarm
    int n = int.parse(numberOfReminderController.text) ?? 10;
    final medDate = date.add(
        Duration(hours: _selectedtime.hour, minutes: _selectedtime.minute));
    reminderModelList.add(ReminderModel(medication.name, medDate, n, false));
    DateTime nextDate = medDate;
    for (var i = 1; i < n; i++) {
      //[1 to n-1]
      nextDate = _getNextDate(nextDate);
      reminderModelList
          .add(ReminderModel(medication.name, nextDate, n - i, false));
    }
    return reminderModelList;
  }

  DateTime _getNextDate(DateTime date) {
    final String currentPeriod = period;
    final String daily = LocaleKeys.reminder_PERIOD_DAILY.locale;
    final String monthly = LocaleKeys.reminder_PERIOD_MONTHLY.locale;
    final String weekly = LocaleKeys.reminder_PERIOD_WEEKLY.locale;

    if (currentPeriod.compareTo(daily) == 0) {
      return date.add(_timeToAddDaily(times));
    } else if (currentPeriod.compareTo(weekly) == 0) {
      return date.add(_timeToAddWeekly(times));
    } else if (currentPeriod.compareTo(monthly) == 0) {
      return date.add(_timeToAddMonthly(times));
    }
  }

  Duration _timeToAddDaily(int timesInPeriod) {
    int minutesInDay = 24 * 60;
    double intervalTime = minutesInDay / timesInPeriod;
    return Duration(minutes: intervalTime.round());
  }

  Duration _timeToAddWeekly(int timesInPeriod) {
    int minutesInDay = 24 * 60 * 7;
    double intervalTime = minutesInDay / timesInPeriod;
    return Duration(minutes: intervalTime.round());
  }

  Duration _timeToAddMonthly(int timesInPeriod) {
    int minutesInDay = 24 * 60 * 7 * 30;
    double intervalTime = minutesInDay / timesInPeriod;
    return Duration(minutes: intervalTime.round());
  }
}
