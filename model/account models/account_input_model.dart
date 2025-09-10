// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:almonazim/core/helper/functions/datetime%20functions/to_local_datetime.dart';

class AccountInputModel {
  int? accountsId;
  String? accountsName;
  int? accountsLevel;
  int? accountsIsSub;
  String? accountsNature;
  String? accountsStatement;
  String? accountsCode;
  String? accountParentPrepaidExpenseName;
  dynamic accountsParentId;
  String? accountsCreatedAt;
  DateTime? startDate;
  DateTime? endDate;
  AccountInputModel({
    this.accountsId,
    this.accountsName,
    this.accountsLevel,
    this.accountsIsSub,
    this.accountsNature,
    this.accountParentPrepaidExpenseName,
    this.accountsStatement,
    this.accountsCode,
    this.accountsParentId,
    this.accountsCreatedAt,
    this.startDate,
    this.endDate,
  });

  AccountInputModel copyWith({
    int? accountsId,
    String? accountsName,
    int? accountsLevel,
    int? accountsIsSub,
    String? accountsNature,
    String? accountsStatement,
    String? accountsCode,
    dynamic accountsParentId,
    String? accountsCreatedAt,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return AccountInputModel(
      accountsId: accountsId ?? this.accountsId,
      accountsName: accountsName ?? this.accountsName,
      accountsLevel: accountsLevel ?? this.accountsLevel,
      accountsIsSub: accountsIsSub ?? this.accountsIsSub,
      accountsNature: accountsNature ?? this.accountsNature,
      accountsStatement: accountsStatement ?? this.accountsStatement,
      accountsCode: accountsCode ?? this.accountsCode,
      accountsParentId: accountsParentId ?? this.accountsParentId,
      accountsCreatedAt: accountsCreatedAt ?? this.accountsCreatedAt,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'accounts_id': accountsId,
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
      'start_date': startDate?.toUtc().toString(),
      'end_date': endDate?.toUtc().toString(),
    };
    map.removeWhere(
      (key, value) {
        return value == null;
      },
    );
    return map;
  }

  factory AccountInputModel.fromMap(Map<String, dynamic> map) {
    return AccountInputModel(
      accountsId: map['accounts_id'] != null ? map['accounts_id'] as int : null,
      accountsName:
          map['accounts_name'] != null ? map['accounts_name'] as String : null,
      accountsLevel:
          map['accounts_level'] != null ? map['accounts_level'] as int : null,
      accountsIsSub:
          map['accounts_is_sub'] != null ? map['accounts_is_sub'] as int : null,
      accountsNature: map['accounts_nature'] != null
          ? map['accounts_nature'] as String
          : null,
      accountsStatement: map['accounts_statement'] != null
          ? map['accounts_statement'] as String
          : null,
      accountsCode:
          map['accounts_code'] != null ? map['accounts_code'] as String : null,
      accountsParentId: map['accounts_parent_id'] as dynamic,
      accountsCreatedAt: map['accounts_created_at'] != null
          ? DateTime.parse(map['accounts_created_at']).toLocal().toString()
          : null,
      startDate: toLocalTime(map['start_date']),
      endDate: toLocalTime(map['end_date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountInputModel.fromJson(String source) =>
      AccountInputModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AccountInputModel(accountsId: $accountsId, accountsName: $accountsName, accountsLevel: $accountsLevel, accountsIsSub: $accountsIsSub, accountsNature: $accountsNature, accountsStatement: $accountsStatement, accountsCode: $accountsCode, accountsParentId: $accountsParentId, accountsCreatedAt: $accountsCreatedAt)';
  }

  @override
  bool operator ==(covariant AccountInputModel other) {
    if (identical(this, other)) return true;

    return other.accountsId == accountsId &&
        other.accountsName == accountsName &&
        other.accountsLevel == accountsLevel &&
        other.accountsIsSub == accountsIsSub &&
        other.accountsNature == accountsNature &&
        other.accountsStatement == accountsStatement &&
        other.accountsCode == accountsCode &&
        other.accountsParentId == accountsParentId &&
        other.accountsCreatedAt == accountsCreatedAt;
  }

  @override
  int get hashCode {
    return accountsId.hashCode ^
        accountsName.hashCode ^
        accountsLevel.hashCode ^
        accountsIsSub.hashCode ^
        accountsNature.hashCode ^
        accountsStatement.hashCode ^
        accountsCode.hashCode ^
        accountsParentId.hashCode ^
        accountsCreatedAt.hashCode;
  }
}
