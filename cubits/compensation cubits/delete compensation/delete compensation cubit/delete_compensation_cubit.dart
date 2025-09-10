import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/compensation%20repo/compensation_repo_imp.dart';
import 'package:almonazim/data/model/employees%20models/compensation_input_model.dart';
import 'package:equatable/equatable.dart';

part 'delete_compensation_state.dart';

class DeleteCompensationCubit extends SafeCubit<DeleteCompensationState> {
  DeleteCompensationCubit(this.compensationRepo)
      : super(DeleteCompensationInitial());
  CompensationRepoImpl compensationRepo;
  Future<void> deleteCompensation(
      CompensationInputModel compensationInputModel) async {
    emit(DeleteCompensationLoading());
    var result =
        await compensationRepo.deleteCompensation(compensationInputModel);
    result.fold((failure) {
      emit(DeleteCompensationFailure(errorMessage: failure.errMessage));
    }, (message) {
      emit(DeleteCompensationSuccess());
    });
  }
}
