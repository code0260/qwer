import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/employees%20repo/employees_repo_imp.dart';
import 'package:almonazim/data/model/employees%20models/edit_employee_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_employee_state.dart';

class EditEmployeeCubit extends SafeCubit<EditEmployeeState> {
  EditEmployeeCubit(this.employeeRepo) : super(EditEmployeeInitial());
  EmployeesRepoImpl employeeRepo;

  EditEmployeeModel editEmployeeModel = EditEmployeeModel();

  Future<void> editEmployee() async {
    emit(EditEmployeeLoading());
    var result = await employeeRepo.editEmployee(editEmployeeModel);
    result.fold((failure) {
      emit(EditEmployeeFailure(errorMessage: failure.errMessage));
    }, (_) {
      emit(const EditEmployeeSuccess());
    });
  }

  String? get validateDataMessage {
    if (editEmployeeModel.employeesDepartmentsId == null) {
      return "الرجاء اختيار قسم";
    } else {
      return null;
    }
  }
}
