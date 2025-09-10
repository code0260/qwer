import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/debts%20repo/debts_repo.dart';
import 'package:almonazim/data/model/debt%20models/edit_debt_model.dart';
import 'package:equatable/equatable.dart';

part 'un_forgive_debt_state.dart';

class UnForgiveDebtCubit extends SafeCubit<UnForgiveDebtState> {
  UnForgiveDebtCubit(this.debtsRepo) : super(UnForgiveDebtInitial());
  DebtsRepo debtsRepo;
  EditDebtModel editDebtModel = EditDebtModel();
  Future<void> unForgiveDebt() async {
    emit(UnForgiveDebtLoading());
    var result = await debtsRepo.unForgiveDebt(editDebtModel);
    result.fold((failure) {
      emit(UnForgiveDebtFailure(failure.errMessage));
    }, (_) {
      emit(UnForgiveDebtSuccess());
    });
  }
}
