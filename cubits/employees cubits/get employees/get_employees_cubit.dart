import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/employees%20repo/employees_repo.dart';
import 'package:almonazim/data/model/employees%20models/employee_model.dart';
import 'package:almonazim/data/model/employees%20models/get_employee_model.dart';
import 'package:equatable/equatable.dart';

part 'get_employees_state.dart';

class GetEmployeesCubit extends SafeCubit<GetEmployeesState> {
  GetEmployeesCubit(this.employeesRepo) : super(GetEmployeesInitial());
  EmployeesRepo employeesRepo;
  GetEmployeeModel getEmployeeModel = GetEmployeeModel();
  Future<void> getEmployees(GetEmployeeModel getEmployeeModel) async {
    emit(GetEmployeesLoading());
    var result = await employeesRepo.getEmployees(getEmployeeModel);
    result.fold((failure) {
      emit(GetEmployeesFailure(failure.errMessage));
    }, (employees) {
      emit(GetEmployeesSuccess(employees: employees));
    });
  }
}
