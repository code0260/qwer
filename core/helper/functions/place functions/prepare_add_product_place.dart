import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/place%20models/product_place_details_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareAddProductPlace(
    ProductPlaceDetailsInputModel productPlaceDetailsInputModel) {
  Map data = {};
  data["product_place_details"] = productPlaceDetailsInputModel.toMap();

  // transaction
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription = "إضافة مكان وكمية منتج";
  //$ Credit
  int accountsIdForCapital =
      StoreAccounts.getAccountByCode('211000')!.accountsId!;
  var capitalPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Credit",
    transactionLineAccountId: accountsIdForCapital,
    transactionLineDescription: transactionsDescription,
  );
  //$ Debit
  int accountsIdForInventory =
      StoreAccounts.getAccountByCode('123000')!.accountsId!;
  var inventoryPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Debit",
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
