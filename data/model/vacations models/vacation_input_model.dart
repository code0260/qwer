import 'dart:convert';

class VacationInputModel {
  int? vacationsId;
  int? vacationsEmployeesId;
  String? vacationsType;
  String? vacationsFrom;
  String? vacationsTo;
  String? vacationsReason;
  String? vacationsCreatedAt;

  VacationInputModel({
    this.vacationsId,
    this.vacationsEmployeesId,
    this.vacationsType,
    this.vacationsFrom,
    this.vacationsTo,
    this.vacationsReason,
    this.vacationsCreatedAt,
  });

  VacationInputModel copyWith({
    int? vacationsId,
    int? vacationsEmployeesId,
    String? vacationsType,
    String? vacationsFrom,
    String? vacationsTo,
    String? vacationsReason,
    String? vacationsCreatedAt,
  }) {
    return VacationInputModel(
      vacationsId: vacationsId ?? this.vacationsId,
      vacationsEmployeesId: vacationsEmployeesId ?? this.vacationsEmployeesId,
      vacationsType: vacationsType ?? this.vacationsType,
      vacationsFrom: vacationsFrom ?? this.vacationsFrom,
      vacationsTo: vacationsTo ?? this.vacationsTo,
      vacationsReason: vacationsReason ?? this.vacationsReason,
      vacationsCreatedAt: vacationsCreatedAt ?? this.vacationsCreatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'vacations_id': vacationsId,
      'vacations_employees_id': vacationsEmployeesId,
      'vacations_type': vacationsType,
      'start_date': vacationsFrom == null
          ? null
          : DateTime.parse(vacationsFrom!).toUtc().toString(),
      'end_date': vacationsTo == null
          ? null
          : DateTime.parse(vacationsTo!).toUtc().toString(),
      'vacations_reason': vacationsReason,
      'vacations_created_at': vacationsCreatedAt == null
          ? null
          : DateTime.parse(vacationsCreatedAt!).toUtc().toString(),
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  factory VacationInputModel.fromMap(Map<String, dynamic> map) {
    return VacationInputModel(
      vacationsId:
          map['vacations_id'] != null ? map['vacations_id'] as int : null,
      vacationsEmployeesId: map['vacations_employees_id'] != null
          ? map['vacations_employees_id'] as int
          : null,
      vacationsType: map['vacations_type'] != null
          ? map['vacations_type'] as String
          : null,
      vacationsFrom: map['start_date'] != null
          ? DateTime.parse('${map['start_date']}Z').toLocal().toString()
          : null,
      vacationsTo: map['end_date'] != null
          ? DateTime.parse('${map['end_date']}Z').toLocal().toString()
          : null,
      vacationsReason: map['vacations_reason'] != null
          ? map['vacations_reason'] as String
          : null,
      vacationsCreatedAt: map['vacations_created_at'] != null
          ? DateTime.parse('${map['vacations_created_at']}Z')
              .toLocal()
              .toString()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VacationInputModel.fromJson(String source) =>
      VacationInputModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VacationInputModel(vacationsId: $vacationsId, vacationsEmployeesId: $vacationsEmployeesId, vacationsType: $vacationsType, vacationsFrom: $vacationsFrom, vacationsTo: $vacationsTo, vacationsReason: $vacationsReason, vacationsCreatedAt: $vacationsCreatedAt)';
  }

  @override
  bool operator ==(covariant VacationInputModel other) {
    if (identical(this, other)) return true;

    return other.vacationsId == vacationsId &&
        other.vacationsEmployeesId == vacationsEmployeesId &&
        other.vacationsType == vacationsType &&
        other.vacationsFrom == vacationsFrom &&
        other.vacationsTo == vacationsTo &&
        other.vacationsReason == vacationsReason &&
        other.vacationsCreatedAt == vacationsCreatedAt;
  }

  @override
  int get hashCode {
    return vacationsId.hashCode ^
        vacationsEmployeesId.hashCode ^
        vacationsType.hashCode ^
        vacationsFrom.hashCode ^
        vacationsTo.hashCode ^
        vacationsReason.hashCode ^
        vacationsCreatedAt.hashCode;
  }
}
