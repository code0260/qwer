import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class WithdrawalModel extends Equatable {
  final int? withdrawalsId;
  final int? withdrawalsPartnerId;
  final int? withdrawalsInvoicesId;
  final String? invoicesNumber;
  final String? withdrawalsType;
  final double? withdrawalsCashAmount; // Changed type to double?
  final double? withdrawalsAmountInBase; // New field
  final int? withdrawalsAmountCurrencyId; // New field
  final String? withdrawalsNotes;
  final String? withdrawalsCreatedAt;
  final String? withdrawalsUpdatedAt;

  const WithdrawalModel({
    this.withdrawalsId,
    this.withdrawalsPartnerId,
    this.invoicesNumber,
    this.withdrawalsInvoicesId,
    this.withdrawalsType,
    this.withdrawalsCashAmount,
    this.withdrawalsAmountInBase,
    this.withdrawalsAmountCurrencyId,
    this.withdrawalsNotes,
    this.withdrawalsCreatedAt,
    this.withdrawalsUpdatedAt,
  });

  factory WithdrawalModel.fromJson(Map<String, dynamic> json) {
    return WithdrawalModel(
      withdrawalsId: json['withdrawals_id'] as int?,
      withdrawalsPartnerId: json['withdrawals_partner_id'] as int?,
      withdrawalsInvoicesId: json['withdrawals_invoices_id'] as int?,
      invoicesNumber: json['invoices_number'] as String?,
      withdrawalsType: json['withdrawals_type'] as String?,
      withdrawalsCashAmount: receiveDouble(
          json['withdrawals_cash_amount']), // Updated parsing logic
      withdrawalsAmountInBase:
          receiveDouble(json['withdrawals_amount_in_base']), // New field
      withdrawalsAmountCurrencyId:
          json['withdrawals_amount_currency_id'] as int?, // New field
      withdrawalsNotes: json['withdrawals_notes'] as String?,
      withdrawalsCreatedAt: json['withdrawals_created_at'] != null
          ? DateTime.parse('${json['withdrawals_created_at']}Z')
              .toLocal()
              .toString()
          : null,
      withdrawalsUpdatedAt: json['withdrawals_updated_at'] != null
          ? DateTime.parse('${json['withdrawals_updated_at']}Z')
              .toLocal()
              .toString()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'withdrawals_id': withdrawalsId,
        'withdrawals_partner_id': withdrawalsPartnerId,
        'withdrawals_invoices_id': withdrawalsInvoicesId,
        'invoices_number': invoicesNumber,
        'withdrawals_type': withdrawalsType,
        'withdrawals_cash_amount': withdrawalsCashAmount, // Updated field
        'withdrawals_amount_in_base': withdrawalsAmountInBase, // New field
        'withdrawals_amount_currency_id':
            withdrawalsAmountCurrencyId, // New field
        'withdrawals_notes': withdrawalsNotes,
        'withdrawals_created_at': withdrawalsCreatedAt == null
            ? null
            : DateTime.parse(withdrawalsCreatedAt!).toUtc().toString(),
        'withdrawals_updated_at': withdrawalsUpdatedAt == null
            ? null
            : DateTime.parse(withdrawalsUpdatedAt!).toUtc().toString(),
      };

  WithdrawalModel copyWith({
    int? withdrawalsId,
    int? withdrawalsPartnerId,
    int? withdrawalsInvoicesId,
    String? invoicesNumber,
    String? withdrawalsType,
    double? withdrawalsCashAmount, // Updated type
    double? withdrawalsAmountInBase, // New field
    int? withdrawalsAmountCurrencyId, // New field
    String? withdrawalsNotes,
    String? withdrawalsCreatedAt,
    String? withdrawalsUpdatedAt,
  }) {
    return WithdrawalModel(
      withdrawalsId: withdrawalsId ?? this.withdrawalsId,
      withdrawalsPartnerId: withdrawalsPartnerId ?? this.withdrawalsPartnerId,
      withdrawalsInvoicesId:
          withdrawalsInvoicesId ?? this.withdrawalsInvoicesId,
      invoicesNumber: invoicesNumber ?? this.invoicesNumber,
      withdrawalsType: withdrawalsType ?? this.withdrawalsType,
      withdrawalsCashAmount:
          withdrawalsCashAmount ?? this.withdrawalsCashAmount, // Updated field
      withdrawalsAmountInBase:
          withdrawalsAmountInBase ?? this.withdrawalsAmountInBase, // New field
      withdrawalsAmountCurrencyId: withdrawalsAmountCurrencyId ??
          this.withdrawalsAmountCurrencyId, // New field
      withdrawalsNotes: withdrawalsNotes ?? this.withdrawalsNotes,
      withdrawalsCreatedAt: withdrawalsCreatedAt ?? this.withdrawalsCreatedAt,
      withdrawalsUpdatedAt: withdrawalsUpdatedAt ?? this.withdrawalsUpdatedAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      withdrawalsId,
      withdrawalsPartnerId,
      withdrawalsInvoicesId,
      withdrawalsType,
      withdrawalsCashAmount, // Updated field
      withdrawalsAmountInBase, // New field
      withdrawalsAmountCurrencyId, // New field
      withdrawalsNotes,
      withdrawalsCreatedAt,
      withdrawalsUpdatedAt,
    ];
  }
}
