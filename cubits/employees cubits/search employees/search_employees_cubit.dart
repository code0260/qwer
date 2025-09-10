import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/employees%20repo/employees_repo.dart';
import 'package:almonazim/data/model/employees%20models/employee_model.dart';
import 'package:almonazim/data/model/employees%20models/get_employee_model.dart';
import 'package:equatable/equatable.dart';

part 'search_employees_state.dart';

class SearchEmployeesCubit extends SafeCubit<SearchEmployeesState> {
  SearchEmployeesCubit(this.employeesRepo) : super(SearchEmployeesInitial());
  EmployeesRepo employeesRepo;
  GetEmployeeModel getEmployeeModel = GetEmployeeModel();
  Future<void> searchEmployees(GetEmployeeModel searchEmployeeModel) async {
    emit(SearchEmployeesLoading());
    var result = await employeesRepo.getEmployees(searchEmployeeModel);
    result.fold((failure) {
      emit(SearchEmployeesFailure(failure.errMessage));
    }, (employees) {
      emit(SearchEmployeesSuccess(employees: employees));
    });
  }
}
