import 'package:equatable/equatable.dart';

class OffersVolumeDetailsModel extends Equatable {
  final int? offersConditionsVolumeId;
  final int? offersConditionsVolumeOffersId;
  final String? offersConditionsVolumeMinimumValue;
  final String? offersConditionsVolumeMinimumValueType;
  final int? offersConditionsVolumeMinimumCountUnitId;

  const OffersVolumeDetailsModel({
    this.offersConditionsVolumeId,
    this.offersConditionsVolumeOffersId,
    this.offersConditionsVolumeMinimumValue,
    this.offersConditionsVolumeMinimumValueType,
    this.offersConditionsVolumeMinimumCountUnitId,
  });

  factory OffersVolumeDetailsModel.fromJson(Map<String, dynamic> json) {
    return OffersVolumeDetailsModel(
      offersConditionsVolumeId: json['offers_conditions_volume_id'] as int?,
      offersConditionsVolumeOffersId:
          json['offers_conditions_volume_offers_id'] as int?,
      offersConditionsVolumeMinimumValue:
          json['offers_conditions_volume_minimum_value'] as String?,
      offersConditionsVolumeMinimumValueType:
          json['offers_conditions_volume_minimum_value_type'] as String?,
      offersConditionsVolumeMinimumCountUnitId:
          json['offers_conditions_volume_minimum_count_unit_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'offers_conditions_volume_id': offersConditionsVolumeId,
        'offers_conditions_volume_offers_id': offersConditionsVolumeOffersId,
        'offers_conditions_volume_minimum_value':
            offersConditionsVolumeMinimumValue,
        'offers_conditions_volume_minimum_value_type':
            offersConditionsVolumeMinimumValueType,
        'offers_conditions_volume_minimum_count_unit_id':
            offersConditionsVolumeMinimumCountUnitId,
      };

  @override
  List<Object?> get props {
    return [
      offersConditionsVolumeId,
      offersConditionsVolumeOffersId,
      offersConditionsVolumeMinimumValue,
      offersConditionsVolumeMinimumValueType,
      offersConditionsVolumeMinimumCountUnitId,
    ];
  }
}
