import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/vacations%20repo/vacations_repo_imp.dart';
import 'package:almonazim/data/model/vacations%20models/vacation_input_model.dart';
import 'package:equatable/equatable.dart';

part 'delete_vacation_state.dart';

class DeleteVacationCubit extends SafeCubit<DeleteVacationState> {
  DeleteVacationCubit(this.vacationRepo) : super(DeleteVacationInitial());
  VacationsRepoImpl vacationRepo;
  Future<void> deleteVacation(VacationInputModel vacationInputModel) async {
    emit(DeleteVacationLoading());
    var result = await vacationRepo.deleteVacation(vacationInputModel);
    result.fold((failure) {
      emit(DeleteVacationFailure(errorMessage: failure.errMessage));
    }, (message) {
      emit(DeleteVacationSuccess());
    });
  }
}
