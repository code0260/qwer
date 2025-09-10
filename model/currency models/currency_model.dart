import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class CurrencyModel extends Equatable {
  final int? currenciesId;
  final String? currenciesCode;
  final String? currenciesCodeAr;
  final String? currenciesSymbol;
  final String? currenciesNameEn;
  final String? currenciesNameAr;
  final double? currenciesExchangeRateToDollar;
  final String? currenciesCreatedAt;
  final String? currenciesUpdatedAt;
  final int? businessCurrencyId;
  final int? businessCurrencyBusinessId;
  final int? businessCurrencyCurrenciesId;
  final int? businessCurrencyIsBase;
  final String? businessCurrencyCreatedAt;
  final double? businessCurrencyManualExchange;
  final int? businessCurrencyNearFactor;

  const CurrencyModel({
    this.currenciesId,
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
    this.businessCurrencyCurrenciesId,
    this.businessCurrencyIsBase,
    this.businessCurrencyCreatedAt,
    this.businessCurrencyManualExchange,
    this.businessCurrencyNearFactor,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        currenciesId: json['currencies_id'] as int?,
        currenciesCode: json['currencies_code'] as String?,
        currenciesCodeAr: json['currencies_code_ar'] as String?,
        currenciesSymbol: json['currencies_symbol'] as String?,
        currenciesNameEn: json['currencies_name_en'] as String?,
        currenciesNameAr: json['currencies_name_ar'] as String?,
        currenciesExchangeRateToDollar:
            receiveDouble(json['currencies_exchange_rate_to_dollar']),
        currenciesCreatedAt: json['currencies_created_at'] as String?,
        currenciesUpdatedAt: json['currencies_updated_at'] as String?,
        businessCurrencyId: json['business_currency_id'] as int?,
        businessCurrencyBusinessId:
            json['business_currency_business_id'] as int?,
        businessCurrencyCurrenciesId:
            json['business_currency_currencies_id'] as int?,
        businessCurrencyIsBase: json['business_currency_is_base'] as int?,
        businessCurrencyCreatedAt:
            json['business_currency_created_at'] as String?,
        businessCurrencyManualExchange:
            receiveDouble(json['business_currency_manual_exchange']),
        businessCurrencyNearFactor:
            json['business_currency_near_factor'] as int?,
      );

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
      'business_currency_currencies_id': businessCurrencyCurrenciesId,
      'business_currency_is_base': businessCurrencyIsBase,
      'business_currency_created_at': businessCurrencyCreatedAt,
      'business_currency_manual_exchange': businessCurrencyManualExchange,
      'business_currency_near_factor': businessCurrencyNearFactor,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  Map<String, dynamic> toCurrency() => {
        'currencies_id': currenciesId,
        'currencies_code': currenciesCode,
        'currencies_code_ar': currenciesCodeAr,
        'currencies_symbol': currenciesSymbol,
        'currencies_name_en': currenciesNameEn,
        'currencies_name_ar': currenciesNameAr,
        'currencies_exchange_rate_to_dollar': currenciesExchangeRateToDollar,
        'currencies_created_at': currenciesCreatedAt,
      };

  Map<String, dynamic> toBusinessCurrency() => {
        'business_currency_id': businessCurrencyId,
        'business_currency_business_id': businessCurrencyBusinessId,
        'business_currency_currencies_id': businessCurrencyCurrenciesId,
        'business_currency_is_base': businessCurrencyIsBase,
        'business_currency_created_at': businessCurrencyCreatedAt,
        'business_currency_manual_exchange': businessCurrencyManualExchange,
        'business_currency_near_factor': businessCurrencyNearFactor,
      };

  CurrencyModel copyWith({
    int? currenciesId,
    String? currenciesCode,
    String? currenciesCodeAr,
    String? currenciesSymbol,
    String? currenciesNameEn,
    String? currenciesNameAr,
    double? currenciesExchangeRateToDollar,
    String? currenciesCreatedAt,
    String? currenciesUpdatedAt,
    int? businessCurrencyId,
    int? businessCurrencyBusinessId,
    int? businessCurrencyCurrenciesId,
    int? businessCurrencyIsBase,
    String? businessCurrencyCreatedAt,
    double? businessCurrencyManualExchange,
    int? businessCurrencyNearFactor,
  }) {
    return CurrencyModel(
      currenciesId: currenciesId ?? this.currenciesId,
      currenciesCode: currenciesCode ?? this.currenciesCode,
      currenciesCodeAr: currenciesCodeAr ?? this.currenciesCodeAr,
      currenciesSymbol: currenciesSymbol ?? this.currenciesSymbol,
      currenciesNameEn: currenciesNameEn ?? this.currenciesNameEn,
      currenciesNameAr: currenciesNameAr ?? this.currenciesNameAr,
      currenciesExchangeRateToDollar:
          currenciesExchangeRateToDollar ?? this.currenciesExchangeRateToDollar,
      currenciesCreatedAt: currenciesCreatedAt ?? this.currenciesCreatedAt,
      currenciesUpdatedAt: currenciesUpdatedAt ?? this.currenciesUpdatedAt,
      businessCurrencyId: businessCurrencyId ?? this.businessCurrencyId,
      businessCurrencyBusinessId:
          businessCurrencyBusinessId ?? this.businessCurrencyBusinessId,
      businessCurrencyCurrenciesId:
          businessCurrencyCurrenciesId ?? this.businessCurrencyCurrenciesId,
      businessCurrencyIsBase:
          businessCurrencyIsBase ?? this.businessCurrencyIsBase,
      businessCurrencyCreatedAt:
          businessCurrencyCreatedAt ?? this.businessCurrencyCreatedAt,
      businessCurrencyManualExchange:
          businessCurrencyManualExchange ?? this.businessCurrencyManualExchange,
      businessCurrencyNearFactor:
          businessCurrencyNearFactor ?? this.businessCurrencyNearFactor,
    );
  }

  @override
  List<Object?> get props {
    return [
      currenciesId,
      currenciesCode,
      currenciesCodeAr,
      currenciesSymbol,
      currenciesNameEn,
      currenciesNameAr,
      currenciesExchangeRateToDollar,
      currenciesCreatedAt,
      currenciesUpdatedAt,
      businessCurrencyId,
      businessCurrencyBusinessId,
      businessCurrencyCurrenciesId,
      businessCurrencyIsBase,
      businessCurrencyCreatedAt,
      businessCurrencyManualExchange,
      businessCurrencyNearFactor,
    ];
  }
}
