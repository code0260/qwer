import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/salary%20slips%20repo/salary_slips_repo_imp.dart';
import 'package:almonazim/data/model/salary%20slip%20models/salary_slip_input_model.dart';
import 'package:almonazim/data/model/salary%20slip%20models/salary_slip_model.dart';
import 'package:equatable/equatable.dart';

part 'get_paid_salaries_state.dart';

class GetPaidSalariesCubit extends SafeCubit<GetPaidSalariesState> {
  GetPaidSalariesCubit(this.salarySlipRepoImpl)
      : super(GetPaidSalariesInitial());
  SalarySlipRepoImpl salarySlipRepoImpl;
  SalarySlipInputModel salarySlipInputModel = SalarySlipInputModel(
      startDate: DateTime.now().subtract(const Duration(days: 30)),
      endDate: DateTime.now());

  Future<void> getPaidSalaries() async {
    emit(GetPaidSalariesLoading());
    var result =
        await salarySlipRepoImpl.getPaidSalarySlips(salarySlipInputModel);
    result.fold((failure) {
      emit(GetPaidSalariesFailure(failure.errMessage));
    }, (unpaidSalaries) {
      emit(GetPaidSalariesSuccess(salarySlips: unpaidSalaries));
    });
  }

  // void refresh(SalarySlipEmployeeModel salaryEmployeeModel) {
  //   emit(GetPaidSalariesLoading());
  //   removePaidEmployees();
  //   emit(GetPaidSalariesSuccess(salarySlips: salaryEmployeeSlips));
  // }
}
