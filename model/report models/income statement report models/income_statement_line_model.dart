import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class IncomeStatementLineModel extends Equatable {
  final int? accountId;
  final String? accountName;
  final String? accountCode;
  final String? accountsNature;
  final int? accountsLevel;
  final int? accountsParentId;
  final int? accountsIsSub;
  final double? totalDebit;
  final double? totalCredit;
  final double? total;

  const IncomeStatementLineModel({
    this.accountId,
    this.accountName,
    this.accountCode,
    this.accountsNature,
    this.accountsLevel,
    this.accountsParentId,
    this.accountsIsSub,
    this.totalDebit,
    this.totalCredit,
    this.total,
  });

  factory IncomeStatementLineModel.fromJson(Map<String, dynamic> json) {
    return IncomeStatementLineModel(
      accountId: json['account_id'] as int?,
      accountName: json['account_name'] as String?,
      accountCode: json['account_code'] as String?,
      accountsNature: json['accounts_nature'] as String?,
      accountsLevel: json['accounts_level'] as int?,
      accountsParentId: json['accounts_parent_id'] as int?,
      accountsIsSub: json['accounts_is_sub'] as int?,
      totalDebit: receiveDouble(json['total_debit']),
      totalCredit: receiveDouble(json['total_credit']),
      total: receiveDouble(json['total']),
    );
  }

  Map<String, dynamic> toJson() => {
        'account_id': accountId,
        'account_name': accountName,
        'account_code': accountCode,
        'accounts_nature': accountsNature,
        'accounts_level': accountsLevel,
        'accounts_parent_id': accountsParentId,
        'accounts_is_sub': accountsIsSub,
        'total_debit': totalDebit,
        'total_credit': totalCredit,
        'total': total,
      };

  IncomeStatementLineModel copyWith({
    int? accountId,
    String? accountName,
    String? accountCode,
    String? accountsNature,
    int? accountsLevel,
    int? accountsParentId,
    int? accountsIsSub,
    double? totalDebit,
    double? totalCredit,
    double? total,
  }) {
    return IncomeStatementLineModel(
      accountId: accountId ?? this.accountId,
      accountName: accountName ?? this.accountName,
      accountCode: accountCode ?? this.accountCode,
      accountsNature: accountsNature ?? this.accountsNature,
      accountsLevel: accountsLevel ?? this.accountsLevel,
      accountsParentId: accountsParentId ?? this.accountsParentId,
      accountsIsSub: accountsIsSub ?? this.accountsIsSub,
      totalDebit: totalDebit ?? this.totalDebit,
      totalCredit: totalCredit ?? this.totalCredit,
      total: total ?? this.total,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      accountId,
      accountName,
      accountCode,
      accountsNature,
      accountsLevel,
      accountsParentId,
      accountsIsSub,
      totalDebit,
      totalCredit,
      total,
    ];
  }
}
