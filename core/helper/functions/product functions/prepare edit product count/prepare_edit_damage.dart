import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_input_model.dart';
import 'package:almonazim/data/model/product%20place%20models/edit_product_count_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareEditDamage(EditProductCountModel editProductCountModel) {
  Map data = {};
  data["product_place_details"] = editProductCountModel.toMap();

  //& transaction
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription = "تعديل كمية منتج بسبب تلف";
  //$ Credit
  int accountsIdForDamageExpense =
      StoreAccounts.getAccountByCode('329001')!.accountsId!;
  var capitalPart = TransactionLineInputModel(
    transactionLineDebitCredit: 'Debit',
    transactionLineAccountId: accountsIdForDamageExpense,
    transactionLineDescription: transactionsDescription,
  );
  //$ Debit
  int accountsIdForInventory =
      StoreAccounts.getAccountByCode('123000')!.accountsId!;
  var inventoryPart = TransactionLineInputModel(
    transactionLineDebitCredit: 'Credit',
    transactionLineAccountId: accountsIdForInventory,
    transactionLineDescription: transactionsDescription,
  );
  lines.addAll([capitalPart, inventoryPart]);

  var addTransactionModel = AddTransactionModel(
      transactionModel: TransactionModel(
        transactionsDescription: transactionsDescription,
        transactionsTransactionDate: DateTime.now().toString(),
      ),
      lines: lines);
  data["transaction_data"] = addTransactionModel.toMap();

  //& expense
  data['expense'] = ExpenseInputModel(
    expensesName: 'تلف بضاعة',
    expensesAccountId: accountsIdForDamageExpense,
  ).toMap();

  return data;
}
