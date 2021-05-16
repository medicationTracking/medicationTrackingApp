import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/base/view/base_widget.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:medication_app_v0/core/init/text/locale_text.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';
import 'package:medication_app_v0/views/allergens/viewmodel/allergens_viewmodel.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';
import 'package:mobx/mobx.dart';

class AllergensView extends StatefulWidget {
  @override
  _AllergensViewState createState() => _AllergensViewState();
}

class _AllergensViewState extends State<AllergensView> {
  List<String> allergens = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        model: AllergensViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onDispose: (model) {
          model.dispose();
        },
        builder: (BuildContext context, AllergensViewModel viewModel) =>
            buildScaffold(context, viewModel));
  }

  Scaffold buildScaffold(BuildContext context, AllergensViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorTheme.PRIMARY_BLUE,
          title: Text(LocaleKeys.allergens_ALLERGEN.locale)),
      body: isEmpty(context, viewModel),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => displayDialog(context, viewModel)),
    );
  }

  isEmpty(BuildContext context, AllergensViewModel viewModel) {
    if (allergens.length != 0) {
      return listViewBuilder(context, viewModel);
    } else {
      return buildContainer(context, viewModel);
    }
  }

  Padding buildContainer(BuildContext context, AllergensViewModel viewModel) {
    return Padding(
        padding: context.paddingMedium,
        child: Container(
            decoration: ShapeDecoration(
                shape: Border.all(color: ColorTheme.PRIMARY_BLUE, width: 2.0)),
            height: context.height * 0.1,
            width: context.width * 1,
            child: Align(
                alignment: Alignment.center,
                child: Text(LocaleKeys.allergens_EMPTY_SCREEN.locale,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: ColorTheme.PRIMARY_BLUE)))));
  }

  Widget listViewBuilder(BuildContext context, AllergensViewModel viewModel) {
    return ListView.builder(
      itemCount: allergens.length,
      itemBuilder: (context, index) {
        final allergen = allergens[index];
        return Card(
            child: ListTile(
          title: Text(allergen),
          onLongPress: () {
            setState(() {
              displayRemoveDialog(context, viewModel, index);
            });
          },
        ));
      },
    );
  }

  displayDialog(BuildContext context, AllergensViewModel viewModel) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(LocaleKeys.allergens_INSERT_ALLERGEN.locale),
            content: TextField(
              controller: viewModel.allergenFieldController,
              decoration: InputDecoration(
                  hintText: LocaleKeys.allergens_INSERT_ALLERGEN_HINT.locale),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(LocaleKeys.allergens_CANCEL.locale),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(LocaleKeys.allergens_ADD.locale),
                onPressed: () {
                  setState(() {
                    allergens.insert(0, viewModel.allergenFieldController.text);
                    debugPrint(allergens[0]);
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  displayRemoveDialog(
      BuildContext context, AllergensViewModel viewModel, int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(LocaleKeys.allergens_DELETE_ALLERGEN.locale),
              actions: <Widget>[
                TextButton(
                  child: Text(LocaleKeys.allergens_CANCEL.locale),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                    child: Text(LocaleKeys.allergens_DELETE.locale),
                    onPressed: () {
                      setState(() {
                        allergens.removeAt(index);
                        Navigator.of(context).pop();
                      });
                    })
              ]);
        });
  }
}
