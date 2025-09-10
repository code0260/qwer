// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PriceInputModel extends Equatable {
  int? pricesProductsId;
  int? pricesAmountCurrencyId;
  DateTime? startDate;
  DateTime? endDate;
  int? pricesId;
  double? pricesUnitPrice;
  String? pricesType;
  String? pricesPartnerAr;
  String? pricesPartnerEn;
  String? pricesCreatedAt;
  int? pricesOnline;
  int? pricesBusinessId;
  PriceInputModel({
    this.pricesProductsId,
    this.startDate,
    this.pricesOnline,
    this.pricesBusinessId,
    this.pricesAmountCurrencyId,
    this.endDate,
    this.pricesId,
    this.pricesUnitPrice,
    this.pricesType,
    this.pricesPartnerAr,
    this.pricesPartnerEn,
    this.pricesCreatedAt,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'prices_id': pricesId,
      'prices_products_id': pricesProductsId,
      'prices_unit_price': pricesUnitPrice,
      'prices_amount_currency_id': pricesAmountCurrencyId,
      'prices_type': pricesType,
      'prices_partner_ar': pricesPartnerAr,
      'prices_partner_en': pricesPartnerEn,
      'prices_business_id': pricesBusinessId,
      'prices_online': pricesOnline,
      'prices_createdAt': pricesCreatedAt == null
          ? null
          : DateTime.parse(pricesCreatedAt!).toUtc().toString(),
      'start_date': startDate?.toUtc().toString(),
      'end_date': endDate?.toUtc().toString(),
    };

    map.removeWhere((key, value) => value == null);
    return map;
  }

  factory PriceInputModel.fromJson(Map<String, dynamic> json) =>
      PriceInputModel(
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

  @override
  List<Object?> get props => [pricesProductsId, startDate, endDate];
}
