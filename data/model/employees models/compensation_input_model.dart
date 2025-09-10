import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CompensationInputModel extends Equatable {
  int? salariesCompensationsId;
  int? employeeId;
  DateTime? startDate;
  DateTime? endDate;
  String? salariesCompensationsCreatedAt;
  double? salariesCompensationsAmount;
  String? salariesCompensationsReason;
  String? salariesCompensationsType;
  int? salariesCompensationAmountCurrencyId; // New field
  double? salariesCompensationAmountInBase; // New field

  CompensationInputModel({
    this.salariesCompensationsId,
    this.employeeId,
    this.salariesCompensationAmountCurrencyId,
    this.salariesCompensationAmountInBase,
    this.startDate,
    this.endDate,
    this.salariesCompensationsCreatedAt,
    this.salariesCompensationsAmount,
    this.salariesCompensationsReason,
    this.salariesCompensationsType,
  });

  @override
  List<Object?> get props => [
        salariesCompensationsId,
        employeeId,
        startDate,
        salariesCompensationAmountInBase,
        salariesCompensationAmountCurrencyId,
        endDate,
        salariesCompensationsCreatedAt,
        salariesCompensationsAmount,
        salariesCompensationsReason,
        salariesCompensationsType,
      ];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'salaries_compensation_id': salariesCompensationsId,
      'salaries_compensation_employees_id': employeeId,
      'start_date': startDate?.toUtc().toString(),
      'end_date': endDate?.toUtc().toString(),
      'salaries_compensation_created_at': salariesCompensationsCreatedAt == null
          ? null
          : DateTime.parse(salariesCompensationsCreatedAt!).toUtc().toString(),
      'salaries_compensation_amount': salariesCompensationsAmount,
      'salaries_compensation_reason': salariesCompensationsReason,
      'salaries_compensation_type': salariesCompensationsType,
      'salaries_compensation_amount_currency_id':
          salariesCompensationAmountCurrencyId,
      'salaries_compensation_amount_in_base': salariesCompensationAmountInBase
    };
    map.removeWhere((key, value) => value == null); // Remove null values
    return map;
  }

  String toJson() => jsonEncode(toMap());
}
