import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:medication_app_v0/core/constants/enums/shared_preferences_enum.dart';
import 'package:medication_app_v0/core/init/cache/shared_preferences_manager.dart';
import 'package:medication_app_v0/views/allergens/view/allergens.view.dart';

import 'package:mobx/mobx.dart';
part 'allergens_viewmodel.g.dart';

class AllergensViewModel = _AllergensViewModelBase with _$AllergensViewModel;

abstract class _AllergensViewModelBase with Store, BaseViewModel {
  TextEditingController allergenFieldController;
  List<String> allergens;

  void setContext(BuildContext context) => this.context = context;
  void init() {
    allergenFieldController = TextEditingController();
    allergens = allergenspm.getStringListValue(SharedPreferencesKey.ALLERGENS);
  }

  SharedPreferencesManager allergenspm = SharedPreferencesManager.instance;

  Future<void> setSharedPrefAllergen(List<String> allergens) async {
    return await allergenspm.setListValue(
        SharedPreferencesKey.ALLERGENS, allergens);
  }

  Future<void> getSharedPrefAllergen() async {
    return await allergenspm.getStringListValue(SharedPreferencesKey.ALLERGENS);
  }
}
