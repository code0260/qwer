import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/withdrawal%20repo/withdrawal_repo.dart';
import 'package:almonazim/data/model/withdrawal%20models/withdrawal_input_model.dart';
import 'package:almonazim/data/model/withdrawal%20models/withdrawal_model.dart';
import 'package:equatable/equatable.dart';

part 'get_withdrawals_state.dart';

class GetWithdrawalsCubit extends SafeCubit<GetWithdrawalsState> {
  GetWithdrawalsCubit(this.withdrawalRepo) : super(GetWithdrawalsInitial());
  WithdrawalRepo withdrawalRepo;
  WithdrawalInputModel withdrawalInputModel = WithdrawalInputModel(
      startDate: DateTime.now().subtract(const Duration(days: 30)),
      endDate: DateTime.now());

  Future<void> getWithdrawals() async {
    emit(GetWithdrawalsLoading());
    var result = await withdrawalRepo.getWithdrawals(withdrawalInputModel);
    result.fold((failure) {
      emit(GetWithdrawalsFailure(failure.errMessage));
    }, (withdrawals) {
      emit(GetWithdrawalsSuccess(withdrawals: withdrawals));
    });
  }
}
