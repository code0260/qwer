import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/salaries%20repo/salaries_repo.dart';
import 'package:almonazim/data/model/employees%20models/salary_input_model.dart';
import 'package:equatable/equatable.dart';

part 'add_salary_state.dart';

class AddSalaryCubit extends SafeCubit<AddSalaryState> {
  AddSalaryCubit(this.salariesRepo) : super(AddSalaryInitial());
  SalariesRepo salariesRepo;
  SalaryInputModel salaryInputModel =
      SalaryInputModel(salariesCreatedAt: DateTime.now().toString());
  Future<void> addSalary() async {
    prepareBaseAmount();
    emit(AddSalaryLoading());
    var result = await salariesRepo.addSalary(salaryInputModel);
    result.fold((failure) {
      emit(AddSalaryFailure(failure.errMessage));
    }, (_) {
      emit(const AddSalarySuccess());
    });
  }

  void prepareBaseAmount() {
    if (salaryInputModel.salariesAmountCurrencyId !=
        currencies
            .firstWhere((element) => element.businessCurrencyIsBase == 1)
            .businessCurrencyId) {
      salaryInputModel.salariesAmountInBase = convertAmountToBase(
          salaryInputModel.salariesAmount!,
          salaryInputModel.salariesAmountCurrencyId!);
    } else {
      salaryInputModel.salariesAmountInBase = null;
    }
  }

  String? get validateDataMessage {
    if (salaryInputModel.salariesFrequency == null) {
      return "الرجاء اختيار دورة الراتب";
    } else if (salaryInputModel.salariesPayTime == null) {
      return "الرجاء اختيار يوم الدفع";
    } else if (salaryInputModel.salariesAmount == 0 ||
        salaryInputModel.salariesAmount == null) {
      return "الرجاء إدخال قيمة الراتب";
    } else if (salaryInputModel.salariesFrequency == "weekly" &&
        salaryInputModel.salariesPayTime!.isInt == true) {
      return "الرجاء إعادة تعين يوم الدفع أو دورة الراتب";
    } else if (salaryInputModel.salariesFrequency == "monthly" &&
        salaryInputModel.salariesPayTime!.isInt == false) {
      return "الرجاء إعادة تعين يوم الدفع أو دورة الراتب";
    } else {
      return null;
    }
  }
}
