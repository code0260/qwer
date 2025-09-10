class CashInputModel {
  int? cashId;
  int? cashBusinessId;
  int? cashAmountCurrencyId;
  double? cashAmount;
  String? cashCreatedAt;
  String? cashUpdatedAt;
  DateTime? startDate;
  DateTime? endDate;

  CashInputModel({
    this.cashId,
    this.cashBusinessId,
    this.cashAmountCurrencyId,
    this.cashAmount,
    this.cashCreatedAt,
    this.cashUpdatedAt,
    this.startDate,
    this.endDate,
  });
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'cash_id': cashId,
      'cash_business_id': cashBusinessId,
      'cash_amount_currency_id': cashAmountCurrencyId,
      'cash_amount': cashAmount,
      'cash_created_at': cashCreatedAt,
      'cash_updated_at': cashUpdatedAt,
      "start_date": startDate?.toUtc().toString().substring(0, 19),
      "end_date": endDate?.toUtc().toString().substring(0, 19),
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
