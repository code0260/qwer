import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/employees%20repo/employees_repo.dart';
import 'package:almonazim/data/model/employees%20models/employees_departments_model.dart';
import 'package:equatable/equatable.dart';

part 'get_employees_departments_state.dart';

class GetEmployeesDepartmentsCubit
    extends SafeCubit<GetEmployeesDepartmentsState> {
  GetEmployeesDepartmentsCubit(this.employeesRepo)
      : super(GetEmployeesDepartmentsInitial());
  EmployeesRepo employeesRepo;

  Future<void> getEmployeesDepartments() async {
    emit(GetEmployeesDepartmentsLoading());
    var result = await employeesRepo.getEmployeesDepartments();
    result.fold((failure) {
      emit(GetEmployeesDepartmentsFailure(failure.errMessage));
    }, (employeesDepartments) {
      emit(GetEmployeesDepartmentsSuccess(
          employeesDepartments: employeesDepartments));
    });
  }

  Future<void> refreshEmployeesDepartments() async {
    emit(GetEmployeesDepartmentsLoading());
    var result = await employeesRepo.refreshEmployeesDepartments();
    result.fold((failure) {
      emit(GetEmployeesDepartmentsFailure(failure.errMessage));
    }, (employeesDepartments) {
      emit(GetEmployeesDepartmentsSuccess(
          employeesDepartments: employeesDepartments));
    });
  }
}
