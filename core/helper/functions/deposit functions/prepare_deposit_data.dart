import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/formatters/formatter.dart';
import 'package:almonazim/core/helper/functions/partner%20functions/get_partner_id_by_name.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/deposit%20models/deposit_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareDepositData(DepositInputModel depositInputModel) {
  Map data = {};
  data["deposit"] = depositInputModel.toMap();
  // transaction
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription =
      "إيداع مبلغ قدره  ${Formatter.formatAmount(depositInputModel.depositsCashAmount!, currencyId: depositInputModel.depositsAmountCurrencyId)} بواسطة ${depositInputModel.partnerName}";
  double amount = depositInputModel.depositsAmountInBase ??
      depositInputModel.depositsCashAmount!;
  //$ Debit
  int accountsIdForCash = StoreAccounts.getAccountByCode('121000')!.accountsId!;
  var cashPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Debit",
    transactionLineAmount: amount,
    transactionLineAccountId: accountsIdForCash,
    transactionLineDescription: transactionsDescription,
  );
  //$ Credit
  int accountsIdForPartner =
      getPartnerIdByName(depositInputModel.partnerName!, "2340");
  var partnerPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Credit",
    transactionLineAmount: amount,
    transactionLineAccountId: accountsIdForPartner,
    transactionLinePartnerId: depositInputModel.depositsPartnerId,
    transactionLinePartnerType: TransactionLinePartnerType.partner.name,
    transactionLineDescription: transactionsDescription,
  );
  lines.addAll([cashPart, partnerPart]);

  var addTransactionModel = AddTransactionModel(
      transactionModel: TransactionModel(
        transactionsDescription: transactionsDescription,
        transactionsCurrencyId: depositInputModel.depositsAmountCurrencyId,
        transactionReferenceNumberType:
            TransactionReferenceNumberType.deposit.name,
        transactionsTransactionDate: DateTime.now().toString(),
      ),
      lines: lines);
  data["transaction_data"] = addTransactionModel.toMap();
  return data;
}
