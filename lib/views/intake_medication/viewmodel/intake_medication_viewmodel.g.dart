// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intake_medication_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$IntakeMedicationViewModel on _IntakeMedicationViewModelBase, Store {
  final _$selectedTimeAtom =
      Atom(name: '_IntakeMedicationViewModelBase.selectedTime');

  @override
  String get selectedTime {
    _$selectedTimeAtom.reportRead();
    return super.selectedTime;
  }

  @override
  set selectedTime(String value) {
    _$selectedTimeAtom.reportWrite(value, super.selectedTime, () {
      super.selectedTime = value;
    });
  }

  final _$dateAtom = Atom(name: '_IntakeMedicationViewModelBase.date');

  @override
  DateTime get date {
    _$dateAtom.reportRead();
    return super.date;
  }

  @override
  set date(DateTime value) {
    _$dateAtom.reportWrite(value, super.date, () {
      super.date = value;
    });
  }

  final _$timesAtom = Atom(name: '_IntakeMedicationViewModelBase.times');

  @override
  int get times {
    _$timesAtom.reportRead();
    return super.times;
  }

  @override
  set times(int value) {
    _$timesAtom.reportWrite(value, super.times, () {
      super.times = value;
    });
  }

  final _$periodAtom = Atom(name: '_IntakeMedicationViewModelBase.period');

  @override
  String get period {
    _$periodAtom.reportRead();
    return super.period;
  }

  @override
  set period(String value) {
    _$periodAtom.reportWrite(value, super.period, () {
      super.period = value;
    });
  }

  final _$pickDateAsyncAction =
      AsyncAction('_IntakeMedicationViewModelBase.pickDate');

  @override
  Future pickDate(BuildContext context) {
    return _$pickDateAsyncAction.run(() => super.pickDate(context));
  }

  final _$_IntakeMedicationViewModelBaseActionController =
      ActionController(name: '_IntakeMedicationViewModelBase');

  @override
  void incrementTimes(int x) {
    final _$actionInfo = _$_IntakeMedicationViewModelBaseActionController
        .startAction(name: '_IntakeMedicationViewModelBase.incrementTimes');
    try {
      return super.incrementTimes(x);
    } finally {
      _$_IntakeMedicationViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPeriod(String value) {
    final _$actionInfo = _$_IntakeMedicationViewModelBaseActionController
        .startAction(name: '_IntakeMedicationViewModelBase.setPeriod');
    try {
      return super.setPeriod(value);
    } finally {
      _$_IntakeMedicationViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedTime(TimeOfDay time) {
    final _$actionInfo = _$_IntakeMedicationViewModelBaseActionController
        .startAction(name: '_IntakeMedicationViewModelBase.setSelectedTime');
    try {
      return super.setSelectedTime(time);
    } finally {
      _$_IntakeMedicationViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedTime: ${selectedTime},
date: ${date},
times: ${times},
period: ${period}
    ''';
  }
}
