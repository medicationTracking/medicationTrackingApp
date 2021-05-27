import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/constants/image/image_constants.dart';
import 'package:medication_app_v0/core/constants/navigation/navigation_constants.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:medication_app_v0/core/init/navigation/navigation_service.dart';
import 'package:medication_app_v0/views/Inventory/model/inventory_model.dart';

class InventoryMedicationCard extends StatelessWidget {
  final InventoryModel model;

  const InventoryMedicationCard({Key key, @required this.model})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.2,
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: buildInsideCard(context),
      ),
    );
  }

  Row buildInsideCard(BuildContext context) {
    return Row(
      children: [
        Expanded(child: buildPillPicture(context)),
        context.emptySizedWidthBoxLow3x,
        Expanded(
          flex: 4,
          child: buildMedicationTexts(context),
        ),
        Expanded(child: buildSeeDetailButton(context))
      ],
    );
  }

  //display pill logo
  Padding buildPillPicture(BuildContext context) {
    return Padding(padding: context.paddingLow, child: randomLogo);
  }

  //create random pill logo
  Image get randomLogo {
    final x = Random.secure();
    switch (x.nextInt(4)) {
      case 1:
        return Image(image: AssetImage(ImageConstants.instance.pill1Logo));
      case 2:
        return Image(image: AssetImage(ImageConstants.instance.pill2Logo));
      case 3:
        return Image(image: AssetImage(ImageConstants.instance.pill3Logo));
      default:
        return Image(image: AssetImage(ImageConstants.instance.pill4Logo));
    }
  }

  //display medication name, active Ingredient and company
  Column buildMedicationTexts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 2,
            child: model.name == null
                ? Text("")
                : AutoSizeText(
                    model.name,
                    style: context.textTheme.headline5.copyWith(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  )),
        Expanded(
            child: model.activeIngredient == null
                ? Text("")
                : AutoSizeText(
                    model.activeIngredient,
                    style: context.textTheme.bodyText1,
                  )),
        Expanded(
            child: model.company == null
                ? Text("")
                : AutoSizeText(
                    model.company,
                    style: context.textTheme.subtitle1,
                  )),
        Expanded(
            child: model.expiredDate.compareTo(DateTime(2100)) == 0
                ? Text("")
                : Text(LocaleKeys.add_medication_EXPIRED_DATE.locale +
                    " : " +
                    DateFormat("dd-MM-yyyy")
                        .format(model.expiredDate)
                        .toString()))
      ],
    );
  }

  //navigate to see medication details
  IconButton buildSeeDetailButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        //await AuthManager.instance.deleteMedication(model);
        NavigationService navigation = NavigationService.instance;
        navigation.navigateToPage(
            path: NavigationConstants.INTAKE_VIEW, object: model);
      },
      icon: Icon(Icons.alarm_add),
      iconSize: context.height * 0.07,
    );
  }
}
