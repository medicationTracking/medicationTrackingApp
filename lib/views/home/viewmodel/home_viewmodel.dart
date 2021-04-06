import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:medication_app_v0/views/home/model/home_model.dart';

import 'package:mobx/mobx.dart';
import 'package:table_calendar/table_calendar.dart';
part 'home_viewmodel.g.dart';

class HomeViewmodel = _HomeViewmodelBase with _$HomeViewmodel;

abstract class _HomeViewmodelBase with Store, BaseViewModel {
  @observable
  Map<DateTime, List<HomeModel>> events;
  @observable
  List<HomeModel> selectedEvents;
  CalendarController calendarController;
  void setContext(BuildContext context) => this.context = context;
  void init() {
    final _selectedDay = DateTime.now();

    events = {
      _selectedDay.subtract(Duration(days: 30)): [
        HomeModel("Teraflu",
            _selectedDay.subtract(Duration(days: 30, hours: 4)), 25, true),
        HomeModel("Calpol", _selectedDay.subtract(Duration(days: 30, hours: 1)),
            25, false),
      ],
      _selectedDay.subtract(Duration(days: 27)): [
        HomeModel("Teraflu",
            _selectedDay.subtract(Duration(days: 27, hours: 2)), 35, true),
      ],
      _selectedDay.subtract(Duration(days: 20)): [
        HomeModel("Teraflu",
            _selectedDay.subtract(Duration(days: 20, hours: 3)), 40, false),
        HomeModel("Calpol", _selectedDay.subtract(Duration(days: 20, hours: 2)),
            25, false),
        HomeModel("Jolessa",
            _selectedDay.subtract(Duration(days: 20, hours: 1)), 25, true),
        HomeModel(
            "Paromymcin", _selectedDay.subtract(Duration(days: 20)), 25, true),
      ],
      _selectedDay.subtract(Duration(days: 16)): [
        HomeModel("Calpol", _selectedDay.subtract(Duration(days: 16, hours: 4)),
            25, false),
        HomeModel("Jolessa",
            _selectedDay.subtract(Duration(days: 16, hours: 3)), 25, false),
      ],
      _selectedDay.subtract(Duration(days: 10)): [
        HomeModel("Calpol", _selectedDay.subtract(Duration(days: 10, hours: 2)),
            25, true),
        HomeModel("Jolessa",
            _selectedDay.subtract(Duration(days: 10, hours: 1)), 25, true),
        HomeModel(
            "Paromymcin", _selectedDay.subtract(Duration(days: 10)), 25, true),
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        HomeModel("Teraflu", _selectedDay.subtract(Duration(days: 4, hours: 4)),
            25, true),
        HomeModel("Calpol", _selectedDay.subtract(Duration(days: 4, hours: 3)),
            25, false),
        HomeModel("Jolessa", _selectedDay.subtract(Duration(days: 4, hours: 1)),
            25, true),
      ],
      _selectedDay.subtract(Duration(days: 2)): [
        HomeModel("Jolessa", _selectedDay.subtract(Duration(days: 2, hours: 2)),
            25, false),
        HomeModel("Paromymcin",
            _selectedDay.subtract(Duration(days: 2, hours: 5)), 25, true),
      ],
      _selectedDay: [
        HomeModel(
            "Jolessa", _selectedDay.subtract(Duration(hours: 5)), 25, true),
        HomeModel(
            "Paromymcin", _selectedDay.subtract(Duration(hours: 4)), 25, true),
        HomeModel(
            "Jolessa", _selectedDay.subtract(Duration(hours: 2)), 25, true),
        HomeModel("Paromymcin", _selectedDay, 25, true),
      ],
      _selectedDay.add(Duration(days: 7)): [
        HomeModel(
            "Jolessa", _selectedDay.add(Duration(days: 7, hours: 1)), 25, true),
        HomeModel("Paromymcin", _selectedDay.add(Duration(days: 7, hours: 2)),
            25, true),
        HomeModel(
            "Teraflu", _selectedDay.add(Duration(days: 7, hours: 3)), 25, true),
        HomeModel(
            "Calpol", _selectedDay.add(Duration(days: 7, hours: 4)), 25, false),
        HomeModel(
            "Jolessa", _selectedDay.add(Duration(days: 7, hours: 5)), 25, true),
      ],
    };
    selectedEvents = events[_selectedDay] ?? [];
    calendarController = CalendarController();
  }

  void dispose() {
    calendarController.dispose();
  }

  @action
  void onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    selectedEvents = events.cast<HomeModel>();
  }

  @action
  void onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    calendarController.setSelectedDay(first);
    selectedEvents = events[first] ?? [];
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }
}
