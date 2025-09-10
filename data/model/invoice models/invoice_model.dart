// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/core/helper/functions/datetime%20functions/to_local_datetime.dart';
import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class InvoiceModel extends Equatable {
  final int? invoicesId;
  final int? invoicesClientId;
  final String? invoicesType;
  final double? invoicesUndiscountedAmount;
  final double? invoicesDiscountedAmount;
  final double? invoicesShippingCost;
  final double? invoicesShippingCostInBase;
  final String? invoicesPaymentStatus;
  final String? invoicesNotes;
  final String? invoicesCreatedAt;
  final int? invoicesBusinessId;
  final String? clientsName;
  final double? debtsPaidAmount;
  final int? debtsPaidAmountCurrencyId;
  final String? debtsDueDate;
  final int? debtsInvoicesId;
  final int? invoicesPartnerId;
  final String? partnersName;
  final int? invoicesOriginalInvoiceId;
  final String? invoicesOriginalInvoiceNumber;
  final double? invoicesRefundedAmount;
  final int? invoicesAffectRefund;
  final double? invoicesPaidAmount;
  final String? invoicesAppliedAt;
  final String? invoicesNumber;
  final double? invoicesTotalTaxAmount;
  final int? invoicesAmountCurrencyId;
  final double? invoicesAmountInBase;
  final double? debtsPaidAmountInBase;
  final int? invoicesShippingClientId;
  final int? invoicesShippingCurrencyId; // New property
  final String? invoicesShippingPayment;
  final double? invoicesDiscountValue; // New property
  final String? invoicesDiscountType; // New property

  const InvoiceModel(
      {this.invoicesId,
      this.invoicesClientId,
      this.invoicesType,
      this.invoicesUndiscountedAmount,
      this.invoicesDiscountedAmount,
      this.invoicesShippingCost,
      this.invoicesShippingCostInBase,
      this.invoicesPaymentStatus,
      this.invoicesNotes,
      this.invoicesCreatedAt,
      this.invoicesBusinessId,
      this.clientsName,
      this.debtsPaidAmount,
      this.debtsPaidAmountCurrencyId,
      this.debtsDueDate,
      this.debtsInvoicesId,
      this.invoicesPartnerId,
      this.partnersName,
      this.invoicesOriginalInvoiceId,
      this.invoicesOriginalInvoiceNumber,
      this.invoicesRefundedAmount,
      this.invoicesAffectRefund,
      this.invoicesPaidAmount,
      this.invoicesAppliedAt,
      this.invoicesNumber,
      this.invoicesTotalTaxAmount,
      this.invoicesAmountCurrencyId,
      this.invoicesAmountInBase,
      this.debtsPaidAmountInBase,
      this.invoicesShippingClientId,
      this.invoicesShippingCurrencyId, // New property
      this.invoicesShippingPayment,
      this.invoicesDiscountValue, // New property
      this.invoicesDiscountType}); // New property

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        invoicesId: json['invoices_id'] as int?,
        invoicesClientId: json['invoices_client_id'] as int?,
        debtsPaidAmountCurrencyId:
            json['debts_paid_amount_currency_id'] as int?,
        invoicesType: json['invoices_type'] as String?,
        invoicesUndiscountedAmount:
            json['invoices_undiscounted_amount'] is String?
                ? (json['invoices_undiscounted_amount'] as String?)?.toDouble()
                : json['invoices_undiscounted_amount'] as double,
        invoicesDiscountedAmount: json['invoices_discounted_amount'] is String?
            ? (json['invoices_discounted_amount'] as String?)?.toDouble()
            : json['invoices_discounted_amount'] as double,
        invoicesShippingCost: json['invoices_shipping_cost'] is String?
            ? (json['invoices_shipping_cost'] as String?)?.toDouble()
            : json['invoices_shipping_cost'] as double,
        invoicesShippingCostInBase: json['invoices_shipping_cost_in_base']
                is String?
            ? (json['invoices_shipping_cost_in_base'] as String?)?.toDouble()
            : json['invoices_shipping_cost_in_base'] as double,
        invoicesPaymentStatus: json['invoices_payment_status'] as String?,
        invoicesNotes: json['invoices_notes'] as String?,
        invoicesCreatedAt: toLocalTime(json['invoices_created_at']),
        invoicesBusinessId: json['invoices_business_id'] as int?,
        clientsName: json['clients_name'] as String?,
        debtsPaidAmount: json['debts_paid_amount'] is String?
            ? (json['debts_paid_amount'] as String?)?.toDouble()
            : json['debts_paid_amount'] as double,
        debtsDueDate: toLocalTime(json['debts_due_date']),
        debtsInvoicesId: json['debts_invoices_id'] as int?,
        invoicesPartnerId: json['invoices_partner_id'] as int?,
        partnersName: json['partners_name'] as String?,
        invoicesOriginalInvoiceId: json['invoices_original_invoice_id'] as int?,
        invoicesOriginalInvoiceNumber:
            json['invoices_original_invoice_number'] as String?,
        invoicesRefundedAmount: json['invoices_refunded_amount'] is String?
            ? (json['invoices_refunded_amount'] as String?)?.toDouble()
            : json['invoices_refunded_amount'] as double,
        invoicesAffectRefund: json['invoices_affect_refund'] as int?,
        invoicesPaidAmount: json['invoices_paid_amount'] is String?
            ? (json['invoices_paid_amount'] as String?)?.toDouble()
            : json['invoices_paid_amount'] as double,
        invoicesAppliedAt: toLocalTime(json['invoices_applied_at']),
        invoicesNumber: json['invoices_number'] as String?,
        invoicesTotalTaxAmount: json['invoices_total_tax_amount'] is String?
            ? (json['invoices_total_tax_amount'] as String?)?.toDouble()
            : json['invoices_total_tax_amount'] as double,
        invoicesAmountCurrencyId: json['invoices_amount_currency_id'] as int?,
        invoicesAmountInBase: json['invoices_amount_in_base'] is String?
            ? (json['invoices_amount_in_base'] as String?)?.toDouble()
            : json['invoices_amount_in_base'] as double,
        debtsPaidAmountInBase: json['debts_paid_amount_in_base'] is String?
            ? (json['debts_paid_amount_in_base'] as String?)?.toDouble()
            : json['debts_paid_amount_in_base'] as double,
        invoicesShippingClientId: json['invoices_shipping_client_id'] as int?,
        invoicesShippingCurrencyId:
            json['invoices_shipping_currency_id'] as int?, // New property
        invoicesShippingPayment:
            json['invoices_shipping_payment'] as String?, // New property
        invoicesDiscountValue: receiveDouble(json['invoices_discount_value']),
        invoicesDiscountType:
            json['invoices_discount_type'] as String?, // New property
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'invoices_id': invoicesId,
      'invoices_client_id': invoicesClientId,
      'debts_paid_amount_currency_id': debtsPaidAmountCurrencyId,
      'invoices_type': invoicesType,
      'invoices_undiscounted_amount': invoicesUndiscountedAmount,
      'invoices_discounted_amount': invoicesDiscountedAmount,
      'invoices_shipping_cost': invoicesShippingCost,
      'invoices_shipping_cost_in_base': invoicesShippingCostInBase,
      'invoices_payment_status': invoicesPaymentStatus,
      'invoices_notes': invoicesNotes,
      'invoices_created_at': invoicesCreatedAt == null
          ? null
          : DateTime.parse(invoicesCreatedAt!).toUtc().toString(),
      'invoices_business_id': invoicesBusinessId,
      'clients_name': clientsName,
      'debts_paid_amount': debtsPaidAmount,
      'debts_due_date': debtsDueDate == null
          ? null
          : DateTime.parse(debtsDueDate!).toUtc().toString(),
      'debts_invoices_id': debtsInvoicesId,
      'invoices_partner_id': invoicesPartnerId,
      'partners_name': partnersName,
      'invoices_original_invoice_id': invoicesOriginalInvoiceId,
      'invoices_original_invoice_number': invoicesOriginalInvoiceNumber,
      'invoices_refunded_amount': invoicesRefundedAmount,
      'invoices_affect_refund': invoicesAffectRefund,
      'invoices_paid_amount': invoicesPaidAmount,
      'invoices_applied_at': invoicesAppliedAt == null
          ? DateTime.now().toUtc().toString()
          : DateTime.parse(invoicesAppliedAt!).toUtc().toString(),
      'invoices_number': invoicesNumber,
      'invoices_total_tax_amount': invoicesTotalTaxAmount,
      'invoices_amount_currency_id': invoicesAmountCurrencyId,
      'invoices_amount_in_base': invoicesAmountInBase,
      'debts_paid_amount_in_base': debtsPaidAmountInBase,
      'invoices_shipping_client_id': invoicesShippingClientId,
      'invoices_shipping_currency_id':
          invoicesShippingCurrencyId, // New property
      'invoices_shipping_payment': invoicesShippingPayment, // New property
      'invoices_discount_value': invoicesDiscountValue, // New property
      'invoices_discount_type': invoicesDiscountType, // New property
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [
        invoicesId,
        invoicesClientId,
        invoicesType,
        invoicesUndiscountedAmount,
        invoicesDiscountedAmount,
        invoicesShippingCost,
        invoicesShippingCostInBase,
        invoicesPaymentStatus,
        invoicesNotes,
        invoicesCreatedAt,
        invoicesBusinessId,
        clientsName,
        debtsPaidAmountCurrencyId,
        debtsPaidAmount,
        debtsDueDate,
        debtsInvoicesId,
        invoicesPartnerId,
        partnersName,
        invoicesOriginalInvoiceId,
        invoicesOriginalInvoiceNumber,
        invoicesRefundedAmount,
        invoicesAffectRefund,
        invoicesPaidAmount,
        invoicesAppliedAt,
        invoicesNumber,
        invoicesTotalTaxAmount,
        invoicesAmountCurrencyId,
        invoicesAmountInBase,
        debtsPaidAmountInBase,
        invoicesShippingClientId,
        invoicesShippingCurrencyId, // New property
        invoicesShippingPayment,
        invoicesDiscountValue, // New property
        invoicesDiscountType, // New property
      ];

  InvoiceModel copyWith({
    int? invoicesId,
    int? invoicesClientId,
    String? invoicesType,
    double? invoicesUndiscountedAmount,
    double? invoicesDiscountedAmount,
    double? invoicesShippingCost,
    double? invoicesShippingCostInBase,
    String? invoicesPaymentStatus,
    String? invoicesNotes,
    String? invoicesCreatedAt,
    int? invoicesBusinessId,
    int? debtsPaidAmountCurrencyId,
    String? clientsName,
    double? debtsPaidAmount,
    String? debtsDueDate,
    int? debtsInvoicesId,
    int? invoicesPartnerId,
    String? partnersName,
    int? invoicesOriginalInvoiceId,
    String? invoicesOriginalInvoiceNumber,
    double? invoicesRefundedAmount,
    int? invoicesAffectRefund,
    double? invoicesPaidAmount,
    String? invoicesAppliedAt,
    String? invoicesNumber,
    double? invoicesTotalTaxAmount,
    int? invoicesAmountCurrencyId,
    double? invoicesAmountInBase,
    double? debtsPaidAmountInBase,
    int? invoicesShippingClientId,
    int? invoicesShippingCurrencyId, // New property
    String? invoicesShippingPayment, // New property
    double? invoicesDiscountValue, // New property
    String? invoicesDiscountType, // New property
  }) {
    return InvoiceModel(
      invoicesId: invoicesId ?? this.invoicesId,
      invoicesClientId: invoicesClientId ?? this.invoicesClientId,
      debtsPaidAmountCurrencyId:
          debtsPaidAmountCurrencyId ?? this.debtsPaidAmountCurrencyId,
      invoicesType: invoicesType ?? this.invoicesType,
      invoicesUndiscountedAmount:
          invoicesUndiscountedAmount ?? this.invoicesUndiscountedAmount,
      invoicesDiscountedAmount:
          invoicesDiscountedAmount ?? this.invoicesDiscountedAmount,
      invoicesShippingCost: invoicesShippingCost ?? this.invoicesShippingCost,
      invoicesShippingCostInBase:
          invoicesShippingCostInBase ?? this.invoicesShippingCostInBase,
      invoicesPaymentStatus:
          invoicesPaymentStatus ?? this.invoicesPaymentStatus,
      invoicesNotes: invoicesNotes ?? this.invoicesNotes,
      invoicesCreatedAt: invoicesCreatedAt ?? this.invoicesCreatedAt,
      invoicesBusinessId: invoicesBusinessId ?? this.invoicesBusinessId,
      clientsName: clientsName ?? this.clientsName,
      debtsPaidAmount: debtsPaidAmount ?? this.debtsPaidAmount,
      debtsDueDate: debtsDueDate ?? this.debtsDueDate,
      debtsInvoicesId: debtsInvoicesId ?? this.debtsInvoicesId,
      invoicesPartnerId: invoicesPartnerId ?? this.invoicesPartnerId,
      partnersName: partnersName ?? this.partnersName,
      invoicesOriginalInvoiceId:
          invoicesOriginalInvoiceId ?? this.invoicesOriginalInvoiceId,
      invoicesOriginalInvoiceNumber:
          invoicesOriginalInvoiceNumber ?? this.invoicesOriginalInvoiceNumber,
      invoicesRefundedAmount:
          invoicesRefundedAmount ?? this.invoicesRefundedAmount,
      invoicesAffectRefund: invoicesAffectRefund ?? this.invoicesAffectRefund,
      invoicesPaidAmount: invoicesPaidAmount ?? this.invoicesPaidAmount,
      invoicesAppliedAt: invoicesAppliedAt ?? this.invoicesAppliedAt,
      invoicesNumber: invoicesNumber ?? this.invoicesNumber,
      invoicesTotalTaxAmount:
          invoicesTotalTaxAmount ?? this.invoicesTotalTaxAmount,
      invoicesAmountCurrencyId:
          invoicesAmountCurrencyId ?? this.invoicesAmountCurrencyId,
      invoicesAmountInBase: invoicesAmountInBase ?? this.invoicesAmountInBase,
      debtsPaidAmountInBase:
          debtsPaidAmountInBase ?? this.debtsPaidAmountInBase,
      invoicesShippingClientId:
          invoicesShippingClientId ?? this.invoicesShippingClientId,
      invoicesShippingCurrencyId: invoicesShippingCurrencyId ??
          this.invoicesShippingCurrencyId, // New property
      invoicesShippingPayment: invoicesShippingPayment ??
          this.invoicesShippingPayment, // New property
      invoicesDiscountValue:
          invoicesDiscountValue ?? this.invoicesDiscountValue, // New property
      invoicesDiscountType:
          invoicesDiscountType ?? this.invoicesDiscountType, // New property
    );
  }
}
