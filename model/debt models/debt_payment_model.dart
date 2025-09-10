import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class DebtPaymentModel extends Equatable {
  final dynamic debtsPersonName;
  final dynamic employeesName;
  final String? clientsName;
  final int? debtPaymentsId;
  final int? debtPaymentsDebtsId;
  final double? debtPaymentsAmount;
  final String? debtPaymentsDate;
  final String? debtPaymentsCreatedAt;
  final String? debtPaymentsNumber;
  final int? debtPaymentsAmountCurrencyId;
  final double? debtPaymentsAmountInBase;
  final String? debtPaymentsNotes; // Added

  const DebtPaymentModel({
    this.debtsPersonName,
    this.employeesName,
    this.clientsName,
    this.debtPaymentsId,
    this.debtPaymentsDebtsId,
    this.debtPaymentsAmount,
    this.debtPaymentsDate,
    this.debtPaymentsCreatedAt,
    this.debtPaymentsNumber,
    this.debtPaymentsAmountCurrencyId,
    this.debtPaymentsAmountInBase,
    this.debtPaymentsNotes, // Added
  });

  factory DebtPaymentModel.fromJson(Map<String, dynamic> json) {
    return DebtPaymentModel(
      debtsPersonName: json['debts_person_name'],
      employeesName: json['employees_name'],
      clientsName: json['clients_name'] as String?,
      debtPaymentsId: json['debt_payments_id'] as int?,
      debtPaymentsDebtsId: json['debt_payments_debts_id'] as int?,
      debtPaymentsAmount: receiveDouble(json['debt_payments_amount']),
      debtPaymentsDate: json['debt_payments_date'],
      debtPaymentsCreatedAt: json['debt_payments_created_at'] == null
          ? null
          : DateTime.parse('${json['debt_payments_created_at']}Z')
              .toLocal()
              .toString(),
      debtPaymentsNumber: json['debt_payments_number'] as String?,
      debtPaymentsAmountCurrencyId:
          json['debt_payments_amount_currency_id'] as int?,
      debtPaymentsAmountInBase:
          receiveDouble(json['debt_payments_amount_in_base']),
      debtPaymentsNotes: json['debt_payments_notes'] as String?, // Added
    );
  }

  Map<String, dynamic> toJson() => {
        'debts_person_name': debtsPersonName,
        'employees_name': employeesName,
        'clients_name': clientsName,
        'debt_payments_id': debtPaymentsId,
        'debt_payments_debts_id': debtPaymentsDebtsId,
        'debt_payments_amount': debtPaymentsAmount,
        'debt_payments_date': debtPaymentsDate?.toString(),
        'debt_payments_created_at': debtPaymentsCreatedAt == null
            ? null
            : DateTime.parse(debtPaymentsCreatedAt!).toUtc().toString(),
        'debt_payments_number': debtPaymentsNumber,
        'debt_payments_amount_currency_id': debtPaymentsAmountCurrencyId,
        'debt_payments_amount_in_base': debtPaymentsAmountInBase,
        'debt_payments_notes': debtPaymentsNotes, // Added
      };

  DebtPaymentModel copyWith({
    dynamic debtsPersonName,
    dynamic employeesName,
    String? clientsName,
    int? debtPaymentsId,
    int? debtPaymentsDebtsId,
    double? debtPaymentsAmount,
    String? debtPaymentsDate,
    String? debtPaymentsCreatedAt,
    String? debtPaymentsNumber,
    int? debtPaymentsAmountCurrencyId,
    double? debtPaymentsAmountInBase,
    String? debtPaymentsNotes, // Added
  }) {
    return DebtPaymentModel(
      debtsPersonName: debtsPersonName ?? this.debtsPersonName,
      employeesName: employeesName ?? this.employeesName,
      clientsName: clientsName ?? this.clientsName,
      debtPaymentsId: debtPaymentsId ?? this.debtPaymentsId,
      debtPaymentsDebtsId: debtPaymentsDebtsId ?? this.debtPaymentsDebtsId,
      debtPaymentsAmount: debtPaymentsAmount ?? this.debtPaymentsAmount,
      debtPaymentsDate: debtPaymentsDate ?? this.debtPaymentsDate,
      debtPaymentsCreatedAt:
          debtPaymentsCreatedAt ?? this.debtPaymentsCreatedAt,
      debtPaymentsNumber: debtPaymentsNumber ?? this.debtPaymentsNumber,
      debtPaymentsAmountCurrencyId:
          debtPaymentsAmountCurrencyId ?? this.debtPaymentsAmountCurrencyId,
      debtPaymentsAmountInBase:
          debtPaymentsAmountInBase ?? this.debtPaymentsAmountInBase,
      debtPaymentsNotes: debtPaymentsNotes ?? this.debtPaymentsNotes, // Added
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      debtsPersonName,
      employeesName,
      clientsName,
      debtPaymentsId,
      debtPaymentsDebtsId,
      debtPaymentsAmount,
      debtPaymentsDate,
      debtPaymentsCreatedAt,
      debtPaymentsNumber,
      debtPaymentsAmountCurrencyId,
      debtPaymentsAmountInBase,
      debtPaymentsNotes, // Added
    ];
  }
}
