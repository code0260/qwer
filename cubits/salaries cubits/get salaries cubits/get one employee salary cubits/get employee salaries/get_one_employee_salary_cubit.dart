import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/salaries%20repo/salaries_repo.dart';
import 'package:almonazim/data/model/employees%20models/salary_input_model.dart';
import 'package:almonazim/data/model/employees%20models/salary_model.dart';
import 'package:equatable/equatable.dart';

part 'get_one_employee_salary_state.dart';

class GetOneEmployeeSalaryCubit extends SafeCubit<GetOneEmployeeSalaryState> {
  GetOneEmployeeSalaryCubit(this.salariesRepo)
      : super(GetOneEmployeeSalaryInitial());
  SalariesRepo salariesRepo;
  SalaryInputModel salaryInputModel = SalaryInputModel();
  Future<void> getOneEmployeeSalary() async {
    emit(GetOneEmployeeSalaryLoading());
    var result = await salariesRepo.getOneEmployeeSalary(salaryInputModel);
    result.fold((failure) {
      emit(GetOneEmployeeSalaryFailure(failure.errMessage));
    }, (salary) {
      emit(GetOneEmployeeSalarySuccess(salaryModel: salary));
    });
  }
}
