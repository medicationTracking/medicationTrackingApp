import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';
import 'package:medication_app_v0/views/home/Calendar/model/reminder.dart';

class PillCard2 extends StatelessWidget {
  final ReminderModel model;

  const PillCard2({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.2,
      width: double.infinity,
      child: Card(
        shadowColor: Colors.black,
        color: model.isTaken ? ColorTheme.GREEN_ACCENT : ColorTheme.RED_ACCENT,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: context.paddingMedium,
                child: Text(
                  DateFormat('kk:mm').format(model.time),
                  style: context.textTheme.headline3,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    model.pillName,
                    style: context.textTheme.headline6,
                  ),
                  Text(
                    "${model.amount} gr",
                    style: context.textTheme.headline6,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
