// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SalarySlipInputModel {
  DateTime? startDate;
  DateTime? endDate;
  int? employeeId;

  SalarySlipInputModel({
    this.startDate,
    this.endDate,
    this.employeeId,
  });

  SalarySlipInputModel copyWith({
    DateTime? startDate,
    DateTime? endDate,
    int? employeeId,
  }) {
    return SalarySlipInputModel(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      employeeId: employeeId ?? this.employeeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'start_date': startDate?.toUtc().toString(),
      'end_date': endDate?.toUtc().toString(),
      'employees_id': employeeId,
    };
  }

  factory SalarySlipInputModel.fromMap(Map<String, dynamic> map) {
    return SalarySlipInputModel(
      startDate: map['start_date'] != null
          ? DateTime.parse(map['start_date']).toLocal()
          : null,
      endDate: map['end_date'] != null
          ? DateTime.parse(map['end_date']).toLocal()
          : null,
      employeeId:
          map['employees_id'] != null ? map['employees_id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SalarySlipInputModel.fromJson(String source) =>
      SalarySlipInputModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SalarySlipInputModel(startDate: $startDate, endDate: $endDate, employeeId: $employeeId)';

  @override
  bool operator ==(covariant SalarySlipInputModel other) {
    if (identical(this, other)) return true;

    return other.startDate == startDate &&
        other.endDate == endDate &&
        other.employeeId == employeeId;
  }

  @override
  int get hashCode =>
      startDate.hashCode ^ endDate.hashCode ^ employeeId.hashCode;
}
