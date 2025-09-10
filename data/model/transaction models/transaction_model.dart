import 'package:almonazim/core/helper/functions/datetime%20functions/to_local_datetime.dart';
import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class TransactionModel extends Equatable {
  final int? transactionsId;
  final int? transactionsBusinessId;
  final String? transactionsTransactionDate;
  final String? transactionsDescription;
  final dynamic transactionsReferenceNumber;
  final String? transactionsCreatedAt;
  final String? transactionsUpdatedAt;
  final double? totalAmount;
  final String? accountIds;
  final String? transactionReferenceNumberType;
  final int? transactionsNumber;
  final int? transactionsCurrencyId; // Added this field

  const TransactionModel({
    this.transactionsId,
    this.transactionsBusinessId,
    this.transactionsTransactionDate,
    this.transactionsDescription,
    this.transactionsReferenceNumber,
    this.transactionsCreatedAt,
    this.transactionsUpdatedAt,
    this.totalAmount,
    this.accountIds,
    this.transactionReferenceNumberType,
    this.transactionsNumber,
    this.transactionsCurrencyId, // Added this parameter
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transactionsId: json['transactions_id'] as int?,
      transactionsBusinessId: json['transactions_business_id'] as int?,
      transactionsTransactionDate:
          toLocalTime(json['transactions_transaction_date']),
      transactionsDescription: json['transactions_description'] as String?,
      transactionsReferenceNumber:
          json['transactions_reference_number'] as dynamic,
      transactionsCreatedAt: toLocalTime(json['transactions_created_at']),
      transactionsUpdatedAt: toLocalTime(json['transactions_updated_at']),
      totalAmount: receiveDouble(json['total_amount']),
      accountIds: json['account_ids'] as String?,
      transactionReferenceNumberType:
          json['transactions_reference_number_type'] as String?,
      transactionsNumber: json['transactions_number'] as int?,
      transactionsCurrencyId:
          json['transactions_currency_id'] as int?, // Added this line
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'transactions_id': transactionsId,
      'transactions_business_id': transactionsBusinessId,
      'transactions_transaction_date': transactionsTransactionDate == null
          ? null
          : DateTime.parse(transactionsTransactionDate!).toUtc().toString(),
      'transactions_description': transactionsDescription,
      'transactions_reference_number': transactionsReferenceNumber,
      'transactions_created_at': transactionsCreatedAt == null
          ? null
          : DateTime.parse(transactionsCreatedAt!).toUtc().toString(),
      'transactions_updated_at': transactionsUpdatedAt == null
          ? null
          : DateTime.parse(transactionsUpdatedAt!).toUtc().toString(),
      'total_amount': totalAmount,
      'account_ids': accountIds,
      'transactions_reference_number_type': transactionReferenceNumberType,
      'transactions_number': transactionsNumber,
      'transactions_currency_id': transactionsCurrencyId, // Added this line
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  TransactionModel copyWith({
    int? transactionsId,
    int? transactionsBusinessId,
    String? transactionsTransactionDate,
    String? transactionsDescription,
    dynamic transactionsReferenceNumber,
    String? transactionsCreatedAt,
    String? transactionsUpdatedAt,
    double? totalAmount,
    String? accountIds,
    String? transactionReferenceNumberType,
    int? transactionsNumber,
    int? transactionsCurrencyId, // Added this parameter
  }) {
    return TransactionModel(
      transactionsId: transactionsId ?? this.transactionsId,
      transactionsBusinessId:
          transactionsBusinessId ?? this.transactionsBusinessId,
      transactionsTransactionDate:
          transactionsTransactionDate ?? this.transactionsTransactionDate,
      transactionsDescription:
          transactionsDescription ?? this.transactionsDescription,
      transactionsReferenceNumber:
          transactionsReferenceNumber ?? this.transactionsReferenceNumber,
      transactionsCreatedAt:
          transactionsCreatedAt ?? this.transactionsCreatedAt,
      transactionsUpdatedAt:
          transactionsUpdatedAt ?? this.transactionsUpdatedAt,
      totalAmount: totalAmount ?? this.totalAmount,
      accountIds: accountIds ?? this.accountIds,
      transactionReferenceNumberType:
          transactionReferenceNumberType ?? this.transactionReferenceNumberType,
      transactionsNumber: transactionsNumber ?? this.transactionsNumber,
      transactionsCurrencyId: transactionsCurrencyId ??
          this.transactionsCurrencyId, // Added this line
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      transactionsId,
      transactionsBusinessId,
      transactionsTransactionDate,
      transactionsDescription,
      transactionsReferenceNumber,
      transactionsCreatedAt,
      transactionsUpdatedAt,
      totalAmount,
      accountIds,
      transactionReferenceNumberType,
      transactionsNumber,
      transactionsCurrencyId, // Added this field
    ];
  }
}
