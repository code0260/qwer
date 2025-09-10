// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:flutter/foundation.dart';

class TransactionLineCubit extends SafeCubit<TransactionLineState> {
  TransactionLineCubit()
      : super(TransactionLineState(lines: [], uniqueValue: 0));
  List<TransactionLineInputModel> lines = [];
  TransactionLineInputModel currentLine = TransactionLineInputModel();

  void addLine() {
    lines.add(currentLine);
    resetCurrentLine();
    emit(TransactionLineState(uniqueValue: lines.length, lines: lines));
  }

  void resetCurrentLine() {
    currentLine = TransactionLineInputModel();
  }

  void removeLine(int index) {
    lines.removeAt(index);
    emit(TransactionLineState(lines: lines, uniqueValue: lines.length));
  }

  void prepareEditLine(int index) {
    currentLine = lines[index];
  }

  void editLine(int index) {
    lines[index] = currentLine;
    emit(
        TransactionLineState(lines: lines, uniqueValue: Random().nextInt(200)));
  }

  double get difference {
    double differenceLocale = 0;
    for (final line in lines) {
      if (line.transactionLineDebitCredit == "Credit") {
        differenceLocale += line.transactionLineAmount ?? 0;
      } else {
        differenceLocale -= line.transactionLineAmount ?? 0;
      }
    }
    return differenceLocale;
  }

  String? get validateDataMessage {
    if (currentLine.transactionLineAccountId == null) {
      return "الرجاء اختيار الحساب";
    } else if (currentLine.transactionLineAmount == 0 ||
        currentLine.transactionLineAmount == null) {
      return "الرجاء إدخال قيمة القيد";
    }
    // else if (currentLine.transactionLineDescription == "") {
    //   return "الرجاء اختيار وصف القيد";
    // }
    else if (currentLine.transactionLineDebitCredit == null) {
      return "الرجاء اختيار طبيعة الحساب";
    } else {
      return null;
    }
  }
}

class TransactionLineState {
  final List<TransactionLineInputModel> lines;
  final int uniqueValue;

  TransactionLineState({required this.lines, required this.uniqueValue});

  @override
  bool operator ==(covariant TransactionLineState other) {
    if (identical(this, other)) return true;

    return listEquals(other.lines, lines) && other.uniqueValue == uniqueValue;
  }

  @override
  int get hashCode => lines.hashCode ^ uniqueValue.hashCode;
}
