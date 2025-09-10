import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/compensation%20repo/compensation_repo_imp.dart';
import 'package:almonazim/data/model/employees%20models/all_compensation_model.dart';
import 'package:almonazim/data/model/employees%20models/compensation_input_model.dart';
import 'package:equatable/equatable.dart';

part 'get_employees_compensation_state.dart';

class GetEmployeesCompensationCubit
    extends SafeCubit<GetEmployeesCompensationState> {
  GetEmployeesCompensationCubit(this.compensationRepoImpl)
      : super(GetEmployeesCompensationInitial());
  CompensationRepoImpl compensationRepoImpl;
  CompensationInputModel compensationInputModel = CompensationInputModel(
    startDate: DateTime.now().subtract(const Duration(days: 3 * 30)),
    endDate: DateTime.now(),
  );

  Future<void> getEmployeesCompensationInfo() async {
    emit(GetEmployeesCompensationLoading());
    var result = await compensationRepoImpl
        .getEmployeesCompensation(compensationInputModel);
    result.fold((failure) {
      emit(GetEmployeesCompensationFailure(failure.errMessage));
    }, (allCompensationModel) {
      emit(GetEmployeesCompensationSuccess(
          allCompensationModel: allCompensationModel));
    });
  }
}
