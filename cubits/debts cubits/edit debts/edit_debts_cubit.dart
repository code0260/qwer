import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/debts%20repo/debts_repo.dart';
import 'package:almonazim/data/model/debt%20models/edit_debt_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_debts_state.dart';

class EditDebtsCubit extends SafeCubit<EditDebtsState> {
  EditDebtsCubit(this.debtsRepo) : super(EditDebtsInitial());
  DebtsRepo debtsRepo;
  EditDebtModel editDebtModel = EditDebtModel();
  Future<void> editDebts() async {
    emit(EditDebtsLoading());
    var result = await debtsRepo.editDebts(editDebtModel);
    result.fold((failure) {
      emit(EditDebtsFailure(failure.errMessage));
    }, (_) {
      emit(EditDebtsSuccess());
    });
  }
}
