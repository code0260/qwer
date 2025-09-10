import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/rent%20repo/rent_repo.dart';
import 'package:almonazim/data/model/expenses%20models/rent_prepaid_expense_input_model.dart';
import 'package:almonazim/data/model/expenses%20models/rent_prepaid_expense_model.dart';
import 'package:equatable/equatable.dart';

part 'get_rent_prepaid_expenses_state.dart';

class GetExpenseRentsCubit extends SafeCubit<GetExpenseRentsState> {
  GetExpenseRentsCubit(this.rentRepo) : super(GetExpenseRentsInitial());
  RentRepo rentRepo;
  RentPrepaidExpenseInputModel rentPrepaidExpenseInputModel =
      RentPrepaidExpenseInputModel(
          rentPrepaidExpensesStartDate: DateTime.now().toString(),
          rentPrepaidExpensesEndDate:
              DateTime.now().add(const Duration(days: 30 * 2)).toString());
  Future<void> getRents() async {
    emit(GetExpenseRentsLoading());
    var result = await rentRepo.getExpenseRents(rentPrepaidExpenseInputModel);
    result.fold((failure) {
      emit(GetExpenseRentsFailure(failure.errMessage));
    }, (employees) {
      emit(GetExpenseRentsSuccess(rents: employees));
    });
  }
}
