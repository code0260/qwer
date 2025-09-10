import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class TransactionLineModel extends Equatable {
  final int? transactionLineId;
  final int? transactionLineTransactionsId;
  final int? transactionLineAccountId;
  final int? transactionLinePartnerId;
  final double? transactionLineAmount;
  final String? transactionLineDebitCredit;
  final String? transactionLineDescription;
  final String? transactionLineCreatedAt;
  final String? transactionLineUpdatedAt;
  final String? transactionLinePartnerType;
  final int? transactionsNumber;

  const TransactionLineModel(
      {this.transactionLineId,
      this.transactionLineTransactionsId,
      this.transactionLineAccountId,
      this.transactionLinePartnerId,
      this.transactionLineAmount,
      this.transactionLineDebitCredit,
      this.transactionLineDescription,
      this.transactionLineCreatedAt,
      this.transactionLineUpdatedAt,
      this.transactionLinePartnerType,
      this.transactionsNumber});

  factory TransactionLineModel.fromJson(Map<String, dynamic> json) {
    return TransactionLineModel(
      transactionLineId: json['transaction_line_id'] as int?,
      transactionLineTransactionsId:
          json['transaction_line_transactions_id'] as int?,
      transactionLineAccountId: json['transaction_line_account_id'] as int?,
      transactionLinePartnerId: json['transaction_line_partner_id'] as int?,
      transactionLineAmount: receiveDouble(json['transaction_line_amount']),
      transactionLineDebitCredit:
          json['transaction_line_debit_credit'] as String?,
      transactionLineDescription:
          json['transaction_line_description'] as String?,
      transactionLineCreatedAt: json['transaction_line_created_at'] == null
          ? null
          : DateTime.parse('${json['transaction_line_created_at']}Z')
              .toLocal()
              .toString(),
      transactionLineUpdatedAt: json['transaction_line_updated_at'] == null
          ? null
          : DateTime.parse('${json['transaction_line_updated_at']}Z')
              .toLocal()
              .toString(),
      transactionLinePartnerType:
          json['transaction_line_partner_type'] as String?,
      transactionsNumber: json['transactions_number'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'transaction_line_id': transactionLineId,
        'transaction_line_transactions_id': transactionLineTransactionsId,
        'transaction_line_account_id': transactionLineAccountId,
        'transaction_line_partner_id': transactionLinePartnerId,
        'transaction_line_amount': transactionLineAmount,
        'transaction_line_debit_credit': transactionLineDebitCredit,
        'transaction_line_description': transactionLineDescription,
        'transaction_line_created_at': transactionLineCreatedAt == null
            ? null
            : DateTime.parse(transactionLineCreatedAt!).toUtc().toString(),
        'transaction_line_updated_at': transactionLineUpdatedAt == null
            ? null
            : DateTime.parse(transactionLineUpdatedAt!).toUtc().toString(),
        'transaction_line_partner_type': transactionLinePartnerType,
      };

  TransactionLineModel copyWith({
    int? transactionLineId,
    int? transactionLineTransactionsId,
    int? transactionLineAccountId,
    int? transactionLinePartnerId,
    double? transactionLineAmount,
    String? transactionLineDebitCredit,
    String? transactionLineDescription,
    String? transactionLineCreatedAt,
    String? transactionLineUpdatedAt,
    String? transactionLinePartnerType,
  }) {
    return TransactionLineModel(
      transactionLineId: transactionLineId ?? this.transactionLineId,
      transactionLineTransactionsId:
          transactionLineTransactionsId ?? this.transactionLineTransactionsId,
      transactionLineAccountId:
          transactionLineAccountId ?? this.transactionLineAccountId,
      transactionLinePartnerId:
          transactionLinePartnerId ?? this.transactionLinePartnerId,
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
      transactionLinePartnerType:
          transactionLinePartnerType ?? this.transactionLinePartnerType,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      transactionLineId,
      transactionLineTransactionsId,
      transactionLineAccountId,
      transactionLinePartnerId,
      transactionLineAmount,
      transactionLineDebitCredit,
      transactionLineDescription,
      transactionLineCreatedAt,
      transactionLineUpdatedAt,
      transactionLinePartnerType,
    ];
  }
}
