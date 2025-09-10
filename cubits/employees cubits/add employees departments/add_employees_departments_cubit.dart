import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/employees%20repo/employees_repo.dart';
import 'package:equatable/equatable.dart';

part 'add_employees_departments_state.dart';

class AddEmployeesDepartmentsCubit
    extends SafeCubit<AddEmployeesDepartmentsState> {
  AddEmployeesDepartmentsCubit(this.employeesRepo)
      : super(AddEmployeesDepartmentsInitial());

  EmployeesRepo employeesRepo;

  Future<void> addEmployeesDepartments(String department) async {
    emit(AddEmployeesDepartmentsLoading());
    var result = await employeesRepo.addEmployeeDepartment(department);
    result.fold((failure) {
      emit(AddEmployeesDepartmentsFailure(failure.errMessage));
    }, (employeesDepartments) {
      emit(AddEmployeesDepartmentsSuccess());
    });
  }
}
