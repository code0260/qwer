// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class InvoiceProfitModel extends Equatable {
  final int? invoicesId;
  final String? invoicesNumber;
  final String? invoicesDate;
  final String? invoicesClientsName;
  final int? invoicesClientId;
  final double? invoicesAmount;
  final double? invoicesTotalTaxAmount;
  final double? invoicesDiscountAmount; // New property
  final double? invoicesRefundedAmount;
  final double? invoicesCost;
  final double? invoicesNetProfit;

  const InvoiceProfitModel({
    this.invoicesId,
    this.invoicesNumber,
    this.invoicesDate,
    this.invoicesClientId,
    this.invoicesAmount,
    this.invoicesClientsName,
    this.invoicesTotalTaxAmount,
    this.invoicesDiscountAmount, // New property
    this.invoicesRefundedAmount,
    this.invoicesCost,
    this.invoicesNetProfit,
  });

  factory InvoiceProfitModel.fromJson(Map<String, dynamic> json) {
    return InvoiceProfitModel(
      invoicesId: json['invoices_id'] as int?,
      invoicesNumber: json['invoices_number'] as String?,
      invoicesDate: json['invoices_date'] as String?,
      invoicesClientsName: json['invoices_clients_name'] as String?,
      invoicesClientId: json['invoices_client_id'] as int?,
      invoicesAmount: receiveDouble(json['invoices_amount']),
      invoicesTotalTaxAmount: receiveDouble(json['invoices_total_tax_amount']),
      invoicesDiscountAmount:
          receiveDouble(json['invoices_discount_amount']), // New property
      invoicesCost: receiveDouble(json['invoices_cost']),
      invoicesRefundedAmount: receiveDouble(json['invoices_refunded_amount']),
      invoicesNetProfit: receiveDouble(json['invoices_net_profit']),
    );
  }

  Map<String, dynamic> toJson() => {
        'invoices_id': invoicesId,
        'invoices_number': invoicesNumber,
        'invoices_clients_name': invoicesClientsName,
        'invoices_date': invoicesDate,
        'invoices_client_id': invoicesClientId,
        'invoices_amount': invoicesAmount,
        'invoices_total_tax_amount': invoicesTotalTaxAmount,
        'invoices_discount_amount': invoicesDiscountAmount, // New property
        'invoices_cost': invoicesCost,
        'invoices_refunded_amount': invoicesCost,
        'invoices_net_profit': invoicesNetProfit,
      };

  InvoiceProfitModel copyWith({
    int? invoicesId,
    String? invoicesNumber,
    String? invoicesDate,
    String? invoicesClientsName,
    int? invoicesClientId,
    double? invoicesAmount,
    double? invoicesTotalTaxAmount,
    double? invoicesDiscountAmount, // New property
    double? invoicesRefundedAmount,
    double? invoicesCost,
    double? invoicesNetProfit,
  }) {
    return InvoiceProfitModel(
      invoicesId: invoicesId ?? this.invoicesId,
      invoicesNumber: invoicesNumber ?? this.invoicesNumber,
      invoicesDate: invoicesDate ?? this.invoicesDate,
      invoicesClientsName: invoicesClientsName ?? this.invoicesClientsName,
      invoicesClientId: invoicesClientId ?? this.invoicesClientId,
      invoicesAmount: invoicesAmount ?? this.invoicesAmount,
      invoicesTotalTaxAmount:
          invoicesTotalTaxAmount ?? this.invoicesTotalTaxAmount,
      invoicesDiscountAmount:
          invoicesDiscountAmount ?? this.invoicesDiscountAmount, // New property
      invoicesRefundedAmount:
          invoicesRefundedAmount ?? this.invoicesRefundedAmount,
      invoicesCost: invoicesCost ?? this.invoicesCost,
      invoicesNetProfit: invoicesNetProfit ?? this.invoicesNetProfit,
    );
  }

  @override
  List<Object?> get props {
    return [
      invoicesId,
      invoicesNumber,
      invoicesDate,
      invoicesClientsName,
      invoicesClientId,
      invoicesAmount,
      invoicesTotalTaxAmount,
      invoicesDiscountAmount, // New property
      invoicesRefundedAmount,
      invoicesCost,
      invoicesNetProfit,
    ];
  }
}
