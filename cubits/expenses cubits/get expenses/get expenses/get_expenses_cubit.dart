import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/expenses%20repo/expenses_repo.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_input_model.dart';
import 'package:almonazim/data/model/expenses%20models/get_expenses_model.dart';
import 'package:equatable/equatable.dart';

part 'get_expenses_state.dart';

class GetExpensesCubit extends SafeCubit<GetExpensesState> {
  GetExpensesCubit(this.expensesRepo) : super(GetExpensesInitial());
  ExpensesRepo expensesRepo;
  ExpenseInputModel expensesInputModel = ExpenseInputModel(
    startDate: DateTime.now().subtract(const Duration(days: 1 * 30)),
    endDate: DateTime.now(),
  );

  Future<void> getExpenses() async {
    emit(GetExpensesLoading());
    var result = await expensesRepo.getExpenses(expensesInputModel);
    result.fold((failure) {
      emit(GetExpensesFailure(failure.errMessage));
    }, (expensesModel) {
      emit(GetExpensesSuccess(getExpensesModel: expensesModel));
    });
  }
}
