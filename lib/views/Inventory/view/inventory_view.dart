import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:medication_app_v0/core/base/view/base_widget.dart';
import 'package:medication_app_v0/core/components/cards/inventory_medication_card.dart';
import 'package:medication_app_v0/core/components/widgets/custom_bottom_appbar.dart';
import 'package:medication_app_v0/core/components/widgets/loading_inducator.dart';
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
        builder: (BuildContext context, InventoryViewModel viewmodel) =>
            Observer(
                //display Loading lottie or buildScaffold
                builder: (context) => viewmodel.isLoading
                    ? PulseLoadingIndicatorWidget()
                    : buildScaffold(context, viewmodel)));
  }

  Scaffold buildScaffold(BuildContext context, InventoryViewModel viewmodel) {
    return Scaffold(
        bottomNavigationBar: CustomBottomAppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("add medicine");
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(title: Text("Medication List")),
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
                        child: TextButton(onPressed: () {}, child: Text("All")))
                  ],
                ),
              ),
              Expanded(
                flex: 9,
                child: ListView.builder(
                  itemCount: medicationList.length,
                  itemBuilder: (context, index) => InventoryMedicationCard(
                      model: viewmodel.getMedList[index]),
                ),
              ),
            ],
          ),
        ));
  }
}
