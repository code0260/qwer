// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';
import 'package:flutter/foundation.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';

class AddTransactionModel {
  TransactionModel transactionModel;
  List<TransactionLineInputModel> lines;
  AddTransactionModel({
    required this.transactionModel,
    required this.lines,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transaction': transactionModel.toJson(),
      'transaction_lines': lines.map((x) => x.toMap()).toList(),
    };
  }

  factory AddTransactionModel.fromMap(Map<String, dynamic> map) {
    return AddTransactionModel(
      transactionModel:
          TransactionModel.fromJson(map['transaction'] as Map<String, dynamic>),
      lines: List<TransactionLineInputModel>.from(
        (map['transaction_lines'] as List<int>).map<TransactionLineInputModel>(
          (x) => TransactionLineInputModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddTransactionModel.fromJson(String source) =>
      AddTransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AddTransactionModel(TransactionModel: $transactionModel, lines: $lines)';

  @override
  bool operator ==(covariant AddTransactionModel other) {
    if (identical(this, other)) return true;

    return other.transactionModel == transactionModel &&
        listEquals(other.lines, lines);
  }

  @override
  int get hashCode => transactionModel.hashCode ^ lines.hashCode;
}
