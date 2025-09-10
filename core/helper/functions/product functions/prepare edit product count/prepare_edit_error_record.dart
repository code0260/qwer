import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/product%20place%20models/edit_product_count_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareEditErrorRecord(EditProductCountModel editProductCountModel) {
  Map data = {};
  data["product_place_details"] = editProductCountModel.toMap();

  // transaction
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription = "تعديل كمية منتج بسبب خطأ تسجيل";
  //$ Credit
  int accountsIdForCapital =
      StoreAccounts.getAccountByCode('211000')!.accountsId!;
  var capitalPart = TransactionLineInputModel(
    transactionLineDebitCredit:
        editProductCountModel.isBiggerThanOriginal! ? "Credit" : 'Debit',
    transactionLineAccountId: accountsIdForCapital,
    transactionLineDescription: transactionsDescription,
  );
  //$ Debit
  int accountsIdForInventory =
      StoreAccounts.getAccountByCode('123000')!.accountsId!;
  var inventoryPart = TransactionLineInputModel(
    transactionLineDebitCredit:
        editProductCountModel.isBiggerThanOriginal! ? "Debit" : 'Credit',
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

  return data;
}
