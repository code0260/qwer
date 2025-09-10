import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/debts%20repo/debts_repo.dart';
import 'package:almonazim/data/model/debt%20models/edit_debt_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_debt_currency_state.dart';

class EditDebtCurrencyCubit extends SafeCubit<EditDebtCurrencyState> {
  EditDebtCurrencyCubit(this.debtsRepo) : super(EditDebtCurrencyInitial());
  DebtsRepo debtsRepo;
  EditDebtModel editDebtModel = EditDebtModel();
  Future<void> editDebtCurrency() async {
    emit(EditDebtCurrencyLoading());
    var result = await debtsRepo.editDebtCurrency(editDebtModel);
    result.fold((failure) {
      emit(EditDebtCurrencyFailure(failure.errMessage));
    }, (_) {
      emit(EditDebtCurrencySuccess());
    });
  }
}
