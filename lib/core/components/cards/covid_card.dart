import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';

class CovidCard extends StatelessWidget {
  final String leftTitle;
  final int leftValue;
  final Color leftColor;
  final String rightTitle;
  final int rightValue;
  final Color rightColor;

  const CovidCard(
      {Key key,
      @required this.leftTitle,
      @required this.leftValue,
      @required this.leftColor,
      @required this.rightTitle,
      @required this.rightValue,
      @required this.rightColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          context.emptySizedWidthBoxLow3x,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(leftTitle, style: context.textTheme.subtitle2),
                ),
                Expanded(
                  child: Text("Total",
                      style: context.textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.bold, color: leftColor)),
                ),
                Expanded(
                  flex: 2,
                  child: AutoSizeText(
                      NumberFormat.decimalPattern().format(leftValue),
                      style: context.textTheme.headline4.copyWith(
                          fontWeight: FontWeight.bold, color: leftColor)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child:
                        Text(rightTitle, style: context.textTheme.bodyText1)),
                Expanded(
                    child: Text("Total",
                        style: context.textTheme.subtitle2.copyWith(
                            fontWeight: FontWeight.bold, color: rightColor))),
                Expanded(
                  flex: 2,
                  child: AutoSizeText(
                      NumberFormat.decimalPattern().format(rightValue),
                      style: context.textTheme.headline4.copyWith(
                          fontWeight: FontWeight.bold, color: rightColor)),
                ),
              ],
            ),
          ),
          context.emptySizedWidthBoxLow3x,
        ],
      ),
    );
  }
}
