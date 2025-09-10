import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/data/data%20source/repo/trial%20balance%20repo/trial_balance_repo.dart';
import 'package:almonazim/data/model/account%20models/account_input_model.dart';
import 'package:almonazim/data/model/account%20models/trial_balance_model.dart';
import 'package:dartz/dartz.dart';

class TrialBalanceRepoImpl implements TrialBalanceRepo {
  final ApiService apiService;
  TrialBalanceRepoImpl(this.apiService);

  @override
  Future<Either<Failure, double>> getAccountAmount(
      AccountInputModel accountInputModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.getAccountAmount,
        data: accountInputModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right((response["data"] as String).toDouble());
      },
    );
  }

  @override
  Future<Either<Failure, List<TrialBalanceModel>>> getMoreAccountsAmount(
      List<int> accountsId) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.getMoreAccountsAmount,
        data: {'accounts_id': accountsId});

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<TrialBalanceModel> accounts = [];
        for (final account in response["data"]) {
          accounts.add(TrialBalanceModel.fromJson(account));
        }
        return right(accounts);
      },
    );
  }
}
