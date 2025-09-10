import 'dart:convert';

import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';

class WithdrawalInputModel {
  int? withdrawalsId;
  int? withdrawalsPartnerId;
  int? withdrawalsInvoicesId;
  String? withdrawalsType;
  double? withdrawalsCashAmount; // Changed type to double?
  double? withdrawalsAmountInBase; // New field
  int? withdrawalsAmountCurrencyId; // New field
  dynamic withdrawalsNotes;
  String? withdrawalsCreatedAt;
  String? withdrawalsUpdatedAt;
  DateTime? startDate;
  DateTime? endDate;
  String? partnerName;

  WithdrawalInputModel({
    this.withdrawalsId,
    this.withdrawalsPartnerId,
    this.withdrawalsInvoicesId,
    this.withdrawalsType,
    this.withdrawalsCashAmount,
    this.withdrawalsAmountInBase, // New field
    this.withdrawalsAmountCurrencyId, // New field
    this.withdrawalsNotes,
    this.withdrawalsCreatedAt,
    this.withdrawalsUpdatedAt,
    this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'withdrawals_id': withdrawalsId,
      'withdrawals_partner_id': withdrawalsPartnerId,
      'withdrawals_invoices_id': withdrawalsInvoicesId,
      'withdrawals_type': withdrawalsType,
      'withdrawals_cash_amount': withdrawalsCashAmount, // Updated field
      'withdrawals_amount_in_base': withdrawalsAmountInBase, // New field
      'withdrawals_amount_currency_id':
          withdrawalsAmountCurrencyId, // New field
      'start_date': startDate?.toUtc().toString(),
      'end_date': endDate?.toUtc().toString(),
      'withdrawals_notes': withdrawalsNotes,
      'withdrawals_created_at': withdrawalsCreatedAt == null
          ? null
          : DateTime.parse(withdrawalsCreatedAt!).toUtc().toString(),
      'withdrawals_updated_at': withdrawalsUpdatedAt == null
          ? null
          : DateTime.parse(withdrawalsUpdatedAt!).toUtc().toString(),
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  factory WithdrawalInputModel.fromMap(Map<String, dynamic> map) {
    return WithdrawalInputModel(
      withdrawalsId:
          map['withdrawals_id'] != null ? map['withdrawals_id'] as int : null,
      withdrawalsPartnerId: map['withdrawals_partner_id'] != null
          ? map['withdrawals_partner_id'] as int
          : null,
      withdrawalsInvoicesId: map['withdrawals_invoices_id'] != null
          ? map['withdrawals_invoices_id'] as int
          : null,
      withdrawalsType: map['withdrawals_type'] != null
          ? map['withdrawals_type'] as String
          : null,
      withdrawalsCashAmount: receiveDouble(
          map['withdrawals_cash_amount']), // Updated parsing logic
      withdrawalsAmountInBase:
          receiveDouble(map['withdrawals_amount_in_base']), // New field
      withdrawalsAmountCurrencyId: map['withdrawals_amount_currency_id'] != null
          ? map['withdrawals_amount_currency_id'] as int
          : null, // New field
      startDate: map['start_date'] != null
          ? DateTime.parse(map['start_date']).toLocal()
          : null,
      endDate: map['end_date'] != null
          ? DateTime.parse(map['end_date']).toLocal()
          : null,
      withdrawalsNotes: map['withdrawals_notes'],
      withdrawalsCreatedAt: map['withdrawals_created_at'] != null
          ? DateTime.parse('${map['withdrawals_created_at']}Z')
              .toLocal()
              .toString()
          : null,
      withdrawalsUpdatedAt: map['withdrawals_updated_at'] != null
          ? DateTime.parse('${map['withdrawals_updated_at']}Z')
              .toLocal()
              .toString()
          : null,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory WithdrawalInputModel.fromJson(String source) =>
      WithdrawalInputModel.fromMap(jsonDecode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'WithdrawalInputModel(withdrawalsId: $withdrawalsId, withdrawalsPartnerId: $withdrawalsPartnerId, withdrawalsInvoicesId: $withdrawalsInvoicesId, withdrawalsType: $withdrawalsType, withdrawalsCashAmount: $withdrawalsCashAmount, withdrawals_amount_in_base: $withdrawalsAmountInBase, withdrawals_amount_currency_id: $withdrawalsAmountCurrencyId, withdrawalsNotes: $withdrawalsNotes, withdrawalsCreatedAt: $withdrawalsCreatedAt, withdrawalsUpdatedAt: $withdrawalsUpdatedAt, startDate: $startDate, endDate: $endDate)';

  @override
  bool operator ==(covariant WithdrawalInputModel other) {
    if (identical(this, other)) return true;
    return other.withdrawalsId == withdrawalsId &&
        other.withdrawalsPartnerId == withdrawalsPartnerId &&
        other.withdrawalsInvoicesId == withdrawalsInvoicesId &&
        other.withdrawalsType == withdrawalsType &&
        other.withdrawalsCashAmount == withdrawalsCashAmount &&
        other.withdrawalsAmountInBase == withdrawalsAmountInBase && // New field
        other.withdrawalsAmountCurrencyId ==
            withdrawalsAmountCurrencyId && // New field
        other.withdrawalsNotes == withdrawalsNotes &&
        other.withdrawalsCreatedAt == withdrawalsCreatedAt &&
        other.withdrawalsUpdatedAt == withdrawalsUpdatedAt &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode =>
      withdrawalsId.hashCode ^
      withdrawalsPartnerId.hashCode ^
      withdrawalsInvoicesId.hashCode ^
      withdrawalsType.hashCode ^
      withdrawalsCashAmount.hashCode ^
      withdrawalsAmountInBase.hashCode ^ // New field
      withdrawalsAmountCurrencyId.hashCode ^ // New field
      withdrawalsNotes.hashCode ^
      withdrawalsCreatedAt.hashCode ^
      withdrawalsUpdatedAt.hashCode ^
      startDate.hashCode ^
      endDate.hashCode;
}
