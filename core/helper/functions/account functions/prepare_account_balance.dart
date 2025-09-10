import 'package:almonazim/data/model/account%20models/account_model.dart';

void prepareTotalAccountBalance(List<dynamic> accountsMap) {
  for (final a in accountsMap) {
    AccountModel accountModel = AccountModel.fromJson(a);

    if (accountModel.accountsIsSub == 0) {
      double totalAccountBalance = 0;
      for (final aForBalance in accountsMap) {
        AccountModel accountForBalance = AccountModel.fromJson(aForBalance);
        if (accountForBalance.accountsIsSub == 1 &&
            accountForBalance.accountsCode!
                .startsWith(accountModel.accountsCode!)) {
          if (accountModel.accountsNature == accountForBalance.accountsNature) {
            totalAccountBalance += accountForBalance.accountsBalance!;
          } else {
            totalAccountBalance -= accountForBalance.accountsBalance!;
          }
        }
      }
      int index = accountsMap.indexWhere(
          (element) => element['accounts_code'] == accountModel.accountsCode);
      accountsMap[index] =
          accountModel.copyWith(accountsBalance: totalAccountBalance).toJson();
    }
  }
}

void assignNewBalances(response, List<dynamic> accountsMap) {
  for (final item in response["data"]) {
    for (final account in accountsMap) {
      if (item['accounts_code'] == account['accounts_code']) {
        account['trial_balance_current'] = item['trial_balance_current'];
      }
    }
  }
}
