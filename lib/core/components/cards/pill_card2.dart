import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medication_app_v0/core/constants/image/image_constants.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';
import 'package:medication_app_v0/views/home/Calendar/model/reminder.dart';

class PillCard2 extends StatelessWidget {
  final ReminderModel model;
  final VoidCallback onTap;
  const PillCard2({Key key, @required this.model, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.15,
      width: double.infinity,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shadowColor: Colors.black,
          color: _getColor(),
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: context.paddingMedium,
                  child: Row(
                    children: [
                      Image(
                          image: AssetImage(ImageConstants.instance.pill4Logo)),
                      context.emptySizedWidthBoxLow,
                      Text(
                        model.pillName,
                        style: context.textTheme.headline6,
                      ),
//                    Icon(Icons.access_alarms),
//                    Text(
//                      DateFormat('kk:mm').format(model.time),
//                      style: context.textTheme.headline6,
//                    ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.access_alarms,
                          color: Colors.white,
                        ),
                        context.emptySizedWidthBoxLow3x,
                        Text(
                          DateFormat('kk:mm').format(model.time),
                          style: context.textTheme.headline6,
                        ),
                      ],
                    ),
                    Text(
                      "${model.amount} more reminder left",
                      style: context.textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColor() {
    if (DateTime.now().isAfter(model.time)) {
      if (model.isTaken) {
        return ColorTheme.GREEN_ACCENT;
      } else {
        return ColorTheme.RED_BUTTON.withOpacity(0.7);
      }
    }
    return ColorTheme.BACKGROUND_WHITE;
  }
}
