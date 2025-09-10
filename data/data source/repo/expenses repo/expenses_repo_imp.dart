import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/expense%20functions/prepare_edit_expense_data.dart';
import 'package:almonazim/core/helper/functions/expense%20functions/prepare_expense_data.dart';
import 'package:almonazim/core/helper/functions/expense%20functions/prepare_rent_prepaid_expense_data.dart';
import 'package:almonazim/data/data%20source/locale/store_insert_date_steps.dart';
import 'package:almonazim/data/data%20source/repo/expenses%20repo/expenses_repo.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_categories_model.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_input_model.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_model.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_summary_model.dart';
import 'package:almonazim/data/model/expenses%20models/get_expenses_model.dart';
import 'package:almonazim/data/model/expenses%20models/rent_prepaid_expense_input_model.dart';
import 'package:dartz/dartz.dart';

class ExpensesRepoImpl implements ExpensesRepo {
  final ApiService apiService;
  ExpensesRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<ExpensesCategoriesModel>>>
      getExpensesCategories() async {
    final result =
        await apiService.get(url: AppLinks.getExpensesCategoriesLink);

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<ExpensesCategoriesModel> expensesCategories = [];
        for (final category in response["data"]) {
          expensesCategories.add(ExpensesCategoriesModel.fromJson(category));
        }
        return right(expensesCategories);
      },
    );
  }

  @override
  Future<Either<Failure, GetExpensesModel>> getExpenses(
      ExpenseInputModel expensesInputModel) async {
    final result = await apiService.post(
        url: AppLinks.getExpensesLink,
        formDataIsEnabled: false,
        data: expensesInputModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<ExpensesModel> expenses = [];
        for (final expense in response["data"]) {
          expenses.add(ExpensesModel.fromJson(expense));
        }
        GetExpensesModel expensesModel = GetExpensesModel(
            expenses: expenses,
            expensesSummaryModel: getExpensesSummaryModel(expenses));
        return right(expensesModel);
      },
    );
  }

  @override
  Future<Either<Failure, void>> editExpenses(
      ExpenseInputModel expenseInputModel, ExpensesModel expensesModel) async {
    // print(prepareEditExpenseData(expenseInputModel, expensesModel));
    final result = await apiService.post(
        url: AppLinks.editExpenseLink,
        data: prepareEditExpenseData(expenseInputModel, expensesModel),
        formDataIsEnabled: false);

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
    // return left(ServerFailure('testing'));
  }

  ExpensesSummaryModel getExpensesSummaryModel(List<ExpensesModel> expenses) {
    double totalExpenses = 0;
    for (final expense in expenses) {
      totalExpenses += expense.expensesAmountInBase ?? expense.expensesAmount!;
    }
    ExpensesSummaryModel expensesSummaryModel = ExpensesSummaryModel(
        totalExpenses: totalExpenses,
        numberOfTransactions: expenses.length,
        averageTransactionAmount: totalExpenses / expenses.length);

    return expensesSummaryModel;
  }

  @override
  Future<Either<Failure, void>> deleteExpense(
      ExpenseInputModel expensesInputModel) async {
    final result = await apiService.delete(
        url: AppLinks.deleteExpenseLink,
        formDataIsEnabled: false,
        data: expensesInputModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) => right(null),
    );
  }

  @override
  Future<Either<Failure, void>> addExpense(
      ExpenseInputModel expenseInputModel) async {
    // print(prepareExpenseData(expenseInputModel));
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.addExpenseLink,
        data: prepareExpenseData(expenseInputModel));

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
    // return right(null);
  }

  @override
  Future<Either<Failure, void>> addRentPrepaidExpense(
      RentPrepaidExpenseInputModel rentPrepaidExpenseInputModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.addRentPrepaidExpenseLink,
        data: prepareRentPrepaidExpenseData(rentPrepaidExpenseInputModel));

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> importRentPrepaidExpenses(
      String filePath) async {
    final result = await apiService.uploadFile(
        url: AppLinks.importRentPrepaidExpenseLink,
        requestName: "rent_prepaid_expenses_excel_file",
        filePath: filePath);

    return result.fold(
      (failure) => left(failure),
      (response) {
        StoreInsertDateSteps.addStep("8");
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> importExpenses(String filePath) async {
    final result = await apiService.uploadFile(
        url: AppLinks.importExpenseLink,
        requestName: "expenses_excel_file",
        filePath: filePath);

    return result.fold(
      (failure) => left(failure),
      (response) {
        StoreInsertDateSteps.addStep("9");
        return right(null);
      },
    );
  }
}
