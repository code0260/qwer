import 'package:equatable/equatable.dart';

class OffersBogoDetailsModel extends Equatable {
  final int? offersConditionsBogoId;
  final int? offersConditionsBogoProductCount;
  final int? offersConditionsBogoOffersId;
  final int? offersConditionsBogoAffectedProductCount;
  final int? offersConditionsBogoProductCountUnitId;
  final int? offersConditionsBogoAffectedProductCountUnitId;

  const OffersBogoDetailsModel({
    this.offersConditionsBogoId,
    this.offersConditionsBogoProductCount,
    this.offersConditionsBogoOffersId,
    this.offersConditionsBogoAffectedProductCount,
    this.offersConditionsBogoProductCountUnitId,
    this.offersConditionsBogoAffectedProductCountUnitId,
  });

  factory OffersBogoDetailsModel.fromJson(Map<String, dynamic> json) {
    return OffersBogoDetailsModel(
      offersConditionsBogoId: json['offers_conditions_bogo_id'] as int?,
      offersConditionsBogoProductCount:
          json['offers_conditions_bogo_product_count'] as int?,
      offersConditionsBogoOffersId:
          json['offers_conditions_bogo_offers_id'] as int?,
      offersConditionsBogoAffectedProductCount:
          json['offers_conditions_bogo_affected_product_count'] as int?,
      offersConditionsBogoProductCountUnitId:
          json['offers_conditions_bogo_product_count_unit_id'] as int?,
      offersConditionsBogoAffectedProductCountUnitId:
          json['offers_conditions_bogo_affected_product_count_unit_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'offers_conditions_bogo_id': offersConditionsBogoId,
        'offers_conditions_bogo_product_count':
            offersConditionsBogoProductCount,
        'offers_conditions_bogo_offers_id': offersConditionsBogoOffersId,
        'offers_conditions_bogo_affected_product_count':
            offersConditionsBogoAffectedProductCount,
        'offers_conditions_bogo_product_count_unit_id':
            offersConditionsBogoProductCountUnitId,
        'offers_conditions_bogo_affected_product_count_unit_id':
            offersConditionsBogoAffectedProductCountUnitId,
      };

  @override
  List<Object?> get props {
    return [
      offersConditionsBogoId,
      offersConditionsBogoProductCount,
      offersConditionsBogoOffersId,
      offersConditionsBogoAffectedProductCount,
      offersConditionsBogoProductCountUnitId,
      offersConditionsBogoAffectedProductCountUnitId,
    ];
  }
}
