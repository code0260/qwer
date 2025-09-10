import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_input_model.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';

TransactionLineInputModel? prepareTransactionLineForExchange(
    double exchangeAmount,
    String transactionsDescription,
    Map<dynamic, dynamic> data) {
  int baseCurrencyId = currencies
      .firstWhere((element) => element.businessCurrencyIsBase == 1)
      .businessCurrencyId!;
  if (exchangeAmount > 0) {
    int accountsIdForGainExchange =
        StoreAccounts.getAccountByCode('421003')!.accountsId!;
    var gainExchangePart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: exchangeAmount,
      transactionLineAccountId: accountsIdForGainExchange,
      transactionLineDescription: transactionsDescription,
    );
    //& revenue
    data['revenue_exchange'] = RevenueInputModel(
      revenuesName: 'تغير سعر الصرف',
      revenuesAmount: exchangeAmount,
      revenuesAccountId: accountsIdForGainExchange,
      revenuesAmountCurrencyId: baseCurrencyId,
    ).toMap();
    return gainExchangePart;
  } else if (exchangeAmount < 0) {
    int accountsIdForLossExchange =
        StoreAccounts.getAccountByCode('341000')!.accountsId!;
    var lossExchangePart = TransactionLineInputModel(
      transactionLineDebitCredit: "Debit",
      transactionLineAmount: exchangeAmount.abs(),
      transactionLineAccountId: accountsIdForLossExchange,
      transactionLineDescription: transactionsDescription,
    );
    //& expense
    data['expense_exchange'] = ExpenseInputModel(
      expensesName: 'تغير سعر الصرف',
      expensesAmount: exchangeAmount.abs(),
      expensesAmountCurrencyId: baseCurrencyId,
      expensesAccountId: accountsIdForLossExchange,
    ).toMap();
    return lossExchangePart;
  }
  return null;
}
