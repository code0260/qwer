import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/forgive%20debt/prepare_forgive_debt.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/prepare%20add%20debt/prepare_add_debt.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/prepare%20kill%20debt/prepare_kill_debt.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/prepare%20resuscitate%20debt/prepare_resuscitate_debt.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/un%20forgive%20debt/prepare_un_forgive_debt.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_insert_date_steps.dart';
import 'package:almonazim/data/data%20source/repo/debts%20repo/debts_repo.dart';
import 'package:almonazim/data/model/debt%20models/debt_input_model.dart';
import 'package:almonazim/data/model/debt%20models/debt_model.dart';
import 'package:almonazim/data/model/debt%20models/edit_debt_model.dart';
import 'package:almonazim/data/model/filter_model.dart';
import 'package:dartz/dartz.dart';

class DebtsRepoImpl implements DebtsRepo {
  final ApiService apiService;
  DebtsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<DebtModel>>> getDebts(
      FilterModel filterModel) async {
    if (!debts.containsKey(filterModel)) {
      final result = await apiService.post(
        url: AppLinks.getDebtsLink,
        formDataIsEnabled: false,
        data: filterModel.toServer(),
      );

      return result.fold(
        (failure) => left(failure),
        (response) {
          if (debts.length > 10) {
            debts.clear();
          }
          List<DebtModel> debtsLocale = [];
          for (final debt in response["data"]) {
            debtsLocale.add(DebtModel.fromJson(debt));
          }
          debts[filterModel] = debtsLocale;
          return right(debts[filterModel]!);
        },
      );
    }
    return right(debts[filterModel]!);
  }

  @override
  Future<Either<Failure, void>> importDebts(String filePath) async {
    final result = await apiService.uploadFile(
        url: AppLinks.importDebtsLink,
        requestName: "debts_excel_file",
        filePath: filePath);

    return result.fold(
      (failure) => left(failure),
      (response) {
        StoreInsertDateSteps.addStep("15");
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, List<DebtModel>>> refreshDebts(
      FilterModel filterModel) async {
    debts.clear();
    final result = await apiService.post(
      url: AppLinks.getDebtsLink,
      formDataIsEnabled: false,
      data: filterModel.toServer(),
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<DebtModel> debtsLocale = [];
        for (final debt in response["data"]) {
          debtsLocale.add(DebtModel.fromJson(debt));
        }
        debts[filterModel] = debtsLocale;
        return right(debts[filterModel]!);
      },
    );
  }

  @override
  Future<Either<Failure, void>> editDebts(EditDebtModel editDebtModel) async {
    // print(editDebtModel.toMap());
    final result = await apiService.post(
        url: AppLinks.editDebtsLink,
        data: editDebtModel.toMap(),
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

  @override
  Future<Either<Failure, void>> editDebtCurrency(
      EditDebtModel editDebtModel) async {
    final result = await apiService.post(
        url: AppLinks.editDebtCurrencyLink,
        data: editDebtModel.toMap(),
        formDataIsEnabled: false);

    return result.fold(
      (failure) => left(failure),
      (response) {
        debts.clear();
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> addDebt(DebtInputModel debtInputModel) async {
    // print(prepareAddDebt(debtInputModel));
    final result = await apiService.post(
        url: AppLinks.addDebtLink,
        data: prepareAddDebt(debtInputModel),
        formDataIsEnabled: false);

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
    // return left(ServerFailure('errMessage'));
  }

  @override
  Future<Either<Failure, void>> killDebt(EditDebtModel editDebtModel) async {
    // print(prepareKillDebt(editDebtModel));
    final result = await apiService.post(
        url: AppLinks.killDebtLink,
        data: prepareKillDebt(editDebtModel),
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

  @override
  Future<Either<Failure, void>> resuscitateDebt(
      EditDebtModel editDebtModel) async {
    // print(prepareResuscitateDebt(editDebtModel));
    final result = await apiService.post(
        url: AppLinks.resuscitateDebtLink,
        data: prepareResuscitateDebt(editDebtModel),
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

  @override
  Future<Either<Failure, void>> forgiveDebt(EditDebtModel editDebtModel) async {
    // print(prepareKillDebt(editDebtModel));
    final result = await apiService.post(
        url: AppLinks.forgiveDebtLink,
        data: prepareForgiveDebt(editDebtModel),
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

  @override
  Future<Either<Failure, void>> unForgiveDebt(
      EditDebtModel editDebtModel) async {
    // print(prepareKillDebt(editDebtModel));
    final result = await apiService.post(
        url: AppLinks.unForgiveDebtLink,
        data: prepareUnForgiveDebt(editDebtModel),
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

  // no useful at all, but it is just for practice
  String oneMonthAfterNow() {
    String currentDate = DateTime.now().toString();
    int followingMonth = DateTime.now().month + 1;
    String replacement = "";
    if (followingMonth > 12) {
      int year = DateTime.now().year;
      followingMonth = 1;
      year++;
      return currentDate.replaceRange(0, 7, "$year-0$followingMonth");
    } else if (followingMonth < 10) {
      replacement = "0$followingMonth";
    } else {
      replacement = "$followingMonth";
    }
    return currentDate.replaceRange(5, 7, replacement);
  }
}
// void editDebtLocally(int debtsId, DateTime? dueDate, double? paidAmount,
//     String? paymentState) {
//   debts.forEach(
//     (filterModel, listDebts) {
//       int index =
//           listDebts.indexWhere((debtModel) => debtModel.debtsId == debtsId);
//       DebtModel newDebtModel = listDebts[index].copyWith(
//           debtsDueDate: dueDate == null
//               ? listDebts[index].debtsDueDate
//               : dueDate.toString(),
//           debtsPaidAmount:
//               paidAmount ?? listDebts[index].debtsPaidAmount!.toDouble(),
//           debtsState: paymentState ?? listDebts[index].debtsState,
//           debtsUpdatedAt: DateTime.now().toString());
//       listDebts[index] = newDebtModel;
//       filterModel.isCompletedDebt;
//     },
//   );
// }
