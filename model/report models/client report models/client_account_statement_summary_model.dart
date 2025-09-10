import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class ClientAccountStatementSummaryModel extends Equatable {
  final double? totalDebit;
  final double? totalCredit;
  final double? netBalance;

  const ClientAccountStatementSummaryModel({
    this.totalDebit,
    this.totalCredit,
    this.netBalance,
  });

  factory ClientAccountStatementSummaryModel.fromJson(
      Map<String, dynamic> json) {
    return ClientAccountStatementSummaryModel(
      totalDebit: receiveDouble(json['total_debit']),
      totalCredit: receiveDouble(json['total_credit']),
      netBalance: receiveDouble(json['net_balance']),
    );
  }

  Map<String, dynamic> toJson() => {
        'total_debit': totalDebit,
        'total_credit': totalCredit,
        'net_balance': netBalance,
      };

  ClientAccountStatementSummaryModel copyWith({
    double? totalDebit,
    double? totalCredit,
    double? netBalance,
  }) {
    return ClientAccountStatementSummaryModel(
      totalDebit: totalDebit ?? this.totalDebit,
      totalCredit: totalCredit ?? this.totalCredit,
      netBalance: netBalance ?? this.netBalance,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [totalDebit, totalCredit, netBalance];
}
