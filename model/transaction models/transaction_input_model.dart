// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TransactionInputModel {
  int? transactionsId;
  DateTime? startDate;
  DateTime? endDate;
  int? accountsId;
  int requestNumber;

  TransactionInputModel({
    this.requestNumber = -1,
    this.transactionsId,
    this.startDate,
    this.endDate,
    this.accountsId,
  });

  TransactionInputModel copyWith({
    int? transactionsId,
    DateTime? startDate,
    DateTime? endDate,
    int? accountsId,
    int? requestNumber,
  }) {
    return TransactionInputModel(
      transactionsId: transactionsId ?? this.transactionsId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      accountsId: accountsId ?? this.accountsId,
      requestNumber: requestNumber ?? this.requestNumber,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'transactions_id': transactionsId,
      'start_date': startDate?.toUtc().toString(),
      'end_date': endDate?.toUtc().toString(),
      "accounts_id": accountsId,
      "request_number": requestNumber,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  factory TransactionInputModel.fromMap(Map<String, dynamic> map) {
    return TransactionInputModel(
      transactionsId:
          map['transactions_id'] != null ? map['transactions_id'] as int : null,
      startDate: map['start_date'] != null
          ? DateTime.parse(map['start_date']).toLocal()
          : null,
      endDate: map['end_date'] != null
          ? DateTime.parse(map['end_date']).toLocal()
          : null,
      accountsId: map['accounts_id'] != null ? map['accounts_id'] as int : null,
      requestNumber: map['request_number'] ?? -1,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionInputModel.fromJson(String source) =>
      TransactionInputModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TransactionInputModel(transactionsId: $transactionsId, startDate: $startDate, endDate: $endDate, accountsId: $accountsId, requestNumber: $requestNumber)';

  @override
  bool operator ==(covariant TransactionInputModel other) {
    if (identical(this, other)) return true;

    return other.transactionsId == transactionsId &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.accountsId == accountsId &&
        other.requestNumber == requestNumber;
  }

  @override
  int get hashCode =>
      transactionsId.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      accountsId.hashCode ^
      requestNumber.hashCode;
}
