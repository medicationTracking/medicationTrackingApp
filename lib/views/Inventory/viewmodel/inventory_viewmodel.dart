import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:medication_app_v0/core/constants/navigation/navigation_constants.dart';
import 'package:medication_app_v0/core/init/services/auth_manager.dart';
import 'package:medication_app_v0/views/Inventory/model/inventory_model.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
part 'inventory_viewmodel.g.dart';

class InventoryViewModel = _InventoryViewModelBase with _$InventoryViewModel;
@observable
List<InventoryModel> medicationList;

abstract class _InventoryViewModelBase with Store, BaseViewModel {
  @observable
  bool isLoading = false;
  @override
  Future<void> init() async {
    changeLoading();
    medicationList = await getMedList;
    changeLoading();
  }

  @override
  void setContext(BuildContext context) => this.context = context;

  Future<List<InventoryModel>> get getMedList async {
    return await AuthManager.instance.getMedicationList();
  }

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  void navigateIntakeView(InventoryModel model) {
    navigation.navigateToPage(
        path: NavigationConstants.INTAKE_VIEW, object: model);
  }
}
