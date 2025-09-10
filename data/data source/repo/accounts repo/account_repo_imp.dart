import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/account%20functions/prepare_account_balance.dart';
import 'package:almonazim/core/helper/functions/account%20functions/prepare_tree_node.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/data%20source/repo/accounts%20repo/account_repo.dart';
import 'package:almonazim/data/model/account%20models/account_input_model.dart';
import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:dartz/dartz.dart';

class AccountRepoImpl implements AccountRepo {
  final ApiService apiService;
  AccountRepoImpl(this.apiService);

  @override
  Future<Either<Failure, TreeNode>> getAllAccounts() async {
    final result = await apiService.get(
      url: AppLinks.getAllAccountsLink,
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        TreeNode treeNode = TreeNode.root();
        StoreAccounts.setAccounts(response["data"]);
        prepareTreeNode(response["data"], treeNode);
        return right(treeNode);
      },
    );
  }

  @override
  Future<Either<Failure, TreeNode>> getAccountAmounts() async {
    final result = await apiService.get(url: AppLinks.getAccountAmountsLink);

    return result.fold(
      (failure) => left(failure),
      (response) async {
        TreeNode treeNode = TreeNode.root();
        List<dynamic> accountsMap = StoreAccounts.getAccountsMap()!;
        assignNewBalances(response, accountsMap);
        prepareTotalAccountBalance(accountsMap);
        await StoreAccounts.setAccounts(accountsMap);
        prepareTreeNode(accountsMap, treeNode);
        return right(treeNode);
      },
    );
  }

  @override
  Future<Either<Failure, void>> addAccount(
      AccountInputModel accountInputModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.addOneAccountLink,
        data: accountInputModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<dynamic> accounts = StoreAccounts.getAccountsMap()!;
        accounts.add(response["data"][0]);
        StoreAccounts.setAccounts(accounts);
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> editAccount(
      AccountInputModel accountInputModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.editAccountLink,
        data: accountInputModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<dynamic> accounts = StoreAccounts.getAccountsMap()!;
        // remove
        accounts.removeWhere((element) =>
            element['accounts_id'] == accountInputModel.accountsId);
        // then add
        accounts.add(response["data"][0]);
        StoreAccounts.setAccounts(accounts);
        return right(null);
      },
    );
  }
}
