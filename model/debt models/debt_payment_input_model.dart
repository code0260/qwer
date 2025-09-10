// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';

class DebtPaymentInputModel {
  int? debtPaymentsId;
  int? debtPaymentsDebtsId;
  double? debtPaymentsAmount;
  int? debtPaymentsAmountCurrencyId;
  double? debtPaymentsAmountInBase;
  String? debtPaymentsDate;
  String? debtPaymentsCreatedAt;
  String? clientsType;
  String? clientsName;
  int? clientsId;
  String? personName;
  String? debtType;
  String? debtPaymentsNotes; // Added

  DebtPaymentInputModel(
      {this.debtPaymentsId,
      this.debtPaymentsDebtsId,
      this.debtPaymentsAmount,
      this.debtType,
      this.debtPaymentsDate,
      this.debtPaymentsCreatedAt,
      this.clientsType,
      this.clientsName,
      this.clientsId,
      this.personName,
      this.debtPaymentsAmountCurrencyId,
      this.debtPaymentsAmountInBase,
      this.debtPaymentsNotes}); // Added

  factory DebtPaymentInputModel.fromMap(Map<String, dynamic> map) {
    return DebtPaymentInputModel(
      debtPaymentsId: map['debt_payments_id'] as int?,
      debtPaymentsDebtsId: map['debt_payments_debts_id'] as int?,
      debtPaymentsAmount: receiveDouble(map['debt_payments_amount']),
      debtPaymentsDate: map['debt_payments_date'],
      debtPaymentsCreatedAt: map['debt_payments_created_at'] == null
          ? null
          : DateTime.parse('${map['debt_payments_created_at']}Z')
              .toLocal()
              .toString(),
      clientsType: map['clients_type'] as String?,
      clientsName: map['clients_name'] as String?,
      clientsId: map['clients_id'] as int?,
      personName: map['person_name'] as String?,
      debtPaymentsAmountCurrencyId:
          map['debt_payments_amount_currency_id'] as int?,
      debtPaymentsAmountInBase:
          receiveDouble(map['debt_payments_amount_in_base']),
      debtPaymentsNotes: map['debt_payments_notes'] as String?, // Added
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'debt_payments_id': debtPaymentsId,
      'debt_payments_debts_id': debtPaymentsDebtsId,
      'debt_payments_amount': debtPaymentsAmount,
      'debt_payments_amount_currency_id': debtPaymentsAmountCurrencyId,
      'debt_payments_amount_in_base': debtPaymentsAmountInBase,
      'debt_payments_date': debtPaymentsDate?.toString(),
      'debt_payments_created_at': debtPaymentsCreatedAt == null
          ? null
          : DateTime.parse(debtPaymentsCreatedAt!).toUtc().toString(),
      'debt_payments_notes': debtPaymentsNotes, // Added
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  DebtPaymentInputModel copyWith({
    String? personName,
    String? employeesName,
    String? clientsName,
    String? clientsType,
    int? debtPaymentsId,
    int? debtPaymentsDebtsId,
    int? clientsId,
    double? debtPaymentsAmount,
    String? debtPaymentsDate,
    String? debtPaymentsCreatedAt,
    String? debtPaymentsNumber,
    String? debtType,
    int? debtPaymentsAmountCurrencyId,
    double? debtPaymentsAmountInBase,
    String? debtPaymentsNotes, // Added
  }) {
    return DebtPaymentInputModel(
      clientsName: clientsName ?? this.clientsName,
      clientsType: clientsType ?? this.clientsType,
      personName: personName ?? this.personName,
      clientsId: clientsId ?? this.clientsId,
      debtPaymentsId: debtPaymentsId ?? this.debtPaymentsId,
      debtPaymentsDebtsId: debtPaymentsDebtsId ?? this.debtPaymentsDebtsId,
      debtPaymentsAmount: debtPaymentsAmount ?? this.debtPaymentsAmount,
      debtPaymentsDate: debtPaymentsDate ?? this.debtPaymentsDate,
      debtType: debtType ?? this.debtType,
      debtPaymentsCreatedAt:
          debtPaymentsCreatedAt ?? this.debtPaymentsCreatedAt,
      debtPaymentsAmountCurrencyId:
          debtPaymentsAmountCurrencyId ?? this.debtPaymentsAmountCurrencyId,
      debtPaymentsAmountInBase:
          debtPaymentsAmountInBase ?? this.debtPaymentsAmountInBase,
      debtPaymentsNotes: debtPaymentsNotes ?? this.debtPaymentsNotes, // Added
    );
  }
}
