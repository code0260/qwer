// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EditEmployeeModel {
  String? employeesName;
  String? employeesEmail;
  String? employeesPhone;
  String? employeesAddress;
  String? employeesPosition;
  String? employeesWorkDate;
  String? employeesNotes;
  int? employeesDepartmentsId;
  int? employeesId;
  String? employeesTerminationDate; // Added employeesTerminationDate property

  EditEmployeeModel({
    this.employeesName,
    this.employeesEmail,
    this.employeesPhone,
    this.employeesAddress,
    this.employeesPosition,
    this.employeesWorkDate,
    this.employeesNotes,
    this.employeesDepartmentsId,
    this.employeesId,
    this.employeesTerminationDate, // Added employeesTerminationDate to the constructor
  });

  EditEmployeeModel copyWith({
    String? employeesName,
    String? employeesEmail,
    String? employeesPhone,
    String? employeesAddress,
    String? employeesPosition,
    String? employeesWorkDate,
    String? employeesNotes,
    int? employeesDepartmentsId,
    int? employeesId,
    String?
        employeesTerminationDate, // Added employeesTerminationDate to the copyWith method
  }) {
    return EditEmployeeModel(
      employeesName: employeesName ?? this.employeesName,
      employeesEmail: employeesEmail ?? this.employeesEmail,
      employeesPhone: employeesPhone ?? this.employeesPhone,
      employeesAddress: employeesAddress ?? this.employeesAddress,
      employeesPosition: employeesPosition ?? this.employeesPosition,
      employeesWorkDate: employeesWorkDate ?? this.employeesWorkDate,
      employeesNotes: employeesNotes ?? this.employeesNotes,
      employeesDepartmentsId:
          employeesDepartmentsId ?? this.employeesDepartmentsId,
      employeesId: employeesId ?? this.employeesId,
      employeesTerminationDate: employeesTerminationDate ??
          this.employeesTerminationDate, // Added employeesTerminationDate to the returned model
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
      'employees_id': employeesId,
      'employees_termination_date':
          employeesTerminationDate, // Added employeesTerminationDate to the map
    };
    map.removeWhere(
      (key, value) {
        return value == "" || value == null;
      },
    );
    return map;
  }

  factory EditEmployeeModel.fromMap(Map<String, dynamic> map) {
    return EditEmployeeModel(
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
      employeesId:
          map['employees_id'] != null ? map['employees_id'] as int : null,
      employeesTerminationDate: map['employees_termination_date'] != null
          ? map['employees_termination_date'] as String
          : null, // Added employeesTerminationDate to the factory method
    );
  }

  String toJson() => json.encode(toMap());

  factory EditEmployeeModel.fromJson(String source) =>
      EditEmployeeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EditEmployeeModel(employeesName: $employeesName, employeesEmail: $employeesEmail, employeesPhone: $employeesPhone, employeesAddress: $employeesAddress, employeesPosition: $employeesPosition, employeesWorkDate: $employeesWorkDate, employeesNotes: $employeesNotes, employeesDepartmentsId: $employeesDepartmentsId, employeesId: $employeesId, employeesTerminationDate: $employeesTerminationDate)';
  }

  @override
  bool operator ==(covariant EditEmployeeModel other) {
    if (identical(this, other)) return true;

    return other.employeesName == employeesName &&
        other.employeesEmail == employeesEmail &&
        other.employeesPhone == employeesPhone &&
        other.employeesAddress == employeesAddress &&
        other.employeesPosition == employeesPosition &&
        other.employeesWorkDate == employeesWorkDate &&
        other.employeesNotes == employeesNotes &&
        other.employeesDepartmentsId == employeesDepartmentsId &&
        other.employeesId == employeesId &&
        other.employeesTerminationDate ==
            employeesTerminationDate; // Added employeesTerminationDate to equality check
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
        employeesId.hashCode ^
        employeesTerminationDate
            .hashCode; // Added employeesTerminationDate to hashCode
  }
}
