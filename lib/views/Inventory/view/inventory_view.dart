import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:medication_app_v0/core/base/view/base_widget.dart';
import 'package:medication_app_v0/core/components/cards/inventory_medication_card.dart';
import 'package:medication_app_v0/core/components/widgets/custom_bottom_appbar.dart';
import 'package:medication_app_v0/core/components/widgets/loading_inducator.dart';
import 'package:medication_app_v0/core/constants/image/image_constants.dart';
import 'package:medication_app_v0/core/components/widgets/drawer.dart';
import 'package:medication_app_v0/core/init/services/auth_manager.dart';
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
                    ? Scaffold(body: PulseLoadingIndicatorWidget())
                    : buildScaffold(context, viewmodel)));
  }

  Scaffold buildScaffold(BuildContext context, InventoryViewModel viewmodel) {
    return Scaffold(
        bottomNavigationBar: CustomBottomAppBar(),
        floatingActionButton: buildFab(viewmodel),
        appBar: AppBar(title: Text("Medication List")),
        drawer: CustomDrawer(),
        body: Padding(
          padding: context.paddingNormal,
          child: Column(
            children: [
              Expanded(
                child: buildTextButtons(viewmodel),
              ),
              buildMedications(viewmodel),
            ],
          ),
        ));
  }

  Observer buildMedications(InventoryViewModel viewmodel) {
    return Observer(
      builder: (_) => Expanded(
        flex: 9,
        child: viewmodel.medicationList.isEmpty
            ? SizedBox(
                height: context.height * 0.5,
                child: Padding(
                  padding: context.paddingMedium,
                  child: Column(
                    children: [
                      Text(
                        "Inventory is empty!",
                        style: context.textTheme.subtitle2,
                      ),
                      Image(
                          image: AssetImage(
                              ImageConstants.instance.inventoryPhoto)),
                    ],
                  ),
                ))
            : ListView.builder(
                itemCount: viewmodel.medicationList.length,
                itemBuilder: (context, index) => InventoryMedicationCard(
                    model: viewmodel.medicationList[index]),
              ),
      ),
    );
  }

  Row buildTextButtons(InventoryViewModel viewmodel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: TextButton(onPressed: () {}, child: Text("Important"))),
        Expanded(
          child: TextButton(
              onPressed: () {
                viewmodel.sortMedList();
                setState(() {});
              },
              child: Text("Expired Soon")),
        ),
        Expanded(
            child: TextButton(
                onPressed: () async {
                  viewmodel.medicationList = await viewmodel.getMedList;
                },
                child: Text("All")))
      ],
    );
  }

  FloatingActionButton buildFab(InventoryViewModel viewModel) {
    return FloatingActionButton(
      onPressed: () async {
        viewModel.navigateAddMedication();
        /*String result = await AuthManager.instance.changePassword("654321");
        final _snackBar = SnackBar(
          content: Text(result),
        );
        ScaffoldMessenger.of(context).showSnackBar(_snackBar);*/
        //var x = await AuthManager.instance.setUserData();
        //print(x.toString());
        //viewmodel.navigateIntakeView(viewmodel.getMedList[1]);
      },
      child: Icon(Icons.add),
    );
  }
}
