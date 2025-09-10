import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class SellsInfoModel extends Equatable {
  final double? totalQuantitySold;
  final double? wac;
  final double? totalRevenue;
  final List<dynamic>? offers;
  final double? netRevenue;
  final double? totalQuantityRefundedSold;
  final double? totalRefundedAmount;
  final double? totalTax;
  final double? totalRefundedTax;
  final double? totalCogs; // Added property
  final double? totalRefundCogs; // Added property

  const SellsInfoModel({
    this.totalQuantitySold,
    this.wac,
    this.totalRevenue,
    this.offers,
    this.netRevenue,
    this.totalQuantityRefundedSold,
    this.totalRefundedAmount,
    this.totalTax,
    this.totalRefundedTax,
    this.totalCogs, // Added property
    this.totalRefundCogs, // Added property
  });

  factory SellsInfoModel.fromJson(Map<String, dynamic> json) => SellsInfoModel(
        totalQuantitySold: receiveDouble(json['total_quantity_sold']),
        wac: receiveDouble(json['wac']),
        totalRevenue: receiveDouble(json['total_revenue']),
        offers: json['offers'] as List<dynamic>?,
        netRevenue: receiveDouble(json['net_revenue']),
        totalQuantityRefundedSold:
            receiveDouble(json['total_quantity_refunded_sold']),
        totalRefundedAmount: receiveDouble(json['total_refunded_amount']),
        totalTax: receiveDouble(json['total_tax']),
        totalRefundedTax: receiveDouble(json['total_refunded_tax']),
        totalCogs: receiveDouble(json['total_cogs']), // Added property
        totalRefundCogs:
            receiveDouble(json['total_refund_cogs']), // Added property
      );

  Map<String, dynamic> toJson() => {
        'total_quantity_sold': totalQuantitySold,
        'wac': wac,
        'total_revenue': totalRevenue,
        'offers': offers,
        'net_revenue': netRevenue,
        'total_quantity_refunded_sold': totalQuantityRefundedSold,
        'total_refunded_amount': totalRefundedAmount,
        'total_tax': totalTax,
        'total_refunded_tax': totalRefundedTax,
        'total_cogs': totalCogs, // Added property
        'total_refund_cogs': totalRefundCogs, // Added property
      };

  SellsInfoModel copyWith({
    double? totalQuantitySold,
    double? wac,
    double? totalRevenue,
    List<dynamic>? offers,
    double? netRevenue,
    double? totalQuantityRefundedSold,
    double? totalRefundedAmount,
    double? totalTax,
    double? totalRefundedTax,
    double? totalCogs, // Added property
    double? totalRefundCogs, // Added property
  }) {
    return SellsInfoModel(
      totalQuantitySold: totalQuantitySold ?? this.totalQuantitySold,
      wac: wac ?? this.wac,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      offers: offers ?? this.offers,
      netRevenue: netRevenue ?? this.netRevenue,
      totalQuantityRefundedSold:
          totalQuantityRefundedSold ?? this.totalQuantityRefundedSold,
      totalRefundedAmount: totalRefundedAmount ?? this.totalRefundedAmount,
      totalTax: totalTax ?? this.totalTax,
      totalRefundedTax: totalRefundedTax ?? this.totalRefundedTax,
      totalCogs: totalCogs ?? this.totalCogs, // Added property
      totalRefundCogs:
          totalRefundCogs ?? this.totalRefundCogs, // Added property
    );
  }

  @override
  List<Object?> get props {
    return [
      totalQuantitySold,
      wac,
      totalRevenue,
      offers,
      netRevenue,
      totalQuantityRefundedSold,
      totalRefundedAmount,
      totalTax,
      totalRefundedTax,
      totalCogs, // Added property
      totalRefundCogs, // Added property
    ];
  }
}
