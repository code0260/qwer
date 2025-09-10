import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class ProductStatementSummaryModel extends Equatable {
  final double? totalNetSales;
  final double? totalNetPurchases;
  final double? totalTransferredOut;
  final double? totalTransferredIn;
  final double? totalAdjustmentNet;
  final double? totalIn;
  final double? totalOut;

  const ProductStatementSummaryModel(
      {this.totalNetSales,
      this.totalNetPurchases,
      this.totalTransferredOut,
      this.totalTransferredIn,
      this.totalAdjustmentNet,
      this.totalIn,
      this.totalOut});

  factory ProductStatementSummaryModel.fromJson(Map<String, dynamic> json) {
    return ProductStatementSummaryModel(
      totalNetSales: receiveDouble(json['total_net_sales']),
      totalNetPurchases: receiveDouble(json['total_net_purchases']),
      totalTransferredOut: receiveDouble(json['total_transferred_out']),
      totalTransferredIn: receiveDouble(json['total_transferred_in']),
      totalAdjustmentNet: receiveDouble(json['total_adjustment_net']),
      totalIn: receiveDouble(json['total_in']),
      totalOut: receiveDouble(json['total_out']),
    );
  }

  Map<String, dynamic> toJson() => {
        'total_net_sales': totalNetSales,
        'total_net_purchases': totalNetPurchases,
        'total_transferred_out': totalTransferredOut,
        'total_transferred_in': totalTransferredIn,
        'total_adjustment_net': totalAdjustmentNet,
        'total_in': totalIn,
        'total_out': totalOut,
      };

  ProductStatementSummaryModel copyWith({
    double? totalNetSales,
    double? totalNetPurchases,
    double? totalTransferredOut,
    double? totalTransferredIn,
    double? totalAdjustmentNet,
  }) {
    return ProductStatementSummaryModel(
      totalNetSales: totalNetSales ?? this.totalNetSales,
      totalNetPurchases: totalNetPurchases ?? this.totalNetPurchases,
      totalTransferredOut: totalTransferredOut ?? this.totalTransferredOut,
      totalTransferredIn: totalTransferredIn ?? this.totalTransferredIn,
      totalAdjustmentNet: totalAdjustmentNet ?? this.totalAdjustmentNet,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      totalNetSales,
      totalNetPurchases,
      totalTransferredOut,
      totalTransferredIn,
      totalAdjustmentNet,
    ];
  }
}
