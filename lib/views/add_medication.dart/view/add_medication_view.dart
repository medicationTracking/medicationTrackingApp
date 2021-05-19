import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/base/view/base_widget.dart';
import 'package:medication_app_v0/core/components/cards/inventory_medication_card.dart';
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
                buildMedicationForm(viewmodel),
                context.emptySizedHeightBoxNormal,
                buildQrCodeButton(context, viewmodel),
                Text(
                  "Scan qr code",
                  style: context.textTheme.subtitle1,
                ),
                /*ElevatedButton(
                    onPressed: () {
                      viewmodel.postMed(InventoryModel(
                          barcode: "1234567",
                          activeIngredient: "active2",
                          company: "company2",
                          name: "name2"));
                    },
                    child: Text("med post deneme")),
                ElevatedButton(
                    onPressed: () async {
                      viewmodel.getMed();
//                      final InventoryModel medication = await viewmodel.getMedicationFromBarcode("8699569570257");
//                      print(medication.name);
                        //viewmodel.getPharmacy();
                    },
                    child: Text("get deneme")),*/
                InventoryMedicationCard(
                    model: InventoryModel(
                  name: viewmodel.medicationNameController.text,
                  company: viewmodel.companyController.text,
                  activeIngredient: viewmodel.activeIngredientController.text,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form buildMedicationForm(AddMedicationViewModel viewmodel) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
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
        onPressed: () {
          viewmodel.scanQR();
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

