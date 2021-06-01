import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:medication_app_v0/core/base/view/base_widget.dart';
import 'package:medication_app_v0/core/components/cards/inventory_medication_card.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:medication_app_v0/core/init/text/locale_text.dart';
import 'package:medication_app_v0/views/Inventory/model/inventory_model.dart';
import 'package:medication_app_v0/views/intake_medication/viewmodel/intake_medication_viewmodel.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';
import 'package:medication_app_v0/core/components/widgets/drawer.dart';

class IntakeMedicationView extends StatelessWidget {
  const IntakeMedicationView({Key key, this.medication}) : super(key: key);
  final InventoryModel medication;

  @override
  Widget build(BuildContext context) {
    return BaseView(
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        model: IntakeMedicationViewModel(),
        builder: (BuildContext context, IntakeMedicationViewModel viewmodel) =>
            buildScaffold(context, viewmodel));
  }

  Scaffold buildScaffold(
      BuildContext context, IntakeMedicationViewModel viewmodel) {
    return Scaffold(
      appBar: AppBar(
        title: LocaleText(text: LocaleKeys.reminder_SET_REMINDER),
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: context.paddingLow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            displaySelectedMedication(),
            buildPeriodDropdownButton(viewmodel),
            buildSelectTimes(viewmodel),
            buildTimePicker(viewmodel),
            buildDatePicker(viewmodel, context),
            Padding(
              padding: context.paddingHighHorizontal,
              child: TextField(
                controller: viewmodel.numberOfReminderController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "number of reminder",
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  bool hasReminderSaved = await viewmodel
                      .saveMedicationIntakeButtonOnPress(medication);
                  final _snackBar = SnackBar(
                    content: hasReminderSaved
                        ? Text("Reminder saved Succesfully")
                        : Text("Reminder failed"),
                    backgroundColor:
                        hasReminderSaved ? Colors.green : Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                },
                child: LocaleText(text: LocaleKeys.reminder_SAVE_REMINDER))
          ],
        ),
      ),
    );
  }

  Row buildReminderNumberPicker(IntakeMedicationViewModel viewmodel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("İlaç alım sayısı:"),
        TextField(
          keyboardType: TextInputType.number,
          controller: viewmodel.numberOfReminderController,
          decoration: InputDecoration(),
        )
      ],
    );
  }

  Observer buildDatePicker(
      IntakeMedicationViewModel viewmodel, BuildContext context) {
    return Observer(
      builder: (_) => Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LocaleText(text: LocaleKeys.reminder_DATE),
            TextButton.icon(
                onPressed: () {
                  viewmodel.pickDate(context);
                },
                icon: Icon(Icons.date_range),
                label: viewmodel.date != null
                    ? Text(DateFormat.yMd().format(viewmodel.date))
                    : Text(""))
          ],
        ),
      ),
    );
  }

  Observer buildTimePicker(IntakeMedicationViewModel viewmodel) {
    return Observer(
      builder: (_) => Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LocaleText(text: LocaleKeys.reminder_FIRST_TIME),
            TextButton.icon(
                label: viewmodel.selectedTime != null
                    ? Text(viewmodel.selectedTime)
                    : Text("  "),
                icon: Icon(Icons.alarm),
                onPressed: () {
                  viewmodel.pickTime();
                }),
          ],
        ),
      ),
    );
  }

  Observer buildSelectTimes(IntakeMedicationViewModel viewmodel) {
    return Observer(
      builder: (_) => Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LocaleText(text: LocaleKeys.reminder_TIMES),
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      viewmodel.incrementTimes(1);
                    }),
                Text(viewmodel.times.toString()),
                IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      viewmodel.incrementTimes(-1);
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Observer buildPeriodDropdownButton(IntakeMedicationViewModel viewmodel) {
    return Observer(
      builder: (_) => Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LocaleText(text: LocaleKeys.reminder_PERIOD),
            DropdownButton(
              value: viewmodel.period,
              items: viewmodel
                  .getPeriodList()
                  .map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String newValue) {
                viewmodel.setPeriod(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget displaySelectedMedication() {
    return GestureDetector(
      onTap: () {
        print("aler box çıkartıp qr kodlamaya yönlendir");
      },
      child: InventoryMedicationCard(
          model: medication ??
              InventoryModel(
                  barcode: "barcode",
                  name: "name",
                  activeIngredient: "activeIngredient",
                  company: "company")),
    );
  }
}
