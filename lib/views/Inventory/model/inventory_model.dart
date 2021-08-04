import 'dart:convert';

import 'package:flutter/material.dart';

class InventoryModel {
  String activeIngredient;
  String barcode;
  String company;
  String name;
  DateTime expiredDate;

  InventoryModel({
    this.activeIngredient,
    this.barcode,
    this.company,
    @required this.name,
    this.expiredDate,
  });

  InventoryModel copyWith({
    String activeIngredient,
    String barcode,
    String company,
    String name,
    DateTime expiredDate,
  }) {
    return InventoryModel(
      activeIngredient: activeIngredient ?? this.activeIngredient,
      barcode: barcode ?? this.barcode,
      company: company ?? this.company,
      name: name ?? this.name,
      expiredDate: expiredDate ?? this.expiredDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'activeIngredient': activeIngredient,
      'barcode': barcode,
      'company': company,
      'name': name,
      'expiredDate': expiredDate.millisecondsSinceEpoch,
    };
  }

  factory InventoryModel.fromMap(Map<String, dynamic> map) {
    return InventoryModel(
      activeIngredient: map['activeIngredient'],
      barcode: map['barcode'],
      company: map['company'],
      name: map['name'],
      expiredDate: map['expiredDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expiredDate'])
          : DateTime(2100),
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryModel.fromJson(String source) =>
      InventoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InventoryModel(activeIngredient: $activeIngredient, barcode: $barcode, company: $company, name: $name, expiredDate: $expiredDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InventoryModel &&
        other.activeIngredient == activeIngredient &&
        other.barcode == barcode &&
        other.company == company &&
        other.name == name &&
        other.expiredDate == expiredDate;
  }

  @override
  int get hashCode {
    return activeIngredient.hashCode ^
        barcode.hashCode ^
        company.hashCode ^
        name.hashCode ^
        expiredDate.hashCode;
  }
}
/*InventoryModel(
      {this.activeIngredient, this.barcode, this.company, this.name});

  InventoryModel.fromJson(Map<String, dynamic> json) {
    activeIngredient = json['activeIngredient'];
    barcode = json['barcode'];
    company = json['company'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activeIngredient'] = this.activeIngredient;
    data['barcode'] = this.barcode;
    data['company'] = this.company;
    data['name'] = this.name;
    return data;
  } */
