import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/constants/image/image_constants.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';
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
        Expanded(child: buildAPicture(context)),
        context.emptySizedWidthBoxLow3x,
        Expanded(
          flex: 4,
          child: buildMedicationTexts(context),
        ),
        Expanded(child: buildSeeDetailButton(context))
      ],
    );
  }

  Padding buildAPicture(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: Image(
        image: AssetImage(ImageConstants.instance.googleLogo),
      ),
    );
  }

  Column buildMedicationTexts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 2,
            child:
                AutoSizeText(model.name, style: context.textTheme.headline1)),
        Expanded(child: Text(model.activeIngredient)),
        Expanded(child: Text(model.company))
      ],
    );
  }

  IconButton buildSeeDetailButton(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(Icons.search_rounded),
      iconSize: context.height * 0.07,
    );
  }
}
