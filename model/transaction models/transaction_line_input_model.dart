import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';

class TransactionLineInputModel {
  int? transactionLineId;
  int? transactionLineTransactionsId;
  int? transactionLineAccountId;
  String? transactionLineAccountName;
  dynamic transactionLinePartnerId;
  double? transactionLineAmount;
  String? transactionLineDebitCredit;
  String? transactionLineDescription;
  String? transactionLineCreatedAt;
  String? transactionLinePartnerType;

  TransactionLineInputModel({
    this.transactionLineId,
    this.transactionLineTransactionsId,
    this.transactionLineAccountId,
    this.transactionLineAccountName,
    this.transactionLinePartnerId,
    this.transactionLineAmount,
    this.transactionLineDebitCredit,
    this.transactionLineDescription,
    this.transactionLineCreatedAt,
    this.transactionLinePartnerType,
  });

  Map<String, dynamic> toMap() {
    return {
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
      'transaction_line_partner_type': transactionLinePartnerType,
    };
  }

  factory TransactionLineInputModel.fromMap(Map<String, dynamic> map) {
    return TransactionLineInputModel(
      transactionLineId: map['transaction_line_id'] as int?,
      transactionLineTransactionsId:
          map['transaction_line_transactions_id'] as int?,
      transactionLineAccountId: map['transaction_line_account_id'] as int?,
      transactionLineAccountName: map['transactionLineAccountName'] as String?,
      transactionLinePartnerId: map['transaction_line_partner_id'],
      transactionLineAmount: receiveDouble(map['transaction_line_amount']),
      transactionLineDebitCredit:
          map['transaction_line_debit_credit'] as String?,
      transactionLineDescription:
          map['transaction_line_description'] as String?,
      transactionLineCreatedAt: map['transaction_line_created_at'] == null
          ? null
          : DateTime.parse('${map['transaction_line_created_at']}Z')
              .toLocal()
              .toString(),
      transactionLinePartnerType:
          map['transaction_line_partner_type'] as String?,
    );
  }
}
