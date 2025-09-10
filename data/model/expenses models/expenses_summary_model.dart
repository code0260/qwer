import 'dart:convert';

class ExpensesSummaryModel {
  final double totalExpenses;
  final int numberOfTransactions;
  final double averageTransactionAmount;

  ExpensesSummaryModel({
    required this.totalExpenses,
    required this.numberOfTransactions,
    required this.averageTransactionAmount,
  });

  ExpensesSummaryModel copyWith({
    double? totalExpenses,
    int? numberOfTransactions,
    double? averageTransactionAmount,
  }) {
    return ExpensesSummaryModel(
      totalExpenses: totalExpenses ?? this.totalExpenses,
      numberOfTransactions: numberOfTransactions ?? this.numberOfTransactions,
      averageTransactionAmount:
          averageTransactionAmount ?? this.averageTransactionAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total_expenses': totalExpenses,
      'number_of_transactions': numberOfTransactions,
      'average_transaction_amount': averageTransactionAmount,
    };
  }

  factory ExpensesSummaryModel.fromMap(Map<String, dynamic> map) {
    return ExpensesSummaryModel(
      totalExpenses: map['total_expenses'] as double,
      numberOfTransactions: map['number_of_transactions'] as int,
      averageTransactionAmount: map['average_transaction_amount'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpensesSummaryModel.fromJson(String source) =>
      ExpensesSummaryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ExpensesSummaryModel(total_expenses: $totalExpenses, number_of_transactions: $numberOfTransactions, average_transaction_amount: $averageTransactionAmount)';

  @override
  bool operator ==(covariant ExpensesSummaryModel other) {
    if (identical(this, other)) return true;

    return other.totalExpenses == totalExpenses &&
        other.numberOfTransactions == numberOfTransactions &&
        other.averageTransactionAmount == averageTransactionAmount;
  }

  @override
  int get hashCode =>
      totalExpenses.hashCode ^
      numberOfTransactions.hashCode ^
      averageTransactionAmount.hashCode;
}
