import 'dart:convert';
import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class SalarySlipModel extends Equatable {
  final String? employeesName;
  final int? salarySlipEmployeesId;
  final String? salarySlipPayPeriod;
  final String? salarySlipWorkFrom;
  final String? salarySlipWorkTo;
  final double? salarySlipTotalAllowances;
  final double? salarySlipTotalDeductions;
  final double? salarySlipNetSalary;
  final int? salarySlipAmountCurrencyId;
  final double? salarySlipNetSalaryInBase;

  const SalarySlipModel({
    this.employeesName,
    this.salarySlipEmployeesId,
    this.salarySlipPayPeriod,
    this.salarySlipWorkFrom,
    this.salarySlipWorkTo,
    this.salarySlipTotalAllowances,
    this.salarySlipTotalDeductions,
    this.salarySlipNetSalary,
    this.salarySlipAmountCurrencyId,
    this.salarySlipNetSalaryInBase,
  });

  factory SalarySlipModel.fromJson(Map<String, dynamic> json) {
    return SalarySlipModel(
      employeesName: json['employees_name'] as String?,
      salarySlipEmployeesId: json['salary_slip_employees_id'] as int?,
      salarySlipPayPeriod: json['salary_slip_pay_period'] as String?,
      salarySlipWorkFrom: json['salary_slip_work_from'] as String?,
      salarySlipWorkTo: json['salary_slip_work_to'] as String?,
      salarySlipTotalAllowances:
          receiveDouble(json['salary_slip_total_allowances']),
      salarySlipTotalDeductions:
          receiveDouble(json['salary_slip_total_deductions']),
      salarySlipNetSalary: receiveDouble(json['salary_slip_net_salary']),
      salarySlipAmountCurrencyId:
          json['salary_slip_amount_currency_id'] as int?,
      salarySlipNetSalaryInBase:
          receiveDouble(json['salary_slip_net_salary_in_base']),
    );
  }

  Map<String, dynamic> toMap() => {
        "employees_name": employeesName,
        'salary_slip_employees_id': salarySlipEmployeesId,
        'salary_slip_pay_period': salarySlipPayPeriod,
        'salary_slip_work_from': salarySlipWorkFrom,
        'salary_slip_work_to': salarySlipWorkTo,
        'salary_slip_total_allowances': salarySlipTotalAllowances,
        'salary_slip_total_deductions': salarySlipTotalDeductions,
        'salary_slip_net_salary': salarySlipNetSalary,
        'salary_slip_amount_currency_id': salarySlipAmountCurrencyId,
        'salary_slip_net_salary_in_base': salarySlipNetSalaryInBase,
      };

  String toJson() => jsonEncode(toMap());

  SalarySlipModel copyWith({
    String? employeesName,
    int? salarySlipEmployeesId,
    String? salarySlipPayPeriod,
    String? salarySlipWorkFrom,
    String? salarySlipWorkTo,
    double? salarySlipTotalAllowances,
    double? salarySlipTotalDeductions,
    double? salarySlipNetSalary,
    int? salarySlipAmountCurrencyId,
    double? salarySlipNetSalaryInBase,
  }) {
    return SalarySlipModel(
      employeesName: employeesName ?? this.employeesName,
      salarySlipEmployeesId:
          salarySlipEmployeesId ?? this.salarySlipEmployeesId,
      salarySlipPayPeriod: salarySlipPayPeriod ?? this.salarySlipPayPeriod,
      salarySlipWorkFrom: salarySlipWorkFrom ?? this.salarySlipWorkFrom,
      salarySlipWorkTo: salarySlipWorkTo ?? this.salarySlipWorkTo,
      salarySlipTotalAllowances:
          salarySlipTotalAllowances ?? this.salarySlipTotalAllowances,
      salarySlipTotalDeductions:
          salarySlipTotalDeductions ?? this.salarySlipTotalDeductions,
      salarySlipNetSalary: salarySlipNetSalary ?? this.salarySlipNetSalary,
      salarySlipAmountCurrencyId:
          salarySlipAmountCurrencyId ?? this.salarySlipAmountCurrencyId,
      salarySlipNetSalaryInBase:
          salarySlipNetSalaryInBase ?? this.salarySlipNetSalaryInBase,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      employeesName,
      salarySlipEmployeesId,
      salarySlipPayPeriod,
      salarySlipWorkFrom,
      salarySlipWorkTo,
      salarySlipTotalAllowances,
      salarySlipTotalDeductions,
      salarySlipNetSalary,
      salarySlipAmountCurrencyId,
      salarySlipNetSalaryInBase,
    ];
  }
}
