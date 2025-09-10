import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/data/data%20source/repo/accounts%20repo/account_repo_imp.dart';

void getAllAccounts() async {
  await getIt.get<AccountRepoImpl>().getAllAccounts();
}
