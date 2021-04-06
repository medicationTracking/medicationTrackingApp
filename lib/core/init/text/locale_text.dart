import 'package:auto_size_text/auto_size_text.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';
import 'package:flutter/material.dart';

class LocaleText extends StatelessWidget {
  final String text;

  const LocaleText({Key key, @required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(text.locale);
  }

  String get getText => text;
}
