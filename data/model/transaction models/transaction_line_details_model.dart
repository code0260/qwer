import 'package:almonazim/core/helper/functions/datetime%20functions/to_local_datetime.dart';
import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class TransactionLineDetailsModel extends Equatable {
  final int? transactionLineId;
  final int? transactionsNumber;
  final int? transactionsCurrencyId;
  final int? transactionLineTransactionsId;
  final int? transactionLineAccountId;
  final int? transactionLinePartnerId;
  final String? transactionLinePartnerType;
  final double? transactionLineAmount;
  final String? transactionLineDebitCredit;
  final String? transactionLineDescription;
  final String? transactionLineCreatedAt;
  final String? transactionLineUpdatedAt;
  final int? transactionsId;
  final int? transactionsBusinessId;
  final String? transactionsTransactionDate;
  final String? transactionsDescription;
  final String? transactionsReferenceNumber;
  final String? transactionsReferenceNumberType;
  final String? transactionsCreatedAt;
  final String? transactionsUpdatedAt;

  const TransactionLineDetailsModel({
    this.transactionLineId,
    this.transactionsNumber,
    this.transactionsCurrencyId,
    this.transactionLineTransactionsId,
    this.transactionLineAccountId,
    this.transactionLinePartnerId,
    this.transactionLinePartnerType,
    this.transactionLineAmount,
    this.transactionLineDebitCredit,
    this.transactionLineDescription,
    this.transactionLineCreatedAt,
    this.transactionLineUpdatedAt,
    this.transactionsId,
    this.transactionsBusinessId,
    this.transactionsTransactionDate,
    this.transactionsDescription,
    this.transactionsReferenceNumber,
    this.transactionsReferenceNumberType,
    this.transactionsCreatedAt,
    this.transactionsUpdatedAt,
  });

  factory TransactionLineDetailsModel.fromJson(Map<String, dynamic> json) {
    return TransactionLineDetailsModel(
      transactionLineId: json['transaction_line_id'] as int?,
      transactionsNumber: json['transactions_number'] as int?,
      transactionsCurrencyId: json['transactions_currency_id'] as int?,
      transactionLineTransactionsId:
          json['transaction_line_transactions_id'] as int?,
      transactionLineAccountId: json['transaction_line_account_id'] as int?,
      transactionLinePartnerId: json['transaction_line_partner_id'] as int?,
      transactionLinePartnerType: json['transaction_line_partner_type'],
      transactionLineAmount: receiveDouble(json['transaction_line_amount']),
      transactionLineDebitCredit: json['transaction_line_debit_credit'],
      transactionLineDescription: json['transaction_line_description'],
      transactionLineCreatedAt:
          toLocalTime(json['transaction_line_created_at']),
      transactionLineUpdatedAt: json['transaction_line_updated_at'],
      transactionsId: json['transactions_id'] as int?,
      transactionsBusinessId: json['transactions_business_id'] as int?,
      transactionsTransactionDate: json['transactions_transaction_date'],
      transactionsDescription: json['transactions_description'],
      transactionsReferenceNumber:
          json['transactions_reference_number'] as String?,
      transactionsReferenceNumberType:
          json['transactions_reference_number_type'],
      transactionsCreatedAt: toLocalTime(json['transactions_created_at']),
      transactionsUpdatedAt: json['transactions_updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'transaction_line_id': transactionLineId,
        'transactions_number': transactionsNumber,
        'transactions_currency_id': transactionsCurrencyId,
        'transaction_line_transactions_id': transactionLineTransactionsId,
        'transaction_line_account_id': transactionLineAccountId,
        'transaction_line_partner_id': transactionLinePartnerId,
        'transaction_line_partner_type': transactionLinePartnerType,
        'transaction_line_amount': transactionLineAmount,
        'transaction_line_debit_credit': transactionLineDebitCredit,
        'transaction_line_description': transactionLineDescription,
        'transaction_line_created_at': transactionLineCreatedAt,
        'transaction_line_updated_at': transactionLineUpdatedAt,
        'transactions_id': transactionsId,
        'transactions_business_id': transactionsBusinessId,
        'transactions_transaction_date': transactionsTransactionDate,
        'transactions_description': transactionsDescription,
        'transactions_reference_number': transactionsReferenceNumber,
        'transactions_reference_number_type': transactionsReferenceNumberType,
        'transactions_created_at': transactionsCreatedAt,
        'transactions_updated_at': transactionsUpdatedAt,
      };

  TransactionLineDetailsModel copyWith({
    int? transactionLineId,
    int? transactionsCurrencyId,
    int? transactionsNumber,
    int? transactionLineTransactionsId,
    int? transactionLineAccountId,
    int? transactionLinePartnerId,
    String? transactionLinePartnerType,
    double? transactionLineAmount,
    String? transactionLineDebitCredit,
    String? transactionLineDescription,
    String? transactionLineCreatedAt,
    String? transactionLineUpdatedAt,
    int? transactionsId,
    int? transactionsBusinessId,
    String? transactionsTransactionDate,
    String? transactionsDescription,
    String? transactionsReferenceNumber,
    String? transactionsReferenceNumberType,
    String? transactionsCreatedAt,
    String? transactionsUpdatedAt,
  }) {
    return TransactionLineDetailsModel(
      transactionLineId: transactionLineId ?? this.transactionLineId,
      transactionsNumber: transactionsNumber ?? this.transactionsNumber,
      transactionsCurrencyId:
          transactionsCurrencyId ?? this.transactionsCurrencyId,
      transactionLineTransactionsId:
          transactionLineTransactionsId ?? this.transactionLineTransactionsId,
      transactionLineAccountId:
          transactionLineAccountId ?? this.transactionLineAccountId,
      transactionLinePartnerId:
          transactionLinePartnerId ?? this.transactionLinePartnerId,
      transactionLinePartnerType:
          transactionLinePartnerType ?? this.transactionLinePartnerType,
      transactionLineAmount:
          transactionLineAmount ?? this.transactionLineAmount,
      transactionLineDebitCredit:
          transactionLineDebitCredit ?? this.transactionLineDebitCredit,
      transactionLineDescription:
          transactionLineDescription ?? this.transactionLineDescription,
      transactionLineCreatedAt:
          transactionLineCreatedAt ?? this.transactionLineCreatedAt,
      transactionLineUpdatedAt:
          transactionLineUpdatedAt ?? this.transactionLineUpdatedAt,
      transactionsId: transactionsId ?? this.transactionsId,
      transactionsBusinessId:
          transactionsBusinessId ?? this.transactionsBusinessId,
      transactionsTransactionDate:
          transactionsTransactionDate ?? this.transactionsTransactionDate,
      transactionsDescription:
          transactionsDescription ?? this.transactionsDescription,
      transactionsReferenceNumber:
          transactionsReferenceNumber ?? this.transactionsReferenceNumber,
      transactionsReferenceNumberType: transactionsReferenceNumberType ??
          this.transactionsReferenceNumberType,
      transactionsCreatedAt:
          transactionsCreatedAt ?? this.transactionsCreatedAt,
      transactionsUpdatedAt:
          transactionsUpdatedAt ?? this.transactionsUpdatedAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      transactionLineId,
      transactionsNumber,
      transactionsCurrencyId,
      transactionLineTransactionsId,
      transactionLineAccountId,
      transactionLinePartnerId,
      transactionLinePartnerType,
      transactionLineAmount,
      transactionLineDebitCredit,
      transactionLineDescription,
      transactionLineCreatedAt,
      transactionLineUpdatedAt,
      transactionsId,
      transactionsBusinessId,
      transactionsTransactionDate,
      transactionsDescription,
      transactionsReferenceNumber,
      transactionsReferenceNumberType,
      transactionsCreatedAt,
      transactionsUpdatedAt,
    ];
  }
}
