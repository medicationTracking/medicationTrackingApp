import 'dart:convert';

class ReminderModel {
  final String pillName;
  DateTime time;
  final int amount;
  bool isTaken;

  ReminderModel(
    this.pillName,
    this.time,
    this.amount,
    this.isTaken,
  );


  ReminderModel copyWith({
    String pillName,
    DateTime time,
    int amount,
    bool isTaken,
  }) {
    return ReminderModel(
      pillName ?? this.pillName,
      time ?? this.time,
      amount ?? this.amount,
      isTaken ?? this.isTaken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pillName': pillName,
      'time': time.millisecondsSinceEpoch,
      'amount': amount,
      'isTaken': isTaken,
    };
  }

  factory ReminderModel.fromMap(Map<String, dynamic> map) {
    return ReminderModel(
      map['pillName'],
      DateTime.fromMillisecondsSinceEpoch(map['time']),
      map['amount'],
      map['isTaken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReminderModel.fromJson(String source) => ReminderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReminderModel(pillName: $pillName, time: $time, amount: $amount, isTaken: $isTaken)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ReminderModel &&
      other.pillName == pillName &&
      other.time == time &&
      other.amount == amount &&
      other.isTaken == isTaken;
  }

  @override
  int get hashCode {
    return pillName.hashCode ^
      time.hashCode ^
      amount.hashCode ^
      isTaken.hashCode;
  }
}
