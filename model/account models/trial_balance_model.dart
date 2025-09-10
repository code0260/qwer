import 'package:equatable/equatable.dart';

class TrialBalanceModel extends Equatable {
  final int? accountsId;
  final int? accountsBusinessId;
  final String? accountsName;
  final int? accountsLevel;
  final int? accountsIsSub;
  final String? accountsNature;
  final String? accountsStatement;
  final String? accountsCode;
  final int? accountsParentId;
  final String? accountsCreatedAt;
  final String? accountsUpdatedAt;
  final int? trialBalanceId;
  final int? trialBalanceAccountsId;
  final String? trialBalanceOpening;
  final String? trialBalanceCurrent;
  final String? trialBalanceClosing;
  final String? trialBalanceFinancialYear;
  final String? trialBalanceCreatedAt;
  final String? trialBalanceUpdatedAt;

  const TrialBalanceModel({
    this.accountsId,
    this.accountsBusinessId,
    this.accountsName,
    this.accountsLevel,
    this.accountsIsSub,
    this.accountsNature,
    this.accountsStatement,
    this.accountsCode,
    this.accountsParentId,
    this.accountsCreatedAt,
    this.accountsUpdatedAt,
    this.trialBalanceId,
    this.trialBalanceAccountsId,
    this.trialBalanceOpening,
    this.trialBalanceCurrent,
    this.trialBalanceClosing,
    this.trialBalanceFinancialYear,
    this.trialBalanceCreatedAt,
    this.trialBalanceUpdatedAt,
  });

  factory TrialBalanceModel.fromJson(Map<String, dynamic> json) {
    return TrialBalanceModel(
      accountsId: json['accounts_id'] as int?,
      accountsBusinessId: json['accounts_business_id'] as int?,
      accountsName: json['accounts_name'] as String?,
      accountsLevel: json['accounts_level'] as int?,
      accountsIsSub: json['accounts_is_sub'] as int?,
      accountsNature: json['accounts_nature'] as String?,
      accountsStatement: json['accounts_statement'] as String?,
      accountsCode: json['accounts_code'] as String?,
      accountsParentId: json['accounts_parent_id'] as int?,
      accountsCreatedAt: json['accounts_created_at'] as String?,
      accountsUpdatedAt: json['accounts_updated_at'] as String?,
      trialBalanceId: json['trial_balance_id'] as int?,
      trialBalanceAccountsId: json['trial_balance_accounts_id'] as int?,
      trialBalanceOpening: json['trial_balance_opening'] as String?,
      trialBalanceCurrent: json['trial_balance_current'] as String?,
      trialBalanceClosing: json['trial_balance_closing'] as String?,
      trialBalanceFinancialYear:
          json['trial_balance_financial_year'] as String?,
      trialBalanceCreatedAt: json['trial_balance_created_at'] as String?,
      trialBalanceUpdatedAt: json['trial_balance_updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'accounts_id': accountsId,
        'accounts_business_id': accountsBusinessId,
        'accounts_name': accountsName,
        'accounts_level': accountsLevel,
        'accounts_is_sub': accountsIsSub,
        'accounts_nature': accountsNature,
        'accounts_statement': accountsStatement,
        'accounts_code': accountsCode,
        'accounts_parent_id': accountsParentId,
        'accounts_created_at': accountsCreatedAt,
        'accounts_updated_at': accountsUpdatedAt,
        'trial_balance_id': trialBalanceId,
        'trial_balance_accounts_id': trialBalanceAccountsId,
        'trial_balance_opening': trialBalanceOpening,
        'trial_balance_current': trialBalanceCurrent,
        'trial_balance_closing': trialBalanceClosing,
        'trial_balance_financial_year': trialBalanceFinancialYear,
        'trial_balance_created_at': trialBalanceCreatedAt,
        'trial_balance_updated_at': trialBalanceUpdatedAt,
      };

  TrialBalanceModel copyWith({
    int? accountsId,
    int? accountsBusinessId,
    String? accountsName,
    int? accountsLevel,
    int? accountsIsSub,
    String? accountsNature,
    String? accountsStatement,
    String? accountsCode,
    int? accountsParentId,
    String? accountsCreatedAt,
    String? accountsUpdatedAt,
    int? trialBalanceId,
    int? trialBalanceAccountsId,
    String? trialBalanceOpening,
    String? trialBalanceCurrent,
    String? trialBalanceClosing,
    String? trialBalanceFinancialYear,
    String? trialBalanceCreatedAt,
    String? trialBalanceUpdatedAt,
  }) {
    return TrialBalanceModel(
      accountsId: accountsId ?? this.accountsId,
      accountsBusinessId: accountsBusinessId ?? this.accountsBusinessId,
      accountsName: accountsName ?? this.accountsName,
      accountsLevel: accountsLevel ?? this.accountsLevel,
      accountsIsSub: accountsIsSub ?? this.accountsIsSub,
      accountsNature: accountsNature ?? this.accountsNature,
      accountsStatement: accountsStatement ?? this.accountsStatement,
      accountsCode: accountsCode ?? this.accountsCode,
      accountsParentId: accountsParentId ?? this.accountsParentId,
      accountsCreatedAt: accountsCreatedAt ?? this.accountsCreatedAt,
      accountsUpdatedAt: accountsUpdatedAt ?? this.accountsUpdatedAt,
      trialBalanceId: trialBalanceId ?? this.trialBalanceId,
      trialBalanceAccountsId:
          trialBalanceAccountsId ?? this.trialBalanceAccountsId,
      trialBalanceOpening: trialBalanceOpening ?? this.trialBalanceOpening,
      trialBalanceCurrent: trialBalanceCurrent ?? this.trialBalanceCurrent,
      trialBalanceClosing: trialBalanceClosing ?? this.trialBalanceClosing,
      trialBalanceFinancialYear:
          trialBalanceFinancialYear ?? this.trialBalanceFinancialYear,
      trialBalanceCreatedAt:
          trialBalanceCreatedAt ?? this.trialBalanceCreatedAt,
      trialBalanceUpdatedAt:
          trialBalanceUpdatedAt ?? this.trialBalanceUpdatedAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      accountsId,
      accountsBusinessId,
      accountsName,
      accountsLevel,
      accountsIsSub,
      accountsNature,
      accountsStatement,
      accountsCode,
      accountsParentId,
      accountsCreatedAt,
      accountsUpdatedAt,
      trialBalanceId,
      trialBalanceAccountsId,
      trialBalanceOpening,
      trialBalanceCurrent,
      trialBalanceClosing,
      trialBalanceFinancialYear,
      trialBalanceCreatedAt,
      trialBalanceUpdatedAt,
    ];
  }
}
