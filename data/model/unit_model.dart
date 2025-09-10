import 'package:almonazim/core/helper/functions/datetime%20functions/to_local_datetime.dart';
import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class UnitModel extends Equatable {
  final int? unitsId;
  final int? unitsBusinessId;
  final String? unitsName;
  final double? unitsConversionFactor;
  final String? unitsGroup;
  final String? unitsGroupEn;
  final String? unitsSymbol;
  final int? unitsIsBaseUnit;
  final String? unitsCreatedAt;
  final int? unitsOnline; // ✅ Added here

  const UnitModel({
    this.unitsId,
    this.unitsBusinessId,
    this.unitsGroupEn,
    this.unitsName,
    this.unitsConversionFactor,
    this.unitsGroup,
    this.unitsSymbol,
    this.unitsIsBaseUnit,
    this.unitsCreatedAt,
    this.unitsOnline = 1, // ✅ Added here
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
        unitsId: json['units_id'] as int?,
        unitsBusinessId: json['units_business_id'] as int?,
        unitsName: json['units_name'] as String?,
        unitsConversionFactor: receiveDouble(json['units_conversion_factor']),
        unitsGroup: json['units_group'] as String?,
        unitsGroupEn: json['units_group_en'] as String?,
        unitsSymbol: json['units_symbol'] as String?,
        unitsIsBaseUnit: json['units_is_base_unit'] as int?,
        unitsCreatedAt: toLocalTime(json['units_created_at']),
        unitsOnline: json['units_online'] as int? ?? 1, // ✅ Added here
      );

  Map<String, dynamic> toJson() => {
        'units_id': unitsId,
        'units_business_id': unitsBusinessId,
        'units_name': unitsName,
        'units_conversion_factor': unitsConversionFactor,
        'units_group': unitsGroup,
        'units_group_en': unitsGroupEn,
        'units_symbol': unitsSymbol,
        'units_is_base_unit': unitsIsBaseUnit,
        'units_created_at': unitsCreatedAt == null
            ? null
            : DateTime.parse(unitsCreatedAt!).toUtc().toString(),
        'units_online': unitsOnline, // ✅ Added here
      };

  Map<String, dynamic> toServer() {
    Map<String, dynamic> map = {
      'units_id': unitsId,
      'units_business_id': unitsBusinessId,
      'units_name': unitsName,
      'units_is_base_unit': unitsIsBaseUnit,
      'units_conversion_factor': unitsConversionFactor,
      'units_group': unitsGroup,
      'units_group_en': unitsGroupEn,
      'units_symbol': unitsSymbol,
      'units_online': unitsOnline, // ✅ Added here
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  UnitModel copyWith({
    int? unitsId,
    dynamic unitsBusinessId,
    String? unitsName,
    double? unitsConversionFactor,
    String? unitsGroup,
    String? unitsGroupEn,
    String? unitsSymbol,
    int? unitsIsBaseUnit,
    String? unitsCreatedAt,
    int? unitsOnline, // ✅ Added here
  }) {
    return UnitModel(
      unitsId: unitsId ?? this.unitsId,
      unitsBusinessId: unitsBusinessId ?? this.unitsBusinessId,
      unitsName: unitsName ?? this.unitsName,
      unitsConversionFactor:
          unitsConversionFactor ?? this.unitsConversionFactor,
      unitsGroup: unitsGroup ?? this.unitsGroup,
      unitsGroupEn: unitsGroupEn ?? this.unitsGroupEn,
      unitsSymbol: unitsSymbol ?? this.unitsSymbol,
      unitsIsBaseUnit: unitsIsBaseUnit ?? this.unitsIsBaseUnit,
      unitsCreatedAt: unitsCreatedAt ?? this.unitsCreatedAt,
      unitsOnline: unitsOnline ?? this.unitsOnline, // ✅ Added here
    );
  }

  @override
  List<Object?> get props {
    return [
      unitsId,
      unitsBusinessId,
      unitsName,
      unitsGroupEn,
      unitsConversionFactor,
      unitsGroup,
      unitsSymbol,
      unitsIsBaseUnit,
      unitsCreatedAt,
      unitsOnline, // ✅ Added here
    ];
  }
}
