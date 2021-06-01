import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:medication_app_v0/core/base/view/base_widget.dart';
import 'package:medication_app_v0/core/components/widgets/custom_bottom_appbar.dart';
import 'package:medication_app_v0/core/components/widgets/loading_inducator.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';
import 'package:medication_app_v0/views/pharmacy/model/pharmacy_model.dart';
import 'package:medication_app_v0/views/pharmacy/viewmodel/pharmacy_viewmodel.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';
import 'package:medication_app_v0/core/components/widgets/drawer.dart';

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
            Observer(
              builder: (_) => viewModel.isLoading
                  ? Scaffold(
                      body: PulseLoadingIndicatorWidget(),
                    )
                  : buildScaffold(context, viewModel),
            ));
  }

  Scaffold buildScaffold(BuildContext context, PharmacyViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.pharmacy_PHARMACY_TITLE.locale),
      ),
      bottomNavigationBar: CustomBottomAppBar(),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          Expanded(child: buildListView(context, viewModel)),
          Expanded(
              child: Padding(
                  padding: context.paddingNormal,
                  child: Observer(
                    builder: (_) => viewModel.pharmacies.isEmpty
                        ? CircularProgressIndicator()
                        : viewModel.displayPharmacyOnMap(),
                  )))
        ],
      ),
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
                      leading: IconButton(
                          color: ColorTheme.PRIMARY_RED,
                          icon: Icon(Icons.location_pin),
                          iconSize: 30,
                          onPressed: () {
                            viewModel.goToPharmacy(phar);
                          }),
                      title: Text(phar.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: ColorTheme.GREY_DARK)),
                      subtitle: Text(
                          LocaleKeys.pharmacy_YOU_ARE.locale +
                              " " +
                              (phar.distance / 1000).toStringAsFixed(2) +
                              LocaleKeys.pharmacy_AWAY_FROM.locale,
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
            content: Text(LocaleKeys.pharmacy_ADDRESS.locale +
                "\n" +
                pharm.address +
                "\n\n ${LocaleKeys.pharmacy_PHONE.locale}:\n" +
                pharm.phone),
            actions: <Widget>[
              TextButton(
                child: Text(LocaleKeys.pharmacy_OK.locale),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
