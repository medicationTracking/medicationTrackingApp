
import 'package:flutter/cupertino.dart';

class MedicationNotification {
  int notificationID;
  String notificationTitle;
  String notificationBody;
  String payload;
  DateTime notificationTime;

  MedicationNotification({
    @required this.notificationID,
    @required this.notificationTitle,
    @required this.notificationBody,
    @required this.notificationTime,
    this.payload,
  });
}
