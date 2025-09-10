import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/deposit%20functions/prepare_deposit_data.dart';
import 'package:almonazim/data/data%20source/repo/deposit%20repo/deposit_repo.dart';
import 'package:almonazim/data/model/deposit%20models/deposit_input_model.dart';
import 'package:almonazim/data/model/deposit%20models/deposit_model.dart';
import 'package:dartz/dartz.dart';

class DepositRepoImpl implements DepositRepo {
  final ApiService apiService;
  DepositRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<DepositModel>>> getDeposits(
      DepositInputModel depositInputModel) async {
    final result = await apiService.post(
        url: AppLinks.getDepositsLink,
        formDataIsEnabled: false,
        data: depositInputModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<DepositModel> depositsLocale = [];
        for (final deposit in response["data"]) {
          depositsLocale.add(DepositModel.fromJson(deposit));
        }
        return right(depositsLocale);
      },
    );
  }

  @override
  Future<Either<Failure, void>> addDeposit(
      DepositInputModel depositInputModel) async {
    // print(prepareDepositData(depositInputModel));
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.addDepositLink,
        data: prepareDepositData(depositInputModel));

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
    // return right(null);
  }

  @override
  Future<Either<Failure, void>> deleteDeposit(
      DepositInputModel depositInputModel) async {
    // print(prepareDepositData(depositInputModel));
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.deleteDepositLink,
        data: depositInputModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
    // return right(null);
  }
}
