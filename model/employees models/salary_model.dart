import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class SalaryModel extends Equatable {
  final int? salariesId;
  final int? salariesEmployeesId;
  final double? salariesAmount; // Changed type to double?
  final int? salariesAmountCurrencyId; // New field
  final double? salariesAmountInBase; // New field
  final String? salariesFrequency;
  final String? salariesCreatedAt;
  final String? salariesPayTime;

  const SalaryModel({
    this.salariesId,
    this.salariesEmployeesId,
    this.salariesAmount,
    this.salariesAmountCurrencyId, // New field
    this.salariesAmountInBase, // New field
    this.salariesFrequency,
    this.salariesCreatedAt,
    this.salariesPayTime,
  });

  factory SalaryModel.fromJson(Map<String, dynamic> json) => SalaryModel(
        salariesId: json['salaries_id'] as int?,
        salariesEmployeesId: json['salaries_employees_id'] as int?,
        salariesAmount:
            receiveDouble(json['salaries_amount']), // Updated parsing logic
        salariesAmountCurrencyId:
            json['salaries_amount_currency_id'] as int?, // New field
        salariesAmountInBase:
            receiveDouble(json['salaries_amount_in_base']), // New field
        salariesFrequency: json['salaries_frequency'] as String?,
        salariesCreatedAt: parseUtcToLocal(json['salaries_created_at']),
        salariesPayTime: json['salaries_pay_time'],
      );

  Map<String, dynamic> toJson() => {
        'salaries_id': salariesId,
        'salaries_employees_id': salariesEmployeesId,
        'salaries_amount': salariesAmount, // Updated field
        'salaries_amount_currency_id': salariesAmountCurrencyId, // New field
        'salaries_amount_in_base': salariesAmountInBase, // New field
        'salaries_frequency': salariesFrequency,
        'salaries_created_at': parseLocalToUtc(salariesCreatedAt),
        'salaries_pay_time': salariesPayTime,
      };

  SalaryModel copyWith({
    int? salariesId,
    int? salariesEmployeesId,
    double? salariesAmount, // Updated type
    int? salariesAmountCurrencyId, // New field
    double? salariesAmountInBase, // New field
    String? salariesFrequency,
    String? salariesCreatedAt,
    String? salariesPayTime,
  }) {
    return SalaryModel(
      salariesId: salariesId ?? this.salariesId,
      salariesEmployeesId: salariesEmployeesId ?? this.salariesEmployeesId,
      salariesAmount: salariesAmount ?? this.salariesAmount, // Updated field
      salariesAmountCurrencyId: salariesAmountCurrencyId ??
          this.salariesAmountCurrencyId, // New field
      salariesAmountInBase:
          salariesAmountInBase ?? this.salariesAmountInBase, // New field
      salariesFrequency: salariesFrequency ?? this.salariesFrequency,
      salariesCreatedAt: salariesCreatedAt ?? this.salariesCreatedAt,
      salariesPayTime: salariesPayTime ?? this.salariesPayTime,
    );
  }

  static String? parseUtcToLocal(String? date) {
    return date != null ? DateTime.parse(date).toLocal().toString() : null;
  }

  static String? parseLocalToUtc(String? date) {
    return date != null ? DateTime.parse(date).toUtc().toString() : null;
  }

  @override
  List<Object?> get props {
    return [
      salariesId,
      salariesEmployeesId,
      salariesAmount, // Updated field
      salariesAmountCurrencyId, // New field
      salariesAmountInBase, // New field
      salariesFrequency,
      salariesCreatedAt,
      salariesPayTime,
    ];
  }
}
