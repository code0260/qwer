import 'dart:convert';

import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/prepare%20edit%20debt/add%20payment/prepare_debt_payment.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/prepare%20edit%20debt/add%20payment/prepare_payments.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/prepare%20edit%20debt/cancel%20payment/prepare_cancel_debt_payment.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/debt%20payment%20repo/debt_payment_repo.dart';
import 'package:almonazim/data/model/debt%20models/add_payments_model.dart';
import 'package:almonazim/data/model/debt%20models/debt_model.dart';
import 'package:almonazim/data/model/debt%20models/debt_payment_input_model.dart';
import 'package:almonazim/data/model/debt%20models/get_debt_payment_model.dart';
import 'package:almonazim/data/model/filter_model.dart';
import 'package:dartz/dartz.dart';

class DebtPaymentRepoImpl implements DebtPaymentRepo {
  final ApiService apiService;
  DebtPaymentRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<GetDebtPaymentModel>>> getDebtPayments(
      FilterModel filterModel) async {
    final result = await apiService.post(
      url: AppLinks.getDebtPaymentsLink,
      formDataIsEnabled: false,
      data: filterModel.toServer(),
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<GetDebtPaymentModel> debtsLocale = [];
        for (final debt in response["data"]) {
          debtsLocale.add(GetDebtPaymentModel.fromJson(debt));
        }

        return right(debtsLocale);
      },
    );
  }

  @override
  Future<Either<Failure, void>> addDebtPayment(
      DebtPaymentInputModel debtPaymentInputModel, DebtModel debtModel) async {
    // print(prepareDebtPayment(debtPaymentInputModel, debtModel));
    final result = await apiService.post(
        url: AppLinks.addPaymentDebtLink,
        data: prepareDebtPayment(debtPaymentInputModel, debtModel),
        formDataIsEnabled: false);

    return result.fold(
      (failure) => left(failure),
      (response) {
        debts.clear();
        return right(null);
      },
    );
    // return left(ServerFailure('errMessage'));
  }

  @override
  Future<Either<Failure, void>> addPayments(
      AddPaymentsModel addPaymentsModel) async {
    // print(prepareDebtPayment(debtPaymentInputModel, debtModel));
    final result = await apiService.post(
        url: AppLinks.addPaymentsLink,
        data: jsonEncode(preparePayments(addPaymentsModel)),
        formDataIsEnabled: false);

    return result.fold(
      (failure) => left(failure),
      (response) {
        debts.clear();
        return right(null);
      },
    );
    // return left(ServerFailure('errMessage'));
  }

  @override
  Future<Either<Failure, void>> cancelDebtPayment(
      DebtPaymentInputModel debtPaymentInputModel, DebtModel debtModel) async {
    // print(prepareCancelDebtPayment(debtPaymentInputModel, debtModel));
    final result = await apiService.post(
        url: AppLinks.cancelPaymentDebtLink,
        data: prepareCancelDebtPayment(debtPaymentInputModel, debtModel),
        formDataIsEnabled: false);

    return result.fold(
      (failure) => left(failure),
      (response) {
        debts.clear();
        return right(null);
      },
    );
    // return right(null);
  }
}
