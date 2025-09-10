import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EditDebtModel {
  DateTime? dueDate;
  int? debtsId;
  double? paidAmount;
  String? paymentState;
  double? paidThisTime;
  int? clientsId;
  int? debtsEmployeesId;
  String? clientsName;
  String? clientsType;
  num? debtsTotalAmount;
  double? debtsTotalAmountInBase; // New property
  double? debtsPaidAmountInBase; // New property
  int? debtsAmountCurrencyId; // New property
  String? debtsType;
  String? debtsPersonName;
  EditDebtModel(
      {this.dueDate,
      this.debtsTotalAmount,
      this.debtsType,
      this.clientsType,
      this.clientsName,
      this.clientsId,
      this.debtsId,
      this.paidAmount,
      this.paymentState,
      this.paidThisTime,
      this.debtsTotalAmountInBase,
      this.debtsPaidAmountInBase,
      this.debtsAmountCurrencyId});

  EditDebtModel copyWith({
    DateTime? dueDate,
    int? debtsId,
    double? paidAmount,
    String? paymentState,
    double? paidThisTime,
    double? debtsTotalAmountInBase,
    double? debtsPaidAmountInBase,
    int? debtsAmountCurrencyId,
  }) {
    return EditDebtModel(
      dueDate: dueDate ?? this.dueDate,
      debtsId: debtsId ?? this.debtsId,
      paidAmount: paidAmount ?? this.paidAmount,
      paymentState: paymentState ?? this.paymentState,
      paidThisTime: paidThisTime ?? this.paidThisTime,
      debtsTotalAmountInBase:
          debtsTotalAmountInBase ?? this.debtsTotalAmountInBase,
      debtsPaidAmountInBase:
          debtsPaidAmountInBase ?? this.debtsPaidAmountInBase,
      debtsAmountCurrencyId:
          debtsAmountCurrencyId ?? this.debtsAmountCurrencyId,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'debts_due_date': dueDate?.toUtc().toString(),
      'debts_id': debtsId,
      'debts_paid_amount': paidAmount,
      'debts_state': paymentState,
      'debts_total_amount_in_base': debtsTotalAmountInBase,
      'debts_paid_amount_in_base': debtsPaidAmountInBase,
      'debts_amount_currency_id': debtsAmountCurrencyId,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  factory EditDebtModel.fromMap(Map<String, dynamic> map) {
    return EditDebtModel(
      dueDate: map['dueDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dueDate'] as int)
          : null,
      debtsId: map['debtsId'] != null ? map['debtsId'] as int : null,
      paidAmount:
          map['paidAmount'] != null ? map['paidAmount'] as double : null,
      paymentState:
          map['paymentState'] != null ? map['paymentState'] as String : null,
      paidThisTime:
          map['paidThisTime'] != null ? map['paidThisTime'] as double : null,
      debtsTotalAmountInBase: map['debts_total_amount_in_base'] != null
          ? map['debts_total_amount_in_base'] as double
          : null,
      debtsPaidAmountInBase: map['debts_paid_amount_in_base'] != null
          ? map['debts_paid_amount_in_base'] as double
          : null,
      debtsAmountCurrencyId: map['debts_amount_currency_id'] != null
          ? map['debts_amount_currency_id'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EditDebtModel.fromJson(String source) =>
      EditDebtModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EditDebtModel(dueDate: $dueDate, debtsId: $debtsId, paidAmount: $paidAmount, paymentState: $paymentState, paidThisTime: $paidThisTime, debtsTotalAmountInBase: $debtsTotalAmountInBase, debtsPaidAmountInBase: $debtsPaidAmountInBase, debtsAmountCurrencyId: $debtsAmountCurrencyId)';
  }

  @override
  bool operator ==(covariant EditDebtModel other) {
    if (identical(this, other)) return true;

    return other.dueDate == dueDate &&
        other.debtsId == debtsId &&
        other.paidAmount == paidAmount &&
        other.paymentState == paymentState &&
        other.paidThisTime == paidThisTime &&
        other.debtsTotalAmountInBase == debtsTotalAmountInBase &&
        other.debtsPaidAmountInBase == debtsPaidAmountInBase &&
        other.debtsAmountCurrencyId == debtsAmountCurrencyId;
  }

  @override
  int get hashCode {
    return dueDate.hashCode ^
        debtsId.hashCode ^
        paidAmount.hashCode ^
        paymentState.hashCode ^
        paidThisTime.hashCode ^
        debtsTotalAmountInBase.hashCode ^
        debtsPaidAmountInBase.hashCode ^
        debtsAmountCurrencyId.hashCode;
  }
}
