import 'dart:convert';

class RevenuesSummaryModel {
  final double totalRevenues;
  final int numberOfTransactions;
  final double averageTransactionAmount;

  RevenuesSummaryModel({
    required this.totalRevenues,
    required this.numberOfTransactions,
    required this.averageTransactionAmount,
  });

  RevenuesSummaryModel copyWith({
    double? totalRevenues,
    int? numberOfTransactions,
    double? averageTransactionAmount,
  }) {
    return RevenuesSummaryModel(
      totalRevenues: totalRevenues ?? this.totalRevenues,
      numberOfTransactions: numberOfTransactions ?? this.numberOfTransactions,
      averageTransactionAmount:
          averageTransactionAmount ?? this.averageTransactionAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total_revenues': totalRevenues,
      'number_of_transactions': numberOfTransactions,
      'average_transaction_amount': averageTransactionAmount,
    };
  }

  factory RevenuesSummaryModel.fromMap(Map<String, dynamic> map) {
    return RevenuesSummaryModel(
      totalRevenues: map['total_revenues'] as double,
      numberOfTransactions: map['number_of_transactions'] as int,
      averageTransactionAmount: map['average_transaction_amount'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory RevenuesSummaryModel.fromJson(String source) =>
      RevenuesSummaryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RevenuesSummaryModel(total_revenues: $totalRevenues, number_of_transactions: $numberOfTransactions, average_transaction_amount: $averageTransactionAmount)';

  @override
  bool operator ==(covariant RevenuesSummaryModel other) {
    if (identical(this, other)) return true;

    return other.totalRevenues == totalRevenues &&
        other.numberOfTransactions == numberOfTransactions &&
        other.averageTransactionAmount == averageTransactionAmount;
  }

  @override
  int get hashCode =>
      totalRevenues.hashCode ^
      numberOfTransactions.hashCode ^
      averageTransactionAmount.hashCode;
}
