// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:almonazim/data/model/employees%20models/salary_input_model.dart';

class AddEmployeeModel {
  String? employeesName;
  String? employeesEmail;
  String? employeesPhone;
  String? employeesAddress;
  String? employeesPosition;
  String? employeesWorkDate;
  String? employeesNotes;
  int? employeesDepartmentsId;
  SalaryInputModel salaryInputModel = SalaryInputModel();
  AddEmployeeModel({
    this.employeesName,
    this.employeesEmail,
    this.employeesPhone,
    this.employeesAddress,
    this.employeesPosition,
    this.employeesWorkDate,
    this.employeesNotes,
    this.employeesDepartmentsId,
  });

  AddEmployeeModel copyWith({
    String? employeesName,
    String? employeesEmail,
    String? employeesPhone,
    String? employeesAddress,
    String? employeesPosition,
    String? employeesWorkDate,
    String? employeesNotes,
    int? employeesDepartmentsId,
    SalaryInputModel? salaryInputModel,
  }) {
    return AddEmployeeModel(
      employeesName: employeesName ?? this.employeesName,
      employeesEmail: employeesEmail ?? this.employeesEmail,
      employeesPhone: employeesPhone ?? this.employeesPhone,
      employeesAddress: employeesAddress ?? this.employeesAddress,
      employeesPosition: employeesPosition ?? this.employeesPosition,
      employeesWorkDate: employeesWorkDate ?? this.employeesWorkDate,
      employeesNotes: employeesNotes ?? this.employeesNotes,
      employeesDepartmentsId:
          employeesDepartmentsId ?? this.employeesDepartmentsId,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'employees_name': employeesName,
      'employees_email': employeesEmail,
      'employees_phone': employeesPhone,
      'employees_address': employeesAddress,
      'employees_position': employeesPosition,
      'employees_hire_date': employeesWorkDate,
      'employees_notes': employeesNotes,
      'employees_departments_id': employeesDepartmentsId,
      'salary': salaryInputModel.toMap(),
    };
    map.removeWhere(
      (key, value) {
        return value == "";
      },
    );
    return map;
  }

  factory AddEmployeeModel.fromMap(Map<String, dynamic> map) {
    return AddEmployeeModel(
      employeesName: map['employees_name'] != null
          ? map['employees_name'] as String
          : null,
      employeesEmail: map['employees_email'] != null
          ? map['employees_email'] as String
          : null,
      employeesPhone: map['employees_phone'] != null
          ? map['employees_phone'] as String
          : null,
      employeesAddress: map['employees_address'] != null
          ? map['employees_address'] as String
          : null,
      employeesPosition: map['employees_position'] != null
          ? map['employees_position'] as String
          : null,
      employeesWorkDate: map['employees_hire_date'] != null
          ? map['employees_hire_date'] as String
          : null,
      employeesNotes: map['employees_notes'] != null
          ? map['employees_notes'] as String
          : null,
      employeesDepartmentsId: map['employees_departments_id'] != null
          ? map['employees_departments_id'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddEmployeeModel.fromJson(String source) =>
      AddEmployeeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddEmployeeModel(employeesName: $employeesName, employeesEmail: $employeesEmail, employeesPhone: $employeesPhone, employeesAddress: $employeesAddress, employeesPosition: $employeesPosition, employeesWorkDate: $employeesWorkDate, employeesNotes: $employeesNotes, employeesDepartmentsId: $employeesDepartmentsId, salaryInputModel: $salaryInputModel)';
  }

  @override
  bool operator ==(covariant AddEmployeeModel other) {
    if (identical(this, other)) return true;

    return other.employeesName == employeesName &&
        other.employeesEmail == employeesEmail &&
        other.employeesPhone == employeesPhone &&
        other.employeesAddress == employeesAddress &&
        other.employeesPosition == employeesPosition &&
        other.employeesWorkDate == employeesWorkDate &&
        other.employeesNotes == employeesNotes &&
        other.employeesDepartmentsId == employeesDepartmentsId &&
        other.salaryInputModel == salaryInputModel;
  }

  @override
  int get hashCode {
    return employeesName.hashCode ^
        employeesEmail.hashCode ^
        employeesPhone.hashCode ^
        employeesAddress.hashCode ^
        employeesPosition.hashCode ^
        employeesWorkDate.hashCode ^
        employeesNotes.hashCode ^
        employeesDepartmentsId.hashCode ^
        salaryInputModel.hashCode;
  }
}
