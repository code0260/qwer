import 'package:almonazim/core/helper/functions/salary%20slip%20functions/edit_salary_slip_currency.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/salary%20slips%20repo/salary_slips_repo_imp.dart';
import 'package:almonazim/data/model/salary%20slip%20models/salary_slip_model.dart';
import 'package:equatable/equatable.dart';

part 'add_salary_slip_state.dart';

class AddSalarySlipCubit extends SafeCubit<AddSalarySlipState> {
  AddSalarySlipCubit(this.salarySlipRepoImpl) : super(AddSalarySlipInitial());
  SalarySlipRepoImpl salarySlipRepoImpl;
  late SalarySlipModel salarySlipModel;
  Future<void> addSalarySlip() async {
    emit(AddSalarySlipLoading());
    var result = await salarySlipRepoImpl.addSalarySlip(salarySlipModel);
    result.fold((failure) {
      emit(AddSalarySlipFailure(failure.errMessage));
    }, (_) {
      emit(const AddSalarySlipSuccess());
    });
  }

  void editCurrency(int id) {
    salarySlipModel = editSalarySlipCurrency(id, salarySlipModel);
  }
}
