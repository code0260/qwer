// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/data/model/account%20models/account_model.dart';
import 'package:almonazim/data/model/transaction%20models/general%20ledger/general_ledger_summary_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_details_model.dart';
import 'package:flutter/foundation.dart';

class GeneralLedgerModel {
  final AccountModel accountModel;
  final List<TransactionLineDetailsModel> accountTransactions;
  final GeneralLedgerSummaryModel summaryModel;
  GeneralLedgerModel({
    required this.accountModel,
    required this.accountTransactions,
    required this.summaryModel,
  });

  GeneralLedgerModel copyWith({
    AccountModel? accountModel,
    List<TransactionLineDetailsModel>? accountTransactions,
    GeneralLedgerSummaryModel? summaryModel,
  }) {
    return GeneralLedgerModel(
      accountModel: accountModel ?? this.accountModel,
      accountTransactions: accountTransactions ?? this.accountTransactions,
      summaryModel: summaryModel ?? this.summaryModel,
    );
  }

  factory GeneralLedgerModel.fromJson(Map<String, dynamic> map) {
    return GeneralLedgerModel(
      accountModel:
          AccountModel.fromJson(map['account'] as Map<String, dynamic>),
      accountTransactions: List<TransactionLineDetailsModel>.from(
        (map['transactions'] as List<dynamic>).map<TransactionLineDetailsModel>(
          (x) =>
              TransactionLineDetailsModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      summaryModel: GeneralLedgerSummaryModel.fromJson(
          map['summary'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() =>
      'GeneralLedgerModel(accountModel: $accountModel, accountTransactions: $accountTransactions, summaryModel: $summaryModel)';

  @override
  bool operator ==(covariant GeneralLedgerModel other) {
    if (identical(this, other)) return true;

    return other.accountModel == accountModel &&
        listEquals(other.accountTransactions, accountTransactions) &&
        other.summaryModel == summaryModel;
  }

  @override
  int get hashCode =>
      accountModel.hashCode ^
      accountTransactions.hashCode ^
      summaryModel.hashCode;
}
