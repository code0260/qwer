import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class ProductStatementDealModel extends Equatable {
  final String? dealDate;
  final String? dealType;
  final String? dealNumber;
  final String? dealDesc;
  final String? unitName;
  final double? quantityIn;
  final double? quantityOut;
  final int? id;
  final int? unitsId;

  const ProductStatementDealModel(
      {this.dealDate,
      this.dealType,
      this.dealNumber,
      this.dealDesc,
      this.unitName,
      this.quantityIn,
      this.quantityOut,
      this.id,
      this.unitsId});

  factory ProductStatementDealModel.fromJson(Map<String, dynamic> json) {
    return ProductStatementDealModel(
      dealDate: json['deal_date'] as String?,
      dealType: json['deal_type'] as String?,
      dealNumber: json['deal_number'] as String?,
      dealDesc: json['deal_desc'] as String?,
      unitName: json['unit_name'] as String?,
      quantityIn: receiveDouble(json['quantity_in']),
      quantityOut: receiveDouble(json['quantity_out']),
      id: json['id'] as int?,
      unitsId: json['unit_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'deal_date': dealDate,
        'deal_type': dealType,
        'deal_number': dealNumber,
        'deal_desc': dealDesc,
        'unit_name': unitName,
        'quantity_in': quantityIn,
        'quantity_out': quantityOut,
        'id': id,
        'unit_id': unitsId
      };

  ProductStatementDealModel copyWith({
    String? dealDate,
    String? dealType,
    String? dealNumber,
    String? dealDesc,
    String? unitName,
    double? quantityIn,
    double? quantityOut,
    int? id,
  }) {
    return ProductStatementDealModel(
      dealDate: dealDate ?? this.dealDate,
      dealType: dealType ?? this.dealType,
      dealNumber: dealNumber ?? this.dealNumber,
      dealDesc: dealDesc ?? this.dealDesc,
      unitName: unitName ?? this.unitName,
      quantityIn: quantityIn ?? this.quantityIn,
      quantityOut: quantityOut ?? this.quantityOut,
      id: id ?? this.id,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      dealDate,
      dealType,
      dealNumber,
      dealDesc,
      unitName,
      quantityIn,
      quantityOut,
      id
    ];
  }
}
