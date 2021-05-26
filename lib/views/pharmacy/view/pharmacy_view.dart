import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:medication_app_v0/core/base/view/base_widget.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';
import 'package:medication_app_v0/views/pharmacy/model/pharmacy_model.dart';
import 'package:medication_app_v0/views/pharmacy/viewmodel/pharmacy_viewmodel.dart';

class PharmacyView extends StatefulWidget {
  @override
  _PharmacyViewState createState() => _PharmacyViewState();
}

class _PharmacyViewState extends State<PharmacyView> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
        model: PharmacyViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        builder: (BuildContext context, PharmacyViewModel viewModel) =>
            buildScaffold(context, viewModel));
  }

  Scaffold buildScaffold(BuildContext context, PharmacyViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pharmacy"),
      ),
      body: buildListView(context, viewModel),
    );
  }

  Widget buildListView(BuildContext context, PharmacyViewModel viewModel) {
    return Observer(builder: (_) {
      if (viewModel.isLoading) {
        return Center(child: CircularProgressIndicator());
      } else {
        return ListView.builder(
            itemCount: viewModel.pharmacies.length,
            itemBuilder: (context, index) {
              final phar = viewModel.pharmacies[index];
              return Column(children: <Widget>[
                Card(
                    color: ColorTheme.PRIMARY_BLUE,
                    elevation: 4,
                    margin: EdgeInsets.all(9),
                    child: ListTile(
                      leading: Icon(Icons.local_pharmacy),
                      title: Text(phar.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: ColorTheme.GREY_DARK)),
                      subtitle: Text(
                          "You are " +
                              phar.distance.toStringAsFixed(2) +
                              " km away from this place.",
                          style: TextStyle(fontSize: 16.0)),
                      onTap: () {
                        setState(() {
                          displayPharmacy(context, viewModel, phar);
                        });
                      },
                    )),
              ]);
            });
      }
    });
  }

  displayPharmacy(
      BuildContext context, PharmacyViewModel viewModel, Pharmacy pharm) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(pharm.name),
            content: Text(
                "ADDRESS:\n" + pharm.address + "\n\nPHONE:\n" + pharm.phone),
            actions: <Widget>[
              TextButton(
                child: Text("CANCEL"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
