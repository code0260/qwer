import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class BoughtInfoModel extends Equatable {
  final double? totalQuantityBought;
  final double? wac;
  final double? totalCogs;
  final double? totalDiscount;
  final double? netCogs;
  final double? totalQuantityRefundedBought;
  final double? totalRefundedBoughtAmount;
  final double? totalTax; // Added property
  final double? totalRefundedTax; // Added property

  const BoughtInfoModel({
    this.totalQuantityBought,
    this.wac,
    this.totalCogs,
    this.totalDiscount,
    this.netCogs,
    this.totalQuantityRefundedBought,
    this.totalRefundedBoughtAmount,
    this.totalTax, // Added property
    this.totalRefundedTax, // Added property
  });

  factory BoughtInfoModel.fromJson(Map<String, dynamic> json) {
    return BoughtInfoModel(
      totalQuantityBought: receiveDouble(json['total_quantity_bought']),
      wac: receiveDouble(json['wac']),
      totalCogs: receiveDouble(json['total_cogs']),
      totalDiscount: receiveDouble(json['total_discount']),
      netCogs: receiveDouble(json['net_cogs']),
      totalQuantityRefundedBought:
          receiveDouble(json['total_quantity_refunded_bought']),
      totalRefundedBoughtAmount:
          receiveDouble(json['total_refunded_bought_amount']),
      totalTax: receiveDouble(json['total_tax']), // Added property
      totalRefundedTax:
          receiveDouble(json['total_refunded_tax']), // Added property
    );
  }

  Map<String, dynamic> toJson() => {
        'total_quantity_bought': totalQuantityBought,
        'wac': wac,
        'total_cogs': totalCogs,
        'total_discount': totalDiscount,
        'net_cogs': netCogs,
        'total_quantity_refunded_bought': totalQuantityRefundedBought,
        'total_refunded_bought_amount': totalRefundedBoughtAmount,
        'total_tax': totalTax, // Added property
        'total_refunded_tax': totalRefundedTax, // Added property
      };

  BoughtInfoModel copyWith({
    double? totalQuantityBought,
    double? wac,
    double? totalCogs,
    double? totalDiscount,
    double? netCogs,
    double? totalQuantityRefundedBought,
    double? totalRefundedBoughtAmount,
    double? totalTax, // Added property
    double? totalRefundedTax, // Added property
  }) {
    return BoughtInfoModel(
      totalQuantityBought: totalQuantityBought ?? this.totalQuantityBought,
      wac: wac ?? this.wac,
      totalCogs: totalCogs ?? this.totalCogs,
      totalDiscount: totalDiscount ?? this.totalDiscount,
      netCogs: netCogs ?? this.netCogs,
      totalQuantityRefundedBought:
          totalQuantityRefundedBought ?? this.totalQuantityRefundedBought,
      totalRefundedBoughtAmount:
          totalRefundedBoughtAmount ?? this.totalRefundedBoughtAmount,
      totalTax: totalTax ?? this.totalTax, // Added property
      totalRefundedTax:
          totalRefundedTax ?? this.totalRefundedTax, // Added property
    );
  }

  @override
  List<Object?> get props {
    return [
      totalQuantityBought,
      wac,
      totalCogs,
      totalDiscount,
      netCogs,
      totalQuantityRefundedBought,
      totalRefundedBoughtAmount,
      totalTax, // Added property
      totalRefundedTax, // Added property
    ];
  }
}
