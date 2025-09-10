// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/data/model/debt%20models/debt_model.dart';

class AddPaymentsModel {
  double? paymentsAmount;
  int? paymentsAmountCurrencyId;
  String? notes;
  String? date;
  double? paymentsAmountInBase;
  List<DebtModel> debts;
  double total;
  int? clientId;
  AddPaymentsModel({
    this.paymentsAmount,
    this.total = 0,
    this.date,
    this.clientId,
    this.notes,
    this.paymentsAmountCurrencyId,
    this.paymentsAmountInBase,
    required this.debts,
  });
}
