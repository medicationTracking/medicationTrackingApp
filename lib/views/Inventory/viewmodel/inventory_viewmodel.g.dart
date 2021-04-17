// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InventoryViewModel on _InventoryViewModelBase, Store {
  final _$isLoadingAtom = Atom(name: '_InventoryViewModelBase.isLoading');

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

  final _$_InventoryViewModelBaseActionController =
      ActionController(name: '_InventoryViewModelBase');

  @override
  void changeLoading() {
    final _$actionInfo = _$_InventoryViewModelBaseActionController.startAction(
        name: '_InventoryViewModelBase.changeLoading');
    try {
      return super.changeLoading();
    } finally {
      _$_InventoryViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
