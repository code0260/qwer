import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/compensation%20repo/compensation_repo_imp.dart';
import 'package:almonazim/data/model/employees%20models/compensation_input_model.dart';
import 'package:equatable/equatable.dart';

part 'add_compensation_state.dart';

class AddCompensationCubit extends SafeCubit<AddCompensationState> {
  AddCompensationCubit(this.compensationRepoImpl)
      : super(AddCompensationInitial());
  CompensationRepoImpl compensationRepoImpl;
  CompensationInputModel compensationInputModel = CompensationInputModel(
      salariesCompensationsCreatedAt: DateTime.now().toString());

  Future<void> addCompensation() async {
    prepareBaseAmount();
    emit(AddCompensationLoading());
    var result =
        await compensationRepoImpl.addCompensation(compensationInputModel);
    result.fold((failure) {
      emit(AddCompensationFailure(failure.errMessage));
    }, (_) {
      emit(const AddCompensationSuccess());
    });
  }

  void prepareBaseAmount() {
    if (compensationInputModel.salariesCompensationAmountCurrencyId !=
        currencies
            .firstWhere((element) => element.businessCurrencyIsBase == 1)
            .businessCurrencyId) {
      compensationInputModel.salariesCompensationAmountInBase =
          convertAmountToBase(
              compensationInputModel.salariesCompensationsAmount!,
              compensationInputModel.salariesCompensationAmountCurrencyId!);
    } else {
      compensationInputModel.salariesCompensationAmountInBase = null;
    }
  }

  String? get validateDataMessage {
    if (compensationInputModel.salariesCompensationsAmount == 0 ||
        compensationInputModel.salariesCompensationsAmount == null) {
      return "الرجاء إدخال القيمة";
    } else if (compensationInputModel.salariesCompensationsReason == "") {
      return "الرجاء إدخال السبب";
    } else if (compensationInputModel.employeeId == null) {
      return "الرجاء اختيار الموظف";
    } else {
      return null;
    }
  }
}
