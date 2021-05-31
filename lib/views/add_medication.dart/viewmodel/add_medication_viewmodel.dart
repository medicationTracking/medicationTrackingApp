import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medication_app_v0/core/constants/enums/shared_preferences_enum.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:medication_app_v0/core/init/cache/shared_preferences_manager.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:medication_app_v0/core/init/services/auth_manager.dart';
import 'package:medication_app_v0/core/init/services/medication_service.dart';
import 'package:medication_app_v0/core/init/services/pharmacy_service.dart';
import 'package:medication_app_v0/views/Inventory/model/inventory_model.dart';
import 'package:medication_app_v0/views/add_medication.dart/model/pharmacy.dart';
import 'package:mobx/mobx.dart';
part 'add_medication_viewmodel.g.dart';

class AddMedicationViewModel = _AddMedicationViewModelBase
    with _$AddMedicationViewModel;

abstract class _AddMedicationViewModelBase with Store, BaseViewModel {
  String barcodeError = "not valid!";
  MedicationService _networkServices;
  PharmacyService _pharmacyService;
  InventoryModel medication;
  GlobalKey<FormState> medicationFormState;
  bool isAllergenic;

  void setContext(BuildContext context) => this.context = context;
  void init() {
    medicationNameController = TextEditingController();
    companyController = TextEditingController();
    barcodeController = TextEditingController();
    activeIngredientController = TextEditingController();
    _networkServices = MedicationService();
    _pharmacyService = new PharmacyService();
    medicationFormState = GlobalKey();
    isAllergenic = false;
  }

  DateTime expiredDate;
  TextEditingController medicationNameController;
  TextEditingController companyController;
  TextEditingController activeIngredientController;
  TextEditingController barcodeController;

  //scan barcode (qr and normal type barcode is readable.)
  Future<String> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", LocaleKeys.home_CANCEL.locale, true, ScanMode.QR);
      print("barcode=$barcodeScanRes");
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    return barcodeScanRes;
    //if scanner cancels, return -1
    //var temp = _scanBarcode[0];
    //print(temp.compareTo(""));
  }

  //show scanned med in the add medication view
  Future<bool> fillCardWithScannedMedication(String barcode) async {
    try {
      expiredDate = _convertQRtoExpiredDate(barcode);
      String validBarcode = _validBarcode(barcode);
      if (validBarcode.compareTo(barcodeError) != 0) {
        Response response =
            await _networkServices.getMedicationFromBarcode(validBarcode);
        if (response.statusCode == HttpStatus.ok) {
          print("qr code okundu ilaç geldi!");
          InventoryModel scannedMed = InventoryModel.fromMap(response.data);
          scannedMed.expiredDate = expiredDate;
          medicationNameController.text = scannedMed.name;
          activeIngredientController.text = scannedMed.activeIngredient;
          companyController.text = scannedMed.company;
          barcodeController.text = scannedMed.barcode;
          return true;
        }
      }
    } catch (e) {}

    return false;
  }

  //return barcode or barcodeError
  String _validBarcode(String barcode) {
    if (barcode.length == 13)
      return barcode;
    else {
      return _convertQRtoBarcode(barcode);
    }
  }

  String emptyCheck(String value) {
    if (value == null) {
      return null;
    } else {
      return LocaleKeys
          .add_medication_MEDICATION_NAME_FIELD_ERROR_MESSAGE.locale;
    }
  }

  Future<List<Pharmacy>> getPharmacy() async {
    final Response result =
        await _pharmacyService.getPharmacyByPlace("karşıyaka", "izmir");
    final List<Pharmacy> pharmacies = [];
    if (result.statusCode == 200) {
      //error check gerekli belki liste boş mu diye bakılabilir.
      final Iterable iterable = result.data['result'];
      iterable.forEach((pharmacy) {
        print(pharmacy);
        pharmacies.add(Pharmacy.fromJson(pharmacy));
      });
    }
    return pharmacies;
  }

  Future<InventoryModel> getMedicationFromBarcode(String barcode) async {
    final Response result =
        await _networkServices.getMedicationFromBarcode(barcode);
    if (result.statusCode == 400) {
      print(result.data);
      return InventoryModel.fromJson(result.data);
    }
    return null; // return error or snackbar etc
  }

  Future<bool> postMedToFirebase(InventoryModel data) async {
    return await AuthManager.instance.postMedication(data);
  }

  InventoryModel get getMedicine {
    return InventoryModel(
        name: medicationNameController.text,
        company: companyController.text,
        activeIngredient: activeIngredientController.text,
        expiredDate: expiredDate ?? DateTime(2100));
  }

  //Controllers.texts send to the firebase
  Future<bool> saveManuelMedicationToFirebase() async {
    //manuel addition
    if (medicationFormState.currentState.validate()) {
      await allergensCheck(getMedicine);
      if (!isAllergenic) {
        return await postMedToFirebase(getMedicine);
      }
    }
    isAllergenic = false; //reset allergenic attribute
    return false;
  }

  String _convertQRtoBarcode(String qr) {
    String x = "";
    if (qr.contains(x)) {
      int first = qr.indexOf(x);
      int last = qr.lastIndexOf(x);
      if (first != last) {
        if (qr.substring(first + 1, first + 4).compareTo("010") == 0) {
          String skt = qr.substring(last + 3, last + 9);
          print("skt= $skt");
          String barcode = qr.substring(first + 4, first + 17);
          return barcode;
        }
      }
    }
    return barcodeError;
  }

  //return expired date or null
  DateTime _convertQRtoExpiredDate(String qr) {
    String x = "";
    if (qr.contains(x)) {
      int first = qr.indexOf(x);
      int last = qr.lastIndexOf(x);
      if (first != last) {
        if (qr.substring(first + 1, first + 4).compareTo("010") == 0) {
          String skt = qr.substring(last + 3, last + 9);
          int year = int.tryParse("20" + skt.substring(0, 2));
          int month = int.tryParse(skt.substring(2, 5));
          int day = int.tryParse(skt.substring(4));

          DateTime expiredDate = DateTime.utc(year, month, day);
          return expiredDate;
        }
      }
    }
    return null;
  }

  String validateBarcode(String value) {
    try {
      BigInt.parse(value);
      return null;
    } catch (e) {
      return barcodeError;
    }
  }

  Future<void> allergensCheck(InventoryModel medication) async {
    List<String> allergensList = await SharedPreferencesManager.instance
        .getStringListValue(SharedPreferencesKey.ALLERGENS);
    for (String allergen in allergensList) {
      if (allergen.compareTo(medication.activeIngredient) == 0) {
        //alerbox
        return await allergenWarning();
      }
    }
  }

  Future<void> allergenWarning() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(LocaleKeys.add_medication_ALLERGEN_WARNING.locale),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(LocaleKeys.add_medication_ALLERGEN_TEXT1.locale),
                  Text(LocaleKeys.add_medication_ALLERGEN_TEXT2.locale),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(LocaleKeys.add_medication_ADD.locale),
                onPressed: () {
                  isAllergenic = false;
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(LocaleKeys.add_medication_CANCEL.locale),
                onPressed: () {
                  isAllergenic = true;
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
