import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/cash%20functions/add%20cash/prepare_add_initial_cash.dart';
import 'package:almonazim/core/helper/functions/cash%20functions/add%20cash/prepare_transfer_cash.dart';
import 'package:almonazim/core/helper/functions/cash%20functions/edit%20cash/prepare_edit_cash.dart';
import 'package:almonazim/data/data%20source/locale/store_insert_date_steps.dart';
import 'package:almonazim/data/data%20source/repo/cash%20repo/cash_repo.dart';
import 'package:almonazim/data/model/cash%20models/cash_input_model.dart';
import 'package:almonazim/data/model/cash%20models/edit_cash_model.dart';
import 'package:almonazim/data/model/cash%20models/get_all_cash_model.dart';
import 'package:almonazim/data/model/cash%20models/transfer_model.dart';
import 'package:dartz/dartz.dart';

class CashRepoImpl implements CashRepo {
  final ApiService apiService;
  CashRepoImpl(this.apiService);

  @override
  Future<Either<Failure, void>> addCash(List<CashInputModel> cashModels) async {
    // print(prepareAddInitialCash(cashModels));
    final result = await apiService.post(
      url: AppLinks.addCashLink,
      formDataIsEnabled: false,
      data: prepareAddInitialCash(cashModels),
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        StoreInsertDateSteps.addStep("1");
        return right(null);
      },
    );
    // return left(ServerFailure('error'));
  }

  @override
  Future<Either<Failure, GetAllCashModel>> getCash(
      CashInputModel cashInputModel) async {
    final result = await apiService.post(
        url: AppLinks.getCashLink,
        data: cashInputModel.toMap(),
        formDataIsEnabled: false);

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(GetAllCashModel.fromJson(response['data']));
      },
    );
  }

  @override
  Future<Either<Failure, void>> editCash(EditCashModel editCashModel) async {
    final result = await apiService.post(
      url: AppLinks.editCashLink,
      formDataIsEnabled: false,
      data: prepareEditCash(editCashModel),
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> transferCash(
      TransferModel transferModel) async {
    // print(prepareTransferCash(transferModel));
    final result = await apiService.post(
        url: AppLinks.transferCashLink,
        formDataIsEnabled: false,
        data: prepareTransferCash(transferModel));

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
    // return left(ServerFailure("dd"));
  }
}
