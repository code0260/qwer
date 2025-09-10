import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class CompensationModel extends Equatable {
  final int? salariesCompensationId;
  final int? salariesCompensationEmployeesId;
  final String? salariesCompensationType;
  final int? salariesCompensationIsApplied;
  final double? salariesCompensationAmount; // Changed from String? to double?
  final String? salariesCompensationReason;
  final String? salariesCompensationCreatedAt;
  final String? salariesCompensationUpdatedAt;
  final int? salariesCompensationAmountCurrencyId; // New field
  final double? salariesCompensationAmountInBase; // New field

  const CompensationModel({
    this.salariesCompensationId,
    this.salariesCompensationEmployeesId,
    this.salariesCompensationType,
    this.salariesCompensationIsApplied,
    this.salariesCompensationAmount,
    this.salariesCompensationReason,
    this.salariesCompensationCreatedAt,
    this.salariesCompensationUpdatedAt,
    this.salariesCompensationAmountCurrencyId,
    this.salariesCompensationAmountInBase,
  });

  factory CompensationModel.fromJson(Map<String, dynamic> json) {
    return CompensationModel(
      salariesCompensationId: json['salaries_compensation_id'] as int?,
      salariesCompensationEmployeesId:
          json['salaries_compensation_employees_id'] as int?,
      salariesCompensationType: json['salaries_compensation_type'] as String?,
      salariesCompensationIsApplied:
          json['salaries_compensation_is_applied'] as int?,
      salariesCompensationAmount:
          receiveDouble(json['salaries_compensation_amount']),
      salariesCompensationReason:
          json['salaries_compensation_reason'] as String?,
      salariesCompensationCreatedAt:
          json['salaries_compensation_created_at'] == null
              ? null
              : DateTime.parse('${json['salaries_compensation_created_at']}Z')
                  .toLocal()
                  .toString(),
      salariesCompensationUpdatedAt:
          json['salaries_compensation_updated_at'] == null
              ? null
              : DateTime.parse('${json['salaries_compensation_updated_at']}Z')
                  .toLocal()
                  .toString(),
      salariesCompensationAmountCurrencyId:
          json['salaries_compensation_amount_currency_id'] as int?,
      salariesCompensationAmountInBase:
          receiveDouble(json['salaries_compensation_amount_in_base']),
    );
  }

  Map<String, dynamic> toJson() => {
        'salaries_compensation_id': salariesCompensationId,
        'salaries_compensation_employees_id': salariesCompensationEmployeesId,
        'salaries_compensation_type': salariesCompensationType,
        'salaries_compensation_is_applied': salariesCompensationIsApplied,
        'salaries_compensation_amount': salariesCompensationAmount,
        'salaries_compensation_reason': salariesCompensationReason,
        'salaries_compensation_created_at': salariesCompensationCreatedAt ==
                null
            ? null
            : DateTime.parse(salariesCompensationCreatedAt!).toUtc().toString(),
        'salaries_compensation_updated_at': salariesCompensationUpdatedAt ==
                null
            ? null
            : DateTime.parse(salariesCompensationUpdatedAt!).toUtc().toString(),
        'salaries_compensation_amount_currency_id':
            salariesCompensationAmountCurrencyId,
        'salaries_compensation_amount_in_base': salariesCompensationAmountInBase
      };

  CompensationModel copyWith({
    int? salariesCompensationId,
    int? salariesCompensationEmployeesId,
    String? salariesCompensationType,
    int? salariesCompensationIsApplied,
    double? salariesCompensationAmount,
    String? salariesCompensationReason,
    String? salariesCompensationCreatedAt,
    String? salariesCompensationUpdatedAt,
    int? salariesCompensationAmountCurrencyId,
    double? salariesCompensationAmountInBase,
  }) {
    return CompensationModel(
      salariesCompensationId:
          salariesCompensationId ?? this.salariesCompensationId,
      salariesCompensationEmployeesId: salariesCompensationEmployeesId ??
          this.salariesCompensationEmployeesId,
      salariesCompensationType:
          salariesCompensationType ?? this.salariesCompensationType,
      salariesCompensationIsApplied:
          salariesCompensationIsApplied ?? this.salariesCompensationIsApplied,
      salariesCompensationAmount:
          salariesCompensationAmount ?? this.salariesCompensationAmount,
      salariesCompensationReason:
          salariesCompensationReason ?? this.salariesCompensationReason,
      salariesCompensationCreatedAt:
          salariesCompensationCreatedAt ?? this.salariesCompensationCreatedAt,
      salariesCompensationUpdatedAt:
          salariesCompensationUpdatedAt ?? this.salariesCompensationUpdatedAt,
      salariesCompensationAmountCurrencyId:
          salariesCompensationAmountCurrencyId ??
              this.salariesCompensationAmountCurrencyId,
      salariesCompensationAmountInBase: salariesCompensationAmountInBase ??
          this.salariesCompensationAmountInBase,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      salariesCompensationId,
      salariesCompensationEmployeesId,
      salariesCompensationType,
      salariesCompensationIsApplied,
      salariesCompensationAmount,
      salariesCompensationReason,
      salariesCompensationCreatedAt,
      salariesCompensationUpdatedAt,
      salariesCompensationAmountCurrencyId,
      salariesCompensationAmountInBase,
    ];
  }
}
