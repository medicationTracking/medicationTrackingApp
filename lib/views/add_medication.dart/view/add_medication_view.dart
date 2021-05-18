import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/base/view/base_widget.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';
import 'package:medication_app_v0/views/add_medication.dart/viewmodel/add_medication_viewmodel.dart';
import "package:medication_app_v0/views/Inventory/model/inventory_model.dart";

class AddMedicationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
        model: AddMedicationViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        builder: (BuildContext context, AddMedicationViewModel viewmodel) =>
            buildScaffold(context, viewmodel));
  }

  Scaffold buildScaffold(
      BuildContext context, AddMedicationViewModel viewmodel) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Medication"),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: context.height * 0.9,
          child: Padding(
            padding: context.paddingMedium,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildBarcodeTextFormField(viewmodel),
                context.emptySizedHeightBoxNormal,
                buildQrCodeButton(context, viewmodel),
                Text(
                  "Scan qr code",
                  style: context.textTheme.subtitle1,
                ),
                ElevatedButton(
                    onPressed: () {
                      //Todo: generate InventryModel from scanned qr code
                      viewmodel.postMed(InventoryModel(
                          barcode: "1234567",
                          activeIngredient: "active2",
                          company: "company2",
                          name: "name2"));
                    },
                    child: Text("med post deneme")),
                ElevatedButton(
                    onPressed: () {
                      viewmodel.getMed();
                    },
                    child: Text("get deneme"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form buildBarcodeTextFormField(AddMedicationViewModel viewmodel) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: TextFormField(
          controller: viewmodel.manuelBarcodeController,
          validator: (value) => viewmodel.validateBarcode(value),
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.qr_code_scanner_rounded),
              labelText: "Barcode",
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_forward),
              ))),
    );
  }

  Container buildQrCodeButton(
      BuildContext context, AddMedicationViewModel viewmodel) {
    return Container(
      child: IconButton(
        onPressed: () {
          viewmodel.scanQR();
        },
        icon: Icon(
          Icons.qr_code_scanner_rounded,
          size: context.height * 0.3,
          color: Colors.black54,
        ),
      ),
      height: context.height * 0.3,
      width: Size.infinite.width,
    );
  }
}
