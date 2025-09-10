// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/data/model/cash%20models/get_all_cash_model.dart';
import 'package:almonazim/data/model/report%20models/cash%20report%20models/cash_account_statement_summary_model.dart';
import 'package:almonazim/data/model/report%20models/cash%20report%20models/cash_deal_model.dart';
import 'package:flutter/foundation.dart';

class CashAccountStatementModel {
  final GetAllCashModel getCashModel;
  final List<CashDealModel> cashDeals;
  final CashAccountStatementSummaryModel summaryModel;
  CashAccountStatementModel({
    required this.getCashModel,
    required this.cashDeals,
    required this.summaryModel,
  });

  CashAccountStatementModel copyWith({
    GetAllCashModel? getCashModel,
    List<CashDealModel>? cashDeals,
    CashAccountStatementSummaryModel? summaryModel,
  }) {
    return CashAccountStatementModel(
      getCashModel: getCashModel ?? this.getCashModel,
      cashDeals: cashDeals ?? this.cashDeals,
      summaryModel: summaryModel ?? this.summaryModel,
    );
  }

  factory CashAccountStatementModel.fromJson(Map<String, dynamic> map) {
    return CashAccountStatementModel(
      getCashModel: GetAllCashModel.fromJson(map),
      cashDeals: List<CashDealModel>.from(
        (map['deals'] as List<dynamic>).map<CashDealModel>(
          (x) => CashDealModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      summaryModel: CashAccountStatementSummaryModel.fromJson(
          map['summary'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() =>
      'CashAccountStatementModel(getCashModel: $getCashModel, cashDeals: $cashDeals, summaryModel: $summaryModel)';

  @override
  bool operator ==(covariant CashAccountStatementModel other) {
    if (identical(this, other)) return true;

    return other.getCashModel == getCashModel &&
        listEquals(other.cashDeals, cashDeals) &&
        other.summaryModel == summaryModel;
  }

  @override
  int get hashCode =>
      getCashModel.hashCode ^ cashDeals.hashCode ^ summaryModel.hashCode;
}
