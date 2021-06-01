import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medication_app_v0/core/constants/image/image_constants.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
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
        child: buildCard(context),
      ),
    );
  }

  Card buildCard(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      color: _getColor(),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: context.paddingNormal,
              child: Row(
                children: [
                  Expanded(
                    child: randomLogo,
                  ),
                  context.emptySizedWidthBoxLow,
                  Expanded(
                    flex: 2,
                    child: AutoSizeText(
                      model.pillName,
                      style: context.textTheme.headline5
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
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
                  "${model.amount} ${LocaleKeys.home_REMINDER_LEFT.locale }",
                  style: context.textTheme.bodyText2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor() {
    if (model.isTaken) {
      return ColorTheme.GREEN_ACCENT;
    } else {
      if (DateTime.now().isAfter(model.time)) {
        return ColorTheme.RED_BUTTON.withOpacity(0.7);
      } else {
        return ColorTheme.BACKGROUND_WHITE;
      }
    }
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
}
