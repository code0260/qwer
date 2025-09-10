import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/debts%20repo/debts_repo.dart';
import 'package:almonazim/data/model/debt%20models/edit_debt_model.dart';
import 'package:equatable/equatable.dart';

part 'kill_debt_state.dart';

class KillDebtCubit extends SafeCubit<KillDebtState> {
  KillDebtCubit(this.debtsRepo) : super(KillDebtInitial());
  DebtsRepo debtsRepo;
  EditDebtModel editDebtModel =
      EditDebtModel(paymentState: DebtState.dead.name);
  Future<void> killDebt() async {
    emit(KillDebtLoading());
    var result = await debtsRepo.killDebt(editDebtModel);
    result.fold((failure) {
      emit(KillDebtFailure(failure.errMessage));
    }, (_) {
      emit(KillDebtSuccess());
    });
  }
}
