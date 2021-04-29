// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CovidViewModel on _CovidViewModelBase, Store {
  final _$isLoadingAtom = Atom(name: '_CovidViewModelBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$_CovidViewModelBaseActionController =
      ActionController(name: '_CovidViewModelBase');

  @override
  void changeLoading() {
    final _$actionInfo = _$_CovidViewModelBaseActionController.startAction(
        name: '_CovidViewModelBase.changeLoading');
    try {
      return super.changeLoading();
    } finally {
      _$_CovidViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
