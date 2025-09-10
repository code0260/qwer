import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class PriceModel extends Equatable {
  final int? pricesId;
  final int? pricesProductsId;
  final int? pricesAmountCurrencyId;
  final double? pricesUnitPrice;
  final String? pricesType;
  final String? pricesCreatedAt;
  final int? pricesBusinessId;
  final String? pricesPartnerEn;
  final String? pricesPartnerAr;

  const PriceModel({
    this.pricesId,
    this.pricesAmountCurrencyId,
    this.pricesProductsId,
    this.pricesUnitPrice,
    this.pricesType,
    this.pricesCreatedAt,
    this.pricesBusinessId,
    this.pricesPartnerEn,
    this.pricesPartnerAr,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) => PriceModel(
        pricesId: json['prices_id'] as int?,
        pricesProductsId: json['prices_products_id'] as int?,
        pricesAmountCurrencyId: json['prices_amount_currency_id'] as int?,
        pricesUnitPrice: receiveDouble(json['prices_unit_price']),
        pricesType: json['prices_type'] as String?,
        pricesCreatedAt: json['prices_createdAt'] == null
            ? null
            : DateTime.parse('${json['prices_createdAt']}Z')
                .toLocal()
                .toString(),
        pricesBusinessId: json['prices_business_id'] as int?,
        pricesPartnerEn: json['prices_partner_en'] as String?,
        pricesPartnerAr: json['prices_partner_ar'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'prices_id': pricesId,
        'prices_products_id': pricesProductsId,
        'prices_unit_price': pricesUnitPrice,
        'prices_amount_currency_id': pricesAmountCurrencyId,
        'prices_type': pricesType,
        'prices_createdAt': pricesCreatedAt == null
            ? null
            : DateTime.parse(pricesCreatedAt!).toUtc().toString(),
        'prices_business_id': pricesBusinessId,
        'prices_partner_en': pricesPartnerEn,
        'prices_partner_ar': pricesPartnerAr,
      };

  PriceModel copyWith({
    int? pricesId,
    int? pricesProductsId,
    double? pricesUnitPrice,
    int? pricesAmountCurrencyId,
    String? pricesType,
    String? pricesCreatedAt,
    int? pricesBusinessId,
    String? pricesPartnerEn,
    String? pricesPartnerAr,
  }) {
    return PriceModel(
      pricesId: pricesId ?? this.pricesId,
      pricesProductsId: pricesProductsId ?? this.pricesProductsId,
      pricesAmountCurrencyId:
          pricesAmountCurrencyId ?? this.pricesAmountCurrencyId,
      pricesUnitPrice: pricesUnitPrice ?? this.pricesUnitPrice,
      pricesType: pricesType ?? this.pricesType,
      pricesCreatedAt: pricesCreatedAt ?? this.pricesCreatedAt,
      pricesBusinessId: pricesBusinessId ?? this.pricesBusinessId,
      pricesPartnerEn: pricesPartnerEn ?? this.pricesPartnerEn,
      pricesPartnerAr: pricesPartnerAr ?? this.pricesPartnerAr,
    );
  }

  @override
  List<Object?> get props {
    return [
      pricesId,
      pricesProductsId,
      pricesUnitPrice,
      pricesType,
      pricesCreatedAt,
      pricesBusinessId,
      pricesPartnerEn,
      pricesPartnerAr,
    ];
  }
}
