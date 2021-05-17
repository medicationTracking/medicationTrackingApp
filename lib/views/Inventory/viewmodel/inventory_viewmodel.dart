import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:medication_app_v0/core/constants/navigation/navigation_constants.dart';
import 'package:medication_app_v0/views/Inventory/model/inventory_model.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
part 'inventory_viewmodel.g.dart';

class InventoryViewModel = _InventoryViewModelBase with _$InventoryViewModel;
List<InventoryModel> medicationList;

abstract class _InventoryViewModelBase with Store, BaseViewModel {
  @observable
  bool isLoading = false;
  @override
  void init() {
    medicationList = [];
    fillMedicationList();
  }

  @override
  void setContext(BuildContext context) => this.context = context;

  void fillMedicationList() {
    medicationList.add(InventoryModel(
        "8699525099600",
        "PHEBDOL 400 MG FİLM KAPLI TABLET, 24 ADET",
        "feniramidol hidroklorür",
        "DEVA HOLDİNG A.Ş."));
    medicationList.add(InventoryModel(
        "8699724090897",
        "SEGMİR 600 MG FİLM KAPLI TABLET, 10 ADET",
        "sefdinir",
        "ASET İLAÇ SAN. VE TİC A.Ş."));
    medicationList.add(InventoryModel(
        "8699508790074",
        "TAZERACIN 4,5 G IV ENJEKSIYON VE INFUZYON ICIN LIYOFILIZE TOZ ICEREN FLAKON, 1 ADET",
        "piperacillin and enzyme inhibitor",
        "İ.E. ULAGAY İLAÇ SAN. TÜRK A.Ş."));
    medicationList.add(InventoryModel(
        "8699976010759",
        "TELMIDAY PLUS 80/25 MG TABLET, 28 ADET",
        "telmisartan ve hidroklorotiyazid",
        "NUVOMED İLAÇ SAN.TİC. A.Ş."));
  }

  List<InventoryModel> get getMedList {
    List<InventoryModel> temp = [];
    for (final i in medicationList) {
      temp.add(i);
    }
    return temp;
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
