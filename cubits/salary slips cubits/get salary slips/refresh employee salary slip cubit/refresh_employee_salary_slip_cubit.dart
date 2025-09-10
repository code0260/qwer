// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/model/salary%20slip%20models/salary_slip_employee_model.dart';

class RefreshEmployeeSalarySlipCubit extends SafeCubit<SalarySlipEmployeeSate> {
  RefreshEmployeeSalarySlipCubit()
      : super(SalarySlipEmployeeSate(
            salarySlipEmployeeModel: SalarySlipEmployeeModel(
              salarySlips: const [],
              employeeName: "",
            ),
            stateId: 0));

  late SalarySlipEmployeeModel salarySlipEmployeeModel;

  void removeFirstAndRefresh() {
    salarySlipEmployeeModel.salarySlips.removeAt(0);

    refresh();
  }

  void refresh() {
    emit(SalarySlipEmployeeSate(
        stateId: state.stateId + 1,
        salarySlipEmployeeModel: salarySlipEmployeeModel));
  }

  void setSalarySlipEmployeeModel(SalarySlipEmployeeModel salarySlipEmployee) {
    salarySlipEmployeeModel = salarySlipEmployee;
  }
}

class SalarySlipEmployeeSate {
  int stateId;
  SalarySlipEmployeeModel salarySlipEmployeeModel;
  SalarySlipEmployeeSate({
    required this.stateId,
    required this.salarySlipEmployeeModel,
  });
}
