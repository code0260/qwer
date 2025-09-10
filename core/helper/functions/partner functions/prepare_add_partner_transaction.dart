import 'package:almonazim/core/formatters/formatter.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/partner%20models/add_partner_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareAddPartnerTransaction(AddPartnerModel addPartnerModel) {
  Map data = {};
  double partnersCapitalContribution = convertAmountToBase(
      addPartnerModel.partnerInputModel.partnersCapitalContribution!,
      addPartnerModel.partnerInputModel.partnersCapitalContributionCurrencyId!);
  // transaction
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription =
      "انضمَّ الشريك ${addPartnerModel.partnerInputModel.partnersName} ودَفَعَ مبلغ قدره ${Formatter.formatAmount(addPartnerModel.partnerInputModel.partnersCapitalContribution!, currencyId: addPartnerModel.partnerInputModel.partnersCapitalContributionCurrencyId)}";
  addPartnerModel.partnerInputModel.partnersCapitalContribution =
      partnersCapitalContribution;
  //$ Debit
  int accountsIdForCash = StoreAccounts.getAccountByCode('121000')!.accountsId!;
  var cashPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Debit",
    transactionLineAmount: partnersCapitalContribution,
    transactionLineAccountId: accountsIdForCash,
    transactionLineDescription: transactionsDescription,
  );
  //$ Credit
  int accountsIdForCapital =
      StoreAccounts.getAccountByCode('211000')!.accountsId!;
  var capitalPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Credit",
    transactionLineAmount: partnersCapitalContribution,
    transactionLineAccountId: accountsIdForCapital,
    transactionLineDescription: transactionsDescription,
  );

  lines.addAll([cashPart, capitalPart]);

  var addTransactionModel = AddTransactionModel(
      transactionModel: TransactionModel(
        transactionsCurrencyId: addPartnerModel
            .partnerInputModel.partnersCapitalContributionCurrencyId,
        transactionsDescription: transactionsDescription,
        transactionsTransactionDate: DateTime.now().toString(),
      ),
      lines: lines);
  data["transaction_data"] = addTransactionModel.toMap();
  data['partner_details'] = addPartnerModel.toMap();
  return data;
}
