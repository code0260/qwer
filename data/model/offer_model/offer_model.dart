import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

import 'offers_bogo_details_model.dart';
import 'offers_domain_details_model.dart';
import 'offers_volume_details_model.dart';

class OfferModel extends Equatable {
  final int? offersId;
  final int? offersBusinessId;
  final String? offersDomainType;
  final String? offersConditionsType;
  final String? offersKey;
  final double? offersDiscountValue;
  final String? offersDiscountType;
  final String? offersDescription;
  final String? offersStartDate;
  final String? offersExpirationDate;
  final String? offersCreatedAt;
  final String? offersUpdatedAt;
  final OffersDomainDetailsModel? offersDomainDetailsModel;
  final OffersBogoDetailsModel? offersBogoDetailsModel;
  final OffersVolumeDetailsModel? offersVolumeDetailsModel;

  const OfferModel({
    this.offersId,
    this.offersBusinessId,
    this.offersDomainType,
    this.offersConditionsType,
    this.offersKey,
    this.offersDiscountValue,
    this.offersDiscountType,
    this.offersDescription,
    this.offersStartDate,
    this.offersExpirationDate,
    this.offersCreatedAt,
    this.offersUpdatedAt,
    this.offersDomainDetailsModel,
    this.offersBogoDetailsModel,
    this.offersVolumeDetailsModel,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        offersId: json['offers_id'] as int?,
        offersBusinessId: json['offers_business_id'] as int?,
        offersDomainType: json['offers_domain_type'] as String?,
        offersConditionsType: json['offers_conditions_type'] as String?,
        offersKey: json['offers_key'] as String?,
        offersDiscountValue: receiveDouble(json['offers_discount_value']),
        offersDiscountType: json['offers_discount_type'] as String?,
        offersDescription: json['offers_description'] as String?,
        offersStartDate: json['offers_start_date'],
        offersExpirationDate: json['offers_expiration_date'],
        offersCreatedAt: json['offers_createdAt'] == null
            ? null
            : DateTime.parse('${json['offers_createdAt']}Z')
                .toLocal()
                .toString(),
        offersUpdatedAt: json['offers_updatedAt'] == null
            ? null
            : DateTime.parse('${json['offers_updatedAt']}Z')
                .toLocal()
                .toString(),
        offersDomainDetailsModel: json['offers_domain_details'] == null
            ? null
            : OffersDomainDetailsModel.fromJson(
                json['offers_domain_details'] as Map<String, dynamic>),
        offersBogoDetailsModel: json['offers_bogo_details'] == null
            ? null
            : OffersBogoDetailsModel.fromJson(
                json['offers_bogo_details'] as Map<String, dynamic>),
        offersVolumeDetailsModel: json['offers_volume_details'] == null
            ? null
            : OffersVolumeDetailsModel.fromJson(
                json['offers_volume_details'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'offers_id': offersId,
        'offers_business_id': offersBusinessId,
        'offers_domain_type': offersDomainType,
        'offers_conditions_type': offersConditionsType,
        'offers_key': offersKey,
        'offers_discount_value': offersDiscountValue,
        'offers_discount_type': offersDiscountType,
        'offers_description': offersDescription,
        'offers_start_date': offersStartDate?.toString(),
        'offers_expiration_date': offersExpirationDate?.toString(),
        'offers_createdAt': offersCreatedAt == null
            ? null
            : DateTime.parse(offersCreatedAt!).toUtc().toString(),
        'offers_updatedAt': offersUpdatedAt == null
            ? null
            : DateTime.parse(offersUpdatedAt!).toUtc().toString(),
        'offers_domain_details': offersDomainDetailsModel?.toJson(),
        'offers_bogo_details': offersBogoDetailsModel?.toJson(),
        'offers_volume_details': offersVolumeDetailsModel?.toJson(),
      };

  @override
  List<Object?> get props {
    return [
      offersId,
      offersBusinessId,
      offersDomainType,
      offersConditionsType,
      offersKey,
      offersDiscountValue,
      offersDiscountType,
      offersDescription,
      offersStartDate,
      offersExpirationDate,
      offersCreatedAt,
      offersUpdatedAt,
      offersDomainDetailsModel,
      offersBogoDetailsModel,
      offersVolumeDetailsModel,
    ];
  }
}
