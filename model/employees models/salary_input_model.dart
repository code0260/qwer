// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class SalaryInputModel extends Equatable {
  int? employeeId;
  DateTime? startDate;
  DateTime? endDate;
  int? salariesId;
  double? salariesAmount; // Already double?
  int? salariesAmountCurrencyId; // New field
  double? salariesAmountInBase; // New field
  String? salariesFrequency;
  String? salariesPayTime;
  String? salariesCreatedAt;

  SalaryInputModel({
    this.employeeId,
    this.startDate,
    this.endDate,
    this.salariesId,
    this.salariesAmount,
    this.salariesAmountCurrencyId, // New field
    this.salariesAmountInBase, // New field
    this.salariesFrequency,
    this.salariesPayTime,
    this.salariesCreatedAt,
  });

  @override
  List<Object?> get props => [
        employeeId,
        startDate,
        endDate,
        salariesId,
        salariesAmount,
        salariesAmountCurrencyId, // New field
        salariesAmountInBase, // New field
        salariesFrequency,
        salariesPayTime,
        salariesCreatedAt,
      ];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'salaries_employees_id': employeeId,
      'start_date': startDate?.toUtc().toString(),
      'end_date': endDate?.toUtc().toString(),
      'salaries_id': salariesId,
      'salaries_amount': salariesAmount,
      'salaries_amount_currency_id': salariesAmountCurrencyId, // New field
      'salaries_amount_in_base': salariesAmountInBase, // New field
      'salaries_frequency': salariesFrequency,
      'salaries_pay_time': salariesPayTime,
      'salaries_created_at': salariesCreatedAt == null
          ? null
          : DateTime.parse(salariesCreatedAt!).toUtc().toString(),
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  factory SalaryInputModel.fromMap(Map<String, dynamic> map) {
    return SalaryInputModel(
      employeeId: map['salaries_employees_id'] as int?,
      startDate: map['start_date'] != null
          ? DateTime.parse(map['start_date']).toLocal()
          : null,
      endDate: map['end_date'] != null
          ? DateTime.parse(map['end_date']).toLocal()
          : null,
      salariesId: map['salaries_id'] as int?,
      salariesAmount: receiveDouble(map['salaries_amount']), // Parsing logic
      salariesAmountCurrencyId:
          map['salaries_amount_currency_id'] as int?, // New field
      salariesAmountInBase:
          receiveDouble(map['salaries_amount_in_base']), // New field
      salariesFrequency: map['salaries_frequency'] as String?,
      salariesPayTime: map['salaries_pay_time'],
      salariesCreatedAt: map['salaries_created_at'] == null
          ? null
          : DateTime.parse('${map['salaries_created_at']}Z')
              .toLocal()
              .toString(),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory SalaryInputModel.fromJson(String source) =>
      SalaryInputModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
