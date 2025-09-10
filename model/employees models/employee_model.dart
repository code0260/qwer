import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class EmployeeModel extends Equatable {
  final int? employeesId;
  final int? employeesBusinessId;
  final String? employeesName;
  final String? employeesEmail;
  final String? employeesPhone;
  final String? employeesAddress;
  final String? employeesPosition;
  final String? employeesHireDate;
  final String? employeesTerminationDate;
  final String? employeesNotes;
  final String? employeesCreatedAt;
  final String? employeesUpdatedAt;
  final int? employeesDepartmentsId;
  final String? lastAmountCreatedAt;
  final double? lastAmount;
  final int? lastAmountCurrencyId;
  final int? salariesId;
  final String? salariesFrequency; // New property

  const EmployeeModel({
    this.employeesId,
    this.employeesBusinessId,
    this.employeesName,
    this.employeesEmail,
    this.employeesPhone,
    this.employeesAddress,
    this.employeesPosition,
    this.employeesHireDate,
    this.employeesTerminationDate,
    this.employeesNotes,
    this.employeesCreatedAt,
    this.employeesUpdatedAt,
    this.employeesDepartmentsId,
    this.lastAmountCreatedAt,
    this.lastAmount,
    this.lastAmountCurrencyId,
    this.salariesId,
    this.salariesFrequency, // New property
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        employeesId: json['employees_id'] as int?,
        employeesBusinessId: json['employees_business_id'] as int?,
        employeesName: json['employees_name'] as String?,
        employeesEmail: json['employees_email'] as String?,
        employeesPhone: json['employees_phone'] as String?,
        employeesAddress: json['employees_address'] as String?,
        employeesPosition: json['employees_position'] as String?,
        employeesHireDate: json['employees_hire_date'],
        employeesTerminationDate: json['employees_termination_date'],
        employeesNotes: json['employees_notes'] as String?,
        employeesCreatedAt: parseUtcToLocal(json['employees_created_at']),
        employeesUpdatedAt: parseUtcToLocal(json['employees_updated_at']),
        employeesDepartmentsId: json['employees_departments_id'] as int?,
        lastAmountCreatedAt: parseUtcToLocal(json['salaries_amount_createdAt']),
        lastAmount: receiveDouble(json['salaries_amount']),
        salariesId: json['salaries_id'] as int?,
        lastAmountCurrencyId: json['salaries_amount_currency_id'] as int?,
        salariesFrequency:
            json['salaries_frequency'] as String?, // New property
      );

  Map<String, dynamic> toJson() => {
        'employees_id': employeesId,
        'employees_business_id': employeesBusinessId,
        'employees_name': employeesName,
        'employees_email': employeesEmail,
        'employees_phone': employeesPhone,
        'employees_address': employeesAddress,
        'employees_position': employeesPosition,
        'employees_hire_date': employeesHireDate,
        'employees_termination_date': employeesTerminationDate,
        'employees_notes': employeesNotes,
        'employees_created_at': parseLocalToUtc(employeesCreatedAt),
        'employees_updated_at': parseLocalToUtc(employeesUpdatedAt),
        'employees_departments_id': employeesDepartmentsId,
        'salaries_amount_createdAt': parseLocalToUtc(lastAmountCreatedAt),
        'salaries_amount': lastAmount,
        'salaries_id': salariesId,
        'salaries_amount_currency_id': lastAmountCurrencyId,
        'salaries_frequency': salariesFrequency, // New property
      };

  EmployeeModel copyWith({
    int? employeesId,
    int? employeesBusinessId,
    String? employeesName,
    String? employeesEmail,
    String? employeesPhone,
    String? employeesAddress,
    String? employeesPosition,
    String? employeesHireDate,
    String? employeesTerminationDate,
    String? employeesNotes,
    String? employeesCreatedAt,
    String? employeesUpdatedAt,
    int? employeesDepartmentsId,
    String? lastAmountCreatedAt,
    double? lastAmount,
    int? salariesId,
    String? salariesFrequency, // New property
  }) {
    return EmployeeModel(
      employeesId: employeesId ?? this.employeesId,
      employeesBusinessId: employeesBusinessId ?? this.employeesBusinessId,
      employeesName: employeesName ?? this.employeesName,
      employeesEmail: employeesEmail ?? this.employeesEmail,
      employeesPhone: employeesPhone ?? this.employeesPhone,
      employeesAddress: employeesAddress ?? this.employeesAddress,
      employeesPosition: employeesPosition ?? this.employeesPosition,
      employeesHireDate: employeesHireDate ?? this.employeesHireDate,
      employeesTerminationDate:
          employeesTerminationDate ?? this.employeesTerminationDate,
      employeesNotes: employeesNotes ?? this.employeesNotes,
      employeesCreatedAt: employeesCreatedAt ?? this.employeesCreatedAt,
      employeesUpdatedAt: employeesUpdatedAt ?? this.employeesUpdatedAt,
      employeesDepartmentsId:
          employeesDepartmentsId ?? this.employeesDepartmentsId,
      lastAmountCreatedAt: lastAmountCreatedAt ?? this.lastAmountCreatedAt,
      lastAmount: lastAmount ?? this.lastAmount,
      salariesId: salariesId ?? this.salariesId,
      salariesFrequency:
          salariesFrequency ?? this.salariesFrequency, // New property
    );
  }

  static String? parseUtcToLocal(String? date) {
    return date != null ? DateTime.parse(date).toLocal().toString() : null;
  }

  static String? parseLocalToUtc(String? date) {
    return date != null ? DateTime.parse(date).toUtc().toString() : null;
  }

  @override
  List<Object?> get props {
    return [
      employeesId,
      employeesBusinessId,
      employeesName,
      employeesEmail,
      employeesPhone,
      employeesAddress,
      employeesPosition,
      employeesHireDate,
      employeesTerminationDate,
      employeesNotes,
      employeesCreatedAt,
      employeesUpdatedAt,
      employeesDepartmentsId,
      lastAmountCreatedAt,
      lastAmount,
      salariesId,
      salariesFrequency, // New property
    ];
  }
}
