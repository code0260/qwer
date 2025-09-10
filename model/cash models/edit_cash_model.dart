import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EditCashModel {
  String? reason;
  int? cashId;
  double? amount;
  double? amountInBase;
  double? originalAmount;
  double? originalAmountInBase;
  int? currencyId;
  EditCashModel(
      {this.reason,
      this.amount,
      this.amountInBase,
      this.cashId,
      this.currencyId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reason': reason,
      'amount': amount,
      'amount_in_base': amountInBase,
      'currency_id': currencyId,
      'cash_id': cashId
    };
  }

  factory EditCashModel.fromMap(Map<String, dynamic> map) {
    return EditCashModel(
      reason: map['reason'] != null ? map['reason'] as String : null,
      amount: map['amount'] != null ? map['amount'] as double : null,
      amountInBase: map['amount_in_base'] != null
          ? map['amount_in_base'] as double
          : null,
      currencyId: map['currency_id'] != null ? map['currency_id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EditCashModel.fromJson(String source) =>
      EditCashModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
