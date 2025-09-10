import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/withdrawal%20repo/withdrawal_repo.dart';
import 'package:almonazim/data/model/withdrawal%20models/withdrawal_input_model.dart';
import 'package:equatable/equatable.dart';

part 'delete_withdrawal_state.dart';

class DeleteWithdrawalCubit extends SafeCubit<DeleteWithdrawalState> {
  DeleteWithdrawalCubit(this.withdrawalRepo) : super(DeleteWithdrawalInitial());
  WithdrawalRepo withdrawalRepo;
  Future<void> deleteWithdrawal(
      WithdrawalInputModel withdrawalInputModel) async {
    emit(DeleteWithdrawalLoading());
    var result = await withdrawalRepo.deleteWithdrawal(withdrawalInputModel);
    result.fold((failure) {
      emit(DeleteWithdrawalFailure(failure.errMessage));
    }, (_) {
      emit(const DeleteWithdrawalSuccess());
    });
  }
}
