import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:medication_app_v0/views/allergens/view/allergens.view.dart';

import 'package:mobx/mobx.dart';
part 'allergens_viewmodel.g.dart';

class AllergensViewModel = _AllergensViewModelBase with _$AllergensViewModel;

abstract class _AllergensViewModelBase with Store, BaseViewModel {
  TextEditingController allergenFieldController;

  void setContext(BuildContext context) => this.context = context;
  void init() {
    allergenFieldController = TextEditingController();
  }
}
