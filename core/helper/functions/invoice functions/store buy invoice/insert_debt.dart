// Function to insert a debt into the database
import 'package:almonazim/data/model/debt%20models/debt_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> insertDebt(Transaction txn, DebtModel debtModel) async {
  var debtResult = await txn.insert("debts", debtModel.toMap());
  if (debtResult == 0) throw Exception("خطأ في إدخال الدين");
}
