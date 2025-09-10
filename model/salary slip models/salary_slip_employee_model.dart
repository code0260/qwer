// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:almonazim/data/model/salary%20slip%20models/salary_slip_model.dart';

// ignore: must_be_immutable
class SalarySlipEmployeeModel extends Equatable {
  List<SalarySlipModel> salarySlips;
  String employeeName;
  SalarySlipEmployeeModel({
    required this.salarySlips,
    required this.employeeName,
  });

  SalarySlipEmployeeModel copyWith({
    List<SalarySlipModel>? salarySlips,
    String? employeeName,
  }) {
    return SalarySlipEmployeeModel(
      salarySlips: salarySlips ?? this.salarySlips,
      employeeName: employeeName ?? this.employeeName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'salary_slips': salarySlips.map((x) => x.toJson()).toList(),
      'employees_name': employeeName,
    };
  }

  factory SalarySlipEmployeeModel.fromMap(Map<String, dynamic> map) {
    return SalarySlipEmployeeModel(
      salarySlips: List<SalarySlipModel>.from(
        (map['salary_slips'] as List<dynamic>).map<SalarySlipModel>(
          (x) => SalarySlipModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      employeeName: map['employees_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SalarySlipEmployeeModel.fromJson(String source) =>
      SalarySlipEmployeeModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SalarySlipEmployeeModel(salarySlips: $salarySlips, employeeName: $employeeName)';

  @override
  // TODO: implement props
  List<Object?> get props => [employeeName, salarySlips];
}
