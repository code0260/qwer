import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/formatters/formatter.dart';
import 'package:almonazim/core/helper/functions/partner%20functions/get_partner_id_by_name.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';
import 'package:almonazim/data/model/withdrawal%20models/withdrawal_input_model.dart';

Map prepareWithdrawalData(WithdrawalInputModel withdrawalInputModel) {
  Map data = {};
  data["withdrawal"] = withdrawalInputModel.toMap();
  // transaction
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription =
      "سحب مبلغ شخصي قدره  ${Formatter.formatAmount(withdrawalInputModel.withdrawalsCashAmount!, currencyId: withdrawalInputModel.withdrawalsAmountCurrencyId)} بواسطة ${withdrawalInputModel.partnerName}";
  double amount = withdrawalInputModel.withdrawalsAmountInBase ??
      withdrawalInputModel.withdrawalsCashAmount!;
  //$ Credit
  int accountsIdForCash = StoreAccounts.getAccountByCode('121000')!.accountsId!;
  var cashPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Credit",
    transactionLineAmount: amount,
    transactionLineAccountId: accountsIdForCash,
    transactionLineDescription: transactionsDescription,
  );
  //$ Debit
  int accountsIdForPartner =
      getPartnerIdByName(withdrawalInputModel.partnerName!, "1260");
  //$ debit
  var partnerPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Debit",
    transactionLineAmount: amount,
    transactionLineAccountId: accountsIdForPartner,
    transactionLinePartnerId: withdrawalInputModel.withdrawalsPartnerId,
    transactionLinePartnerType: TransactionLinePartnerType.partner.name,
    transactionLineDescription: transactionsDescription,
  );
  lines.addAll([cashPart, partnerPart]);

  var addTransactionModel = AddTransactionModel(
      transactionModel: TransactionModel(
        transactionsDescription: transactionsDescription,
        transactionsCurrencyId:
            withdrawalInputModel.withdrawalsAmountCurrencyId,
        transactionReferenceNumberType:
            TransactionReferenceNumberType.withdrawal.name,
        transactionsTransactionDate: DateTime.now().toString(),
      ),
      lines: lines);
  data["transaction_data"] = addTransactionModel.toMap();
  return data;
}
