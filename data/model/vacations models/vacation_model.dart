import 'package:equatable/equatable.dart';

class VacationModel extends Equatable {
  final int? vacationsId;
  final int? vacationsEmployeesId;
  final String? vacationsType;
  final String? vacationsFrom;
  final String? vacationsTo;
  final String? vacationsReason;
  final String? vacationsCreatedAt;

  const VacationModel({
    this.vacationsId,
    this.vacationsEmployeesId,
    this.vacationsType,
    this.vacationsFrom,
    this.vacationsTo,
    this.vacationsReason,
    this.vacationsCreatedAt,
  });

  factory VacationModel.fromJson(Map<String, dynamic> json) => VacationModel(
        vacationsId: json['vacations_id'] as int?,
        vacationsEmployeesId: json['vacations_employees_id'] as int?,
        vacationsType: json['vacations_type'] as String?,
        vacationsFrom: json['vacations_from'],
        vacationsTo: json['vacations_to'],
        vacationsReason: json['vacations_reason'] as String?,
        vacationsCreatedAt: json['vacations_created_at'] != null
            ? DateTime.parse('${json['vacations_created_at']}Z')
                .toLocal()
                .toString()
            : null,
      );

  Map<String, dynamic> toJson() => {
        'vacations_id': vacationsId,
        'vacations_employees_id': vacationsEmployeesId,
        'vacations_type': vacationsType,
        'vacations_from': vacationsFrom,
        'vacations_to': vacationsTo,
        'vacations_reason': vacationsReason,
        'vacations_created_at': vacationsCreatedAt == null
            ? null
            : DateTime.parse(vacationsCreatedAt!).toUtc().toString(),
      };

  VacationModel copyWith({
    int? vacationsId,
    int? vacationsEmployeesId,
    String? vacationsType,
    String? vacationsFrom,
    String? vacationsTo,
    String? vacationsReason,
    String? vacationsCreatedAt,
  }) {
    return VacationModel(
      vacationsId: vacationsId ?? this.vacationsId,
      vacationsEmployeesId: vacationsEmployeesId ?? this.vacationsEmployeesId,
      vacationsType: vacationsType ?? this.vacationsType,
      vacationsFrom: vacationsFrom ?? this.vacationsFrom,
      vacationsTo: vacationsTo ?? this.vacationsTo,
      vacationsReason: vacationsReason ?? this.vacationsReason,
      vacationsCreatedAt: vacationsCreatedAt ?? this.vacationsCreatedAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      vacationsId,
      vacationsEmployeesId,
      vacationsType,
      vacationsFrom,
      vacationsTo,
      vacationsReason,
      vacationsCreatedAt,
    ];
  }
}
