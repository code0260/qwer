import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/account%20models/account_model.dart';

int getPartnerIdByName(String partnerName, String accountsStartWithCode) {
  int accountsIdForPartner = 0;
  List<AccountModel> accounts =
      StoreAccounts.getAccountsStartWithCode(accountsStartWithCode)!;
  for (final account in accounts) {
    if (account.accountsName!.contains(partnerName)) {
      accountsIdForPartner = account.accountsId!;
      break;
    }
  }
  return accountsIdForPartner;
}
