import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/debts%20repo/debts_repo.dart';
import 'package:almonazim/data/model/debt%20models/edit_debt_model.dart';
import 'package:equatable/equatable.dart';

part 'forgive_debt_state.dart';

class ForgiveDebtCubit extends SafeCubit<ForgiveDebtState> {
  ForgiveDebtCubit(this.debtsRepo) : super(ForgiveDebtInitial());
  DebtsRepo debtsRepo;
  EditDebtModel editDebtModel =
      EditDebtModel(paymentState: DebtState.forgiven.name);
  Future<void> forgiveDebt() async {
    emit(ForgiveDebtLoading());
    var result = await debtsRepo.forgiveDebt(editDebtModel);
    result.fold((failure) {
      emit(ForgiveDebtFailure(failure.errMessage));
    }, (_) {
      emit(ForgiveDebtSuccess());
    });
  }
}
