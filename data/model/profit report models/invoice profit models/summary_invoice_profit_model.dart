// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class SummaryInvoiceProfitModel extends Equatable {
  final double? totalAmount;
  final double? totalTax;
  final double? totalDiscount; // New property
  final double? totalCost;
  final double? totalRefund;
  final double? totalNetProfit;

  const SummaryInvoiceProfitModel({
    this.totalAmount,
    this.totalTax,
    this.totalDiscount, // New property
    this.totalCost,
    this.totalRefund,
    this.totalNetProfit,
  });

  // Factory constructor to create an instance from JSON
  factory SummaryInvoiceProfitModel.fromJson(Map<String, dynamic> json) {
    return SummaryInvoiceProfitModel(
      totalAmount: receiveDouble(json['total_amount']),
      totalTax: receiveDouble(json['total_tax']),
      totalDiscount: receiveDouble(json['total_discount']), // New property
      totalCost: receiveDouble(json['total_cost']),
      totalRefund: receiveDouble(json['total_refund']),
      totalNetProfit: receiveDouble(json['total_net_profit']),
    );
  }

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'total_amount': totalAmount,
      'total_tax': totalTax,
      'total_discount': totalDiscount, // New property
      'total_cost': totalCost,
      'total_refund': totalRefund,
      'total_net_profit': totalNetProfit,
    };
  }

  SummaryInvoiceProfitModel copyWith({
    double? totalAmount,
    double? totalTax,
    double? totalDiscount, // New property
    double? totalCost,
    double? totalRefund,
    double? totalNetProfit,
  }) {
    return SummaryInvoiceProfitModel(
      totalAmount: totalAmount ?? this.totalAmount,
      totalTax: totalTax ?? this.totalTax,
      totalDiscount: totalDiscount ?? this.totalDiscount, // New property
      totalCost: totalCost ?? this.totalCost,
      totalRefund: totalRefund ?? this.totalRefund,
      totalNetProfit: totalNetProfit ?? this.totalNetProfit,
    );
  }

  @override
  List<Object?> get props {
    return [
      totalAmount,
      totalTax,
      totalDiscount, // New property
      totalCost,
      totalRefund,
      totalNetProfit,
    ];
  }
}
