import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/salaries%20repo/salaries_repo.dart';
import 'package:almonazim/data/model/employees%20models/salary_input_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_salary_amount_by_id_state.dart';

class EditSalaryAmountByIdCubit extends SafeCubit<EditSalaryAmountByIdState> {
  EditSalaryAmountByIdCubit(this.salariesRepo)
      : super(EditSalaryAmountByIdInitial());
  SalariesRepo salariesRepo;
  Future<void> editSalaryAmountById(SalaryInputModel salaryInputModel) async {
    emit(EditSalaryAmountByIdLoading());
    var result = await salariesRepo.editSalaryAmountById(salaryInputModel);
    result.fold((failure) {
      emit(EditSalaryAmountByIdFailure(failure.errMessage));
    }, (_) {
      emit(const EditSalaryAmountByIdSuccess());
    });
  }
}
