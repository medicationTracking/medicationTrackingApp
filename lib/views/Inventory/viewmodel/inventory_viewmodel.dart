import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
part 'inventory_viewmodel.g.dart';

class InventoryViewModel = _InventoryViewModelBase with _$InventoryViewModel;

abstract class _InventoryViewModelBase with Store,BaseViewModel {
  @override
  void init() {
  }
  @override
  void setContext(BuildContext context) => this.context = context;
}