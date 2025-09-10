import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/employees%20repo/employees_repo_imp.dart';
import 'package:almonazim/data/model/employees%20models/add_employee_model.dart';
import 'package:equatable/equatable.dart';

part 'add_employee_state.dart';

class AddEmployeeCubit extends SafeCubit<AddEmployeeState> {
  AddEmployeeCubit(this.employeeRepo) : super(AddEmployeeInitial());
  EmployeesRepoImpl employeeRepo;

  AddEmployeeModel addEmployeeModel = AddEmployeeModel();

  Future<void> addEmployee() async {
    prepareBaseAmount();
    emit(AddEmployeeLoading());
    var result = await employeeRepo.addEmployee(addEmployeeModel);
    result.fold((failure) {
      emit(AddEmployeeFailure(errorMessage: failure.errMessage));
    }, (_) {
      emit(const AddEmployeeSuccess());
    });
  }

  void prepareBaseAmount() {
    if (addEmployeeModel.salaryInputModel.salariesAmountCurrencyId !=
        currencies
            .firstWhere(
              (element) => element.businessCurrencyIsBase == 1,
            )
            .businessCurrencyId) {
      addEmployeeModel.salaryInputModel.salariesAmountInBase =
          convertAmountToBase(addEmployeeModel.salaryInputModel.salariesAmount!,
              addEmployeeModel.salaryInputModel.salariesAmountCurrencyId!);
    } else {
      addEmployeeModel.salaryInputModel.salariesAmountInBase = null;
    }
  }

  String? get validateDataMessage {
    if (addEmployeeModel.employeesDepartmentsId == null) {
      return "الرجاء اختيار قسم";
    } else if (addEmployeeModel.employeesWorkDate == null) {
      return "الرجاء اختيار وقت بدء العمل";
    } else if (addEmployeeModel.salaryInputModel.salariesFrequency == null) {
      return "الرجاء اختيار دورة الراتب";
    } else if (addEmployeeModel.salaryInputModel.salariesPayTime == null) {
      return "الرجاء اختيار يوم الدفع";
    } else if (addEmployeeModel.salaryInputModel.salariesFrequency ==
            "weekly" &&
        addEmployeeModel.salaryInputModel.salariesPayTime!.isInt == true) {
      return "الرجاء إعادة تعين يوم الدفع أو دورة الراتب";
    } else if (addEmployeeModel.salaryInputModel.salariesFrequency ==
            "monthly" &&
        addEmployeeModel.salaryInputModel.salariesPayTime!.isInt == false) {
      return "الرجاء إعادة تعين يوم الدفع أو دورة الراتب";
    } else {
      return null;
    }
  }
}
