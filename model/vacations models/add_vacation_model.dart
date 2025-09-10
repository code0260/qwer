import 'dart:convert';

class AddVacationModel {
  int? vacationsEmployeesId;
  String? vacationsType;
  String? vacationsFrom;
  String? vacationsTo;
  String? vacationsReason;
  String? vacationsWorkDate;

  AddVacationModel({
    this.vacationsEmployeesId,
    this.vacationsType,
    this.vacationsFrom,
    this.vacationsTo,
    this.vacationsReason,
    this.vacationsWorkDate,
  });

  AddVacationModel copyWith({
    int? vacationsEmployeesId,
    String? vacationsType,
    String? vacationsFrom,
    String? vacationsTo,
    String? vacationsReason,
    String? vacationsWorkDate,
  }) {
    return AddVacationModel(
      vacationsEmployeesId: vacationsEmployeesId ?? this.vacationsEmployeesId,
      vacationsType: vacationsType ?? this.vacationsType,
      vacationsFrom: vacationsFrom ?? this.vacationsFrom,
      vacationsTo: vacationsTo ?? this.vacationsTo,
      vacationsReason: vacationsReason ?? this.vacationsReason,
      vacationsWorkDate: vacationsWorkDate ?? this.vacationsWorkDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vacations_employees_id': vacationsEmployeesId,
      'vacations_type': vacationsType,
      'vacations_from': vacationsFrom == null
          ? null
          : DateTime.parse(vacationsFrom!).toUtc().toString(),
      'vacations_to': vacationsTo == null
          ? null
          : DateTime.parse(vacationsTo!).toUtc().toString(),
      'vacations_reason': vacationsReason,
      'vacations_created_at': vacationsWorkDate == null
          ? null
          : DateTime.parse(vacationsWorkDate!).toUtc().toString(),
    };
  }

  factory AddVacationModel.fromMap(Map<String, dynamic> map) {
    return AddVacationModel(
      vacationsEmployeesId: map['vacations_employees_id'] != null
          ? map['vacations_employees_id'] as int
          : null,
      vacationsType: map['vacations_type'] != null
          ? map['vacations_type'] as String
          : null,
      vacationsFrom: map['vacations_from'] != null
          ? DateTime.parse('${map['vacations_from']}Z').toLocal().toString()
          : null,
      vacationsTo: map['vacations_to'] != null
          ? DateTime.parse('${map['vacations_to']}Z').toLocal().toString()
          : null,
      vacationsReason: map['vacations_reason'] != null
          ? map['vacations_reason'] as String
          : null,
      vacationsWorkDate: map['vacations_created_at'] != null
          ? DateTime.parse('${map['vacations_created_at']}Z')
              .toLocal()
              .toString()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddVacationModel.fromJson(String source) =>
      AddVacationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddVacationModel(vacationsEmployeesId: $vacationsEmployeesId, vacationsType: $vacationsType, vacationsFrom: $vacationsFrom, vacationsTo: $vacationsTo, vacationsReason: $vacationsReason, vacationsWorkDate: $vacationsWorkDate)';
  }

  @override
  bool operator ==(covariant AddVacationModel other) {
    if (identical(this, other)) return true;

    return other.vacationsEmployeesId == vacationsEmployeesId &&
        other.vacationsType == vacationsType &&
        other.vacationsFrom == vacationsFrom &&
        other.vacationsTo == vacationsTo &&
        other.vacationsReason == vacationsReason &&
        other.vacationsWorkDate == vacationsWorkDate;
  }

  @override
  int get hashCode {
    return vacationsEmployeesId.hashCode ^
        vacationsType.hashCode ^
        vacationsFrom.hashCode ^
        vacationsTo.hashCode ^
        vacationsReason.hashCode ^
        vacationsWorkDate.hashCode;
  }
}
