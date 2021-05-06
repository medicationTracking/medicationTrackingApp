import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';

class DateCard extends StatelessWidget {
  const DateCard({Key key, @required this.date}) : super(key: key);
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: StadiumBorder(),
      child: Center(
          child: AutoSizeText(
        DateFormat.yMd().format(date),
        style: context.textTheme.headline4.copyWith(color: Colors.black),
      )),
    );
  }
}
