class CurrencyInputModel {
  int? currenciesId;
  String? currenciesCode;
  String? currenciesCodeAr;
  String? currenciesSymbol;
  String? currenciesNameEn;
  String? currenciesNameAr;
  double? currenciesExchangeRateToDollar;
  String? currenciesCreatedAt;
  String? currenciesUpdatedAt;
  int? businessCurrencyId;
  int? businessCurrencyBusinessId;
  int? businessCurrencyIsBase;
  int? businessCurrencyCurrenciesId;
  int? businessCurrencyNearFactor;
  double? businessCurrencyManualExchange;
  int? businessCurrencyOnline;
  CurrencyInputModel(
      {this.currenciesId,
      this.currenciesCode,
      this.currenciesCodeAr,
      this.currenciesSymbol,
      this.currenciesNameEn,
      this.currenciesNameAr,
      this.currenciesExchangeRateToDollar,
      this.currenciesCreatedAt,
      this.currenciesUpdatedAt,
      this.businessCurrencyId,
      this.businessCurrencyBusinessId,
      this.businessCurrencyIsBase,
      this.businessCurrencyManualExchange,
      this.businessCurrencyNearFactor,
      this.businessCurrencyOnline,
      this.businessCurrencyCurrenciesId});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'currencies_id': currenciesId,
      'currencies_code': currenciesCode,
      'currencies_code_ar': currenciesCodeAr,
      'currencies_symbol': currenciesSymbol,
      'currencies_name_en': currenciesNameEn,
      'currencies_name_ar': currenciesNameAr,
      'currencies_exchange_rate_to_dollar': currenciesExchangeRateToDollar,
      'currencies_created_at': currenciesCreatedAt,
      'currencies_updated_at': currenciesUpdatedAt,
      'business_currency_id': businessCurrencyId,
      'business_currency_business_id': businessCurrencyBusinessId,
      'business_currency_is_base': businessCurrencyIsBase,
      'business_currency_currencies_id': businessCurrencyCurrenciesId,
      'business_currency_manual_exchange': businessCurrencyManualExchange,
      'business_currency_near_factor': businessCurrencyNearFactor,
      'business_currency_online': businessCurrencyOnline,
    };
    map.removeWhere((key, value) =>
        value == null && key != 'business_currency_manual_exchange');
    return map;
  }
}
