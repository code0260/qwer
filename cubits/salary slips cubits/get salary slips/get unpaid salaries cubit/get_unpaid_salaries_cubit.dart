import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/salary%20slips%20repo/salary_slips_repo_imp.dart';
import 'package:almonazim/data/model/salary%20slip%20models/salary_slip_employee_model.dart';
import 'package:equatable/equatable.dart';

part 'get_unpaid_salaries_state.dart';

class GetUnpaidSalariesCubit extends SafeCubit<GetUnpaidSalariesState> {
  GetUnpaidSalariesCubit(this.salarySlipRepoImpl)
      : super(GetUnpaidSalariesInitial());
  SalarySlipRepoImpl salarySlipRepoImpl;
  late List<SalarySlipEmployeeModel> salaryEmployeeSlips;
  Future<void> getUnpaidSalaries() async {
    emit(GetUnpaidSalariesLoading());
    var result = await salarySlipRepoImpl.getUnpaidSalarySlips();
    result.fold((failure) {
      emit(GetUnpaidSalariesFailure(failure.errMessage));
    }, (unpaidSalaries) {
      salaryEmployeeSlips = unpaidSalaries;
      emit(GetUnpaidSalariesSuccess(salarySlipsEmployee: unpaidSalaries));
    });
  }

  void refresh(SalarySlipEmployeeModel salaryEmployeeModel) {
    emit(GetUnpaidSalariesLoading());
    removePaidEmployees();
    emit(GetUnpaidSalariesSuccess(salarySlipsEmployee: salaryEmployeeSlips));
  }

  void removePaidEmployees() {
    SalarySlipEmployeeModel? modelToBeRemoved;
    for (final model in salaryEmployeeSlips) {
      if (model.salarySlips.isEmpty) {
        modelToBeRemoved = model;
      }
    }
    salaryEmployeeSlips.remove(modelToBeRemoved);
  }

  // void updatingSalaryEmployeeSlips(
  //     SalarySlipEmployeeModel salaryEmployeeModel) {
  // no need to any sync between this salaryEmployeeModel and this cubit because the have the same data without my work
  //   for (final model in salaryEmployeeSlips) {
  //     if (model != salaryEmployeeModel) {
  //       if (model.employeeName == salaryEmployeeModel.employeeName) {
  //         if (salaryEmployeeModel.salarySlips.isEmpty) {
  //           logger.w("object");
  //           salaryEmployeeSlips.remove(model);
  //         } else {
  //           // it is not empty and does not equal it, that means the are differentPrepaidExpense in length so update the list
  //           model.salarySlips = salaryEmployeeModel.salarySlips;
  //         }
  //       }
  //     } else {
  //       break;
  //     }
  //   }
  // }

  // }
}
