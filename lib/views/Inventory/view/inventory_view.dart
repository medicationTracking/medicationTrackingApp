import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/base/view/base_widget.dart';
import 'package:medication_app_v0/core/components/cards/inventory_medication_card.dart';
import 'package:medication_app_v0/views/Inventory/model/inventory_model.dart';
import 'package:medication_app_v0/views/Inventory/viewmodel/inventory_viewmodel.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';

class InventoryView extends StatefulWidget {
  InventoryView({Key key}) : super(key: key);

  @override
  _InventoryViewState createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        model: InventoryViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        builder: (context, viewmodel) => Scaffold(
            appBar: AppBar(
              title: Text("Medication List"),
            ),
            body: Padding(
              padding: context.paddingNormal,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: TextButton(
                                onPressed: () {}, child: Text("Important"))),
                        Expanded(
                          child: TextButton(
                              onPressed: () {}, child: Text("Expired Soon")),
                        ),
                        Expanded(
                            child: TextButton(
                                onPressed: () {}, child: Text("All")))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: ListView.builder(
                        itemCount: 8,
                        itemBuilder: (context, index) => Container(
                            height: context.height * 0.2,
                            child: InventoryMedicationCard(
                              model: InventoryModel("barcode1", "name 2",
                                  "Active Ing 3", "Company 4"),
                            ))),
                  ),
                ],
              ),
            )));
  }
}
