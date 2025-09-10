import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_categories_model.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_input_model.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_model.dart';
import 'package:almonazim/data/model/expenses%20models/get_expenses_model.dart';
import 'package:almonazim/data/model/expenses%20models/rent_prepaid_expense_input_model.dart';
import 'package:dartz/dartz.dart';

abstract class ExpensesRepo {
  //$ get
  Future<Either<Failure, List<ExpensesCategoriesModel>>>
      getExpensesCategories();
  Future<Either<Failure, GetExpensesModel>> getExpenses(
      ExpenseInputModel expensesInputModel);
  //$ add
  Future<Either<Failure, void>> addExpense(ExpenseInputModel expenseInputModel);
  Future<Either<Failure, void>> addRentPrepaidExpense(
      RentPrepaidExpenseInputModel rentPrepaidExpenseInputModel);
  Future<Either<Failure, void>> importRentPrepaidExpenses(String filePath);
  Future<Either<Failure, void>> importExpenses(String filePath);
  //$ delete
  Future<Either<Failure, void>> deleteExpense(
      ExpenseInputModel expensesInputModel);
  //$ edit
  Future<Either<Failure, void>> editExpenses(
      ExpenseInputModel expenseInputModel, ExpensesModel expensesModel);
}
