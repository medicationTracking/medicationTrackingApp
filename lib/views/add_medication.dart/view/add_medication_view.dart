import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/base/view/base_widget.dart';
import 'package:medication_app_v0/core/components/cards/inventory_medication_card.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';
import 'package:medication_app_v0/views/add_medication.dart/viewmodel/add_medication_viewmodel.dart';
import "package:medication_app_v0/views/Inventory/model/inventory_model.dart";

class AddMedicationView extends StatefulWidget {
  @override
  _AddMedicationViewState createState() => _AddMedicationViewState();
}

class _AddMedicationViewState extends State<AddMedicationView> {
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
                buildMedicationForm(viewmodel),
                context.emptySizedHeightBoxNormal,
                buildQrCodeButton(context, viewmodel),
                Text(
                  "Scan qr code",
                  style: context.textTheme.subtitle1,
                ),
                InventoryMedicationCard(model: viewmodel.getMedicine),
                buildAddMedicationButton(viewmodel, context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton buildAddMedicationButton(
      AddMedicationViewModel viewmodel, BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          bool saveResult = await viewmodel.saveManuelMedicationToFirebase();
          String saveResultString =
              saveResult ? "addition succesfull" : "addition failed";
          if (saveResult) {
            viewmodel.barcodeController.text = "";
            viewmodel.activeIngredientController.text = "";
            viewmodel.companyController.text = "";
            viewmodel.medicationNameController.text = "";
          }
          final _snackBar = SnackBar(
            content: Text(saveResultString),
            backgroundColor: saveResult ? Colors.green : Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(_snackBar);
        },
        child: Center(child: Text("Add medication")));
  }

  Form buildMedicationForm(AddMedicationViewModel viewmodel) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: viewmodel.medicationFormState,
      child: Column(
        children: [
          TextFormField(
              controller: viewmodel.medicationNameController,
              validator: (value) =>
                  value.isNotEmpty ? null : "Medications must have a name",
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.medical_services),
                labelText: "Medication Name",
              )),
          TextFormField(
              controller: viewmodel.companyController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.home_work),
                labelText: "Company",
              )),
          TextFormField(
              controller: viewmodel.activeIngredientController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.warning),
                labelText: "Active Ingredient",
              )),
        ],
      ),
    );
  }

  Container buildQrCodeButton(
      BuildContext context, AddMedicationViewModel viewmodel) {
    return Container(
      child: IconButton(
        onPressed: () async {
          String scannedBarcode = await viewmodel.scanQR();
          await viewmodel.fillCardWithScannedMedication(scannedBarcode);
          setState(() {});
        },
        icon: Icon(
          Icons.qr_code_scanner_rounded,
          size: context.height * 0.2,
          color: Colors.black54,
        ),
      ),
      height: context.height * 0.2,
      width: Size.infinite.width,
    );
  }
}
