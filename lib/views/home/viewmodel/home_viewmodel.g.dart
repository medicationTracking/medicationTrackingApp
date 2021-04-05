// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeViewmodel on _HomeViewmodelBase, Store {
  final _$eventsAtom = Atom(name: '_HomeViewmodelBase.events');

  @override
  Map<DateTime, List<HomeModel>> get events {
    _$eventsAtom.reportRead();
    return super.events;
  }

  @override
  set events(Map<DateTime, List<HomeModel>> value) {
    _$eventsAtom.reportWrite(value, super.events, () {
      super.events = value;
    });
  }

  final _$selectedEventsAtom = Atom(name: '_HomeViewmodelBase.selectedEvents');

  @override
  List<HomeModel> get selectedEvents {
    _$selectedEventsAtom.reportRead();
    return super.selectedEvents;
  }

  @override
  set selectedEvents(List<HomeModel> value) {
    _$selectedEventsAtom.reportWrite(value, super.selectedEvents, () {
      super.selectedEvents = value;
    });
  }

  final _$_HomeViewmodelBaseActionController =
      ActionController(name: '_HomeViewmodelBase');

  @override
  void onDaySelected(
      DateTime day, List<dynamic> events, List<dynamic> holidays) {
    final _$actionInfo = _$_HomeViewmodelBaseActionController.startAction(
        name: '_HomeViewmodelBase.onDaySelected');
    try {
      return super.onDaySelected(day, events, holidays);
    } finally {
      _$_HomeViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    final _$actionInfo = _$_HomeViewmodelBaseActionController.startAction(
        name: '_HomeViewmodelBase.onVisibleDaysChanged');
    try {
      return super.onVisibleDaysChanged(first, last, format);
    } finally {
      _$_HomeViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
events: ${events},
selectedEvents: ${selectedEvents}
    ''';
  }
}
