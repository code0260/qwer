import 'package:equatable/equatable.dart';
import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';

class AccountModel extends Equatable {
  final int? accountsId;
  final int? accountsBusinessId;
  final String? accountsName;
  final int? accountsLevel;
  final int? accountsIsSub;
  final String? accountsNature;
  final String? accountsStatement;
  final String? accountsCode;
  final dynamic accountsParentId;
  final String? accountsCreatedAt;
  final String? accountsUpdatedAt;
  final double? accountsBalance; // New property

  const AccountModel({
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
    this.accountsBalance, // New property
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        accountsId: json['accounts_id'] as int?,
        accountsBusinessId: json['accounts_business_id'] as int?,
        accountsName: json['accounts_name'] as String?,
        accountsLevel: json['accounts_level'] as int?,
        accountsIsSub: json['accounts_is_sub'] as int?,
        accountsNature: json['accounts_nature'] as String?,
        accountsStatement: json['accounts_statement'] as String?,
        accountsCode: json['accounts_code'] as String?,
        accountsParentId: json['accounts_parent_id'] as dynamic,
        accountsCreatedAt: json['accounts_created_at'] != null
            ? DateTime.parse(json['accounts_created_at']).toLocal().toString()
            : null,
        accountsUpdatedAt: json['accounts_updated_at'] != null
            ? DateTime.parse(json['accounts_updated_at']).toLocal().toString()
            : null,
        accountsBalance:
            receiveDouble(json['trial_balance_current']), // New property
      );

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
        'accounts_created_at': accountsCreatedAt != null
            ? DateTime.parse(accountsCreatedAt!).toUtc().toString()
            : null,
        'accounts_updated_at': accountsUpdatedAt != null
            ? DateTime.parse(accountsUpdatedAt!).toUtc().toString()
            : null,
        'trial_balance_current': accountsBalance, // New property
      };

  AccountModel copyWith({
    int? accountsId,
    int? accountsBusinessId,
    String? accountsName,
    int? accountsLevel,
    int? accountsIsSub,
    String? accountsNature,
    String? accountsStatement,
    String? accountsCode,
    dynamic accountsParentId,
    String? accountsCreatedAt,
    String? accountsUpdatedAt,
    double? accountsBalance, // New property
  }) {
    return AccountModel(
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
      accountsBalance: accountsBalance ?? this.accountsBalance, // New property
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
      accountsBalance, // New property
    ];
  }
}
