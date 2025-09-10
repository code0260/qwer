import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/debts%20repo/debts_repo.dart';
import 'package:almonazim/data/model/debt%20models/edit_debt_model.dart';
import 'package:equatable/equatable.dart';

part 'resuscitate_debt_state.dart';

class ResuscitateDebtCubit extends SafeCubit<ResuscitateDebtState> {
  ResuscitateDebtCubit(this.debtsRepo) : super(ResuscitateDebtInitial());
  DebtsRepo debtsRepo;
  EditDebtModel editDebtModel = EditDebtModel();
  Future<void> resuscitateDebt() async {
    emit(ResuscitateDebtLoading());
    var result = await debtsRepo.resuscitateDebt(editDebtModel);
    result.fold((failure) {
      emit(ResuscitateDebtFailure(failure.errMessage));
    }, (_) {
      emit(ResuscitateDebtSuccess());
    });
  }
}
