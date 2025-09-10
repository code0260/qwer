import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/salaries%20repo/salaries_repo.dart';
import 'package:almonazim/data/model/employees%20models/salary_input_model.dart';
import 'package:almonazim/data/model/employees%20models/salary_model.dart';
import 'package:equatable/equatable.dart';

part 'get_employee_salaries_state.dart';

class GetEmployeeSalariesCubit extends SafeCubit<GetEmployeeSalariesState> {
  GetEmployeeSalariesCubit(this.salariesRepo)
      : super(GetEmployeeSalariesInitial());
  SalariesRepo salariesRepo;
  SalaryInputModel salaryInputModel = SalaryInputModel();

  Future<void> getEmployeeSalaries() async {
    emit(GetEmployeeSalariesLoading());
    var result = await salariesRepo.getEmployeeSalaries(salaryInputModel);
    result.fold((failure) {
      emit(GetEmployeeSalariesFailure(failure.errMessage));
    }, (salaries) {
      emit(GetEmployeeSalariesSuccess(salaries: salaries));
    });
  }
}
