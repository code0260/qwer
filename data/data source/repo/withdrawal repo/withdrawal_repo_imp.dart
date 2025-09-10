import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/withdrawal%20functions/prepare_withdrawal_data.dart';
import 'package:almonazim/data/data%20source/repo/withdrawal%20repo/withdrawal_repo.dart';
import 'package:almonazim/data/model/withdrawal%20models/withdrawal_input_model.dart';
import 'package:almonazim/data/model/withdrawal%20models/withdrawal_model.dart';
import 'package:dartz/dartz.dart';

class WithdrawalRepoImpl implements WithdrawalRepo {
  final ApiService apiService;
  WithdrawalRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<WithdrawalModel>>> getWithdrawals(
      WithdrawalInputModel withdrawalInputModel) async {
    final result = await apiService.post(
        url: AppLinks.getWithdrawalsLink,
        formDataIsEnabled: false,
        data: withdrawalInputModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<WithdrawalModel> withdrawalsLocale = [];
        for (final withdrawal in response["data"]) {
          withdrawalsLocale.add(WithdrawalModel.fromJson(withdrawal));
        }
        return right(withdrawalsLocale);
      },
    );
  }

  @override
  Future<Either<Failure, void>> addWithdrawal(
      WithdrawalInputModel withdrawalInputModel) async {
    // print(prepareWithdrawalData(withdrawalInputModel));
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.addWithdrawalLink,
        data: prepareWithdrawalData(withdrawalInputModel));

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
    // return right(null);
  }

  @override
  Future<Either<Failure, void>> deleteWithdrawal(
      WithdrawalInputModel withdrawalInputModel) async {
    // print(prepareWithdrawalData(withdrawalInputModel));
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.deleteWithdrawalLink,
        data: withdrawalInputModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
    // return right(null);
  }
}
