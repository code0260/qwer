import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/deposit%20repo/deposit_repo.dart';
import 'package:almonazim/data/model/deposit%20models/deposit_input_model.dart';
import 'package:equatable/equatable.dart';

part 'delete_deposit_state.dart';

class DeleteDepositCubit extends SafeCubit<DeleteDepositState> {
  DeleteDepositCubit(this.depositRepo) : super(DeleteDepositInitial());
  DepositRepo depositRepo;
  Future<void> deleteDeposit(DepositInputModel depositInputModel) async {
    emit(DeleteDepositLoading());
    var result = await depositRepo.deleteDeposit(depositInputModel);
    result.fold((failure) {
      emit(DeleteDepositFailure(failure.errMessage));
    }, (_) {
      emit(const DeleteDepositSuccess());
    });
  }
}
