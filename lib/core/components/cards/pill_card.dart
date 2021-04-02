import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medication_app_v0/views/home/Calendar/model/reminder.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';

class PillCard extends StatelessWidget {
  final ReminderModel reminder;

  const PillCard({Key key, @required this.reminder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      width: double.infinity,
      child: Card(
        shadowColor: Colors.black,
        color: reminder.isTaken ? Colors.green.shade500 : Colors.red.shade500,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(flex: 2, child: Icon(Icons.medical_services)),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(reminder.pillName,style: context.textTheme.headline6,),
                  Text("${reminder.amount} gr",style: context.textTheme.headline6,),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Text(DateFormat('kk:mm').format(reminder.time),style: context.textTheme.headline6,),
                  context.emptySizedWidthBoxLow,
                  Icon(Icons.alarm),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
