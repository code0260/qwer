import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/vacations%20repo/vacations_repo_imp.dart';
import 'package:almonazim/data/model/vacations%20models/vacation_input_model.dart';
import 'package:almonazim/data/model/vacations%20models/vacation_model.dart';
import 'package:equatable/equatable.dart';

part 'get_employees_vacation_state.dart';

class GetEmployeesVacationCubit extends SafeCubit<GetEmployeesVacationState> {
  GetEmployeesVacationCubit(this.vacationRepoImpl)
      : super(GetEmployeesVacationInitial());
  VacationsRepoImpl vacationRepoImpl;
  VacationInputModel vacationInputModel = VacationInputModel();

  Future<void> getEmployeesVacationInfo() async {
    emit(GetEmployeesVacationLoading());
    var result =
        await vacationRepoImpl.getEmployeeVacations(vacationInputModel);
    result.fold((failure) {
      emit(GetEmployeesVacationFailure(failure.errMessage));
    }, (vacationModel) {
      emit(GetEmployeesVacationSuccess(vacations: vacationModel));
    });
  }
}
