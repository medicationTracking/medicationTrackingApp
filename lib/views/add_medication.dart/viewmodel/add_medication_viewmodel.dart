import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:medication_app_v0/core/init/services/auth_manager.dart';
import 'package:medication_app_v0/views/Inventory/model/inventory_model.dart';
import 'package:mobx/mobx.dart';
part 'add_medication_viewmodel.g.dart';

class AddMedicationViewModel = _AddMedicationViewModelBase
    with _$AddMedicationViewModel;

abstract class _AddMedicationViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {
    medicationNameController = TextEditingController();
    companyController = TextEditingController();
    activeIngredientController = TextEditingController();
  }

  TextEditingController medicationNameController;
  TextEditingController companyController;
  TextEditingController activeIngredientController;

  String _scanBarcode;

  //scan barcode (qr and normal type barcode is readable.)
  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", LocaleKeys.home_CANCEL.locale, true, ScanMode.QR);
      print("barcode=$barcodeScanRes");
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    _scanBarcode = barcodeScanRes;
    print(_scanBarcode);
  }

  String emptyCheck(String value) {
    if (value == null) {
      return null;
    } else {
      return "Medication name cannot be empyt!";
    }
  }

  String validateBarcode(String value) {
    try {
      BigInt.parse(value);
      return null;
    } catch (e) {
      return "Barcode is bad formatted!!";
    }
  }

  Future<void> postMed(InventoryModel data) async {
    await AuthManager.instance.postMedication(data);
  }

  Future getMed() async {
    await AuthManager.instance.getMedicationList();
  }
}
