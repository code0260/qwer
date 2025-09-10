import 'package:equatable/equatable.dart';

class EmployeesDepartmentsModel extends Equatable {
  final int? employeesDepartmentsId;
  final String? employeesDepartmentsName;
  final String? employeesDepartmentsCreatedAt;
  final int? employeesDepartmentsBusinessId;

  const EmployeesDepartmentsModel({
    this.employeesDepartmentsId,
    this.employeesDepartmentsName,
    this.employeesDepartmentsCreatedAt,
    this.employeesDepartmentsBusinessId,
  });

  factory EmployeesDepartmentsModel.fromJson(Map<String, dynamic> json) {
    return EmployeesDepartmentsModel(
      employeesDepartmentsId: json['employees_departments_id'] as int?,
      employeesDepartmentsName: json['employees_departments_name'] as String?,
      employeesDepartmentsCreatedAt:
          parseUtcToLocal(json['employees_departments_created_at']),
      employeesDepartmentsBusinessId:
          json['employees_departments_business_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'employees_departments_id': employeesDepartmentsId,
        'employees_departments_name': employeesDepartmentsName,
        'employees_departments_created_at':
            parseLocalToUtc(employeesDepartmentsCreatedAt),
        'employees_departments_business_id': employeesDepartmentsBusinessId,
      };

  static String? parseUtcToLocal(String? date) {
    return date != null ? DateTime.parse(date).toLocal().toString() : null;
  }

  static String? parseLocalToUtc(String? date) {
    return date != null ? DateTime.parse(date).toUtc().toString() : null;
  }

  @override
  List<Object?> get props {
    return [
      employeesDepartmentsId,
      employeesDepartmentsName,
      employeesDepartmentsCreatedAt,
      employeesDepartmentsBusinessId,
    ];
  }
}
