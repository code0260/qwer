import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/cash%20repo/cash_repo.dart';
import 'package:almonazim/data/model/cash%20models/edit_cash_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_cash_state.dart';

class EditCashCubit extends SafeCubit<EditCashState> {
  EditCashCubit(this.cashRepo) : super(EditCashInitial());
  CashRepo cashRepo;
  EditCashModel editCashModel = EditCashModel();
  Future<void> editCash() async {
    prepareBaseAmount();
    emit(EditCashLoading());
    var response = await cashRepo.editCash(editCashModel);
    response.fold((failure) {
      emit(EditCashFailure(errorMessage: failure.errMessage));
    }, (_) {
      emit(EditCashSuccess());
    });
  }

  void prepareBaseAmount() {
    if (editCashModel.currencyId !=
        currencies
            .firstWhere(
              (element) => element.businessCurrencyIsBase == 1,
            )
            .businessCurrencyId) {
      editCashModel.amountInBase =
          convertAmountToBase(editCashModel.amount!, editCashModel.currencyId!);
    } else {
      editCashModel.amountInBase = null;
    }
  }

  String? get validateDataMessage {
    if (editCashModel.amount == null || editCashModel.amount! <= 0) {
      return "الرجاء إدخال المبلغ بشكل صحيح";
    } else if (editCashModel.reason == null || editCashModel.reason!.isEmpty) {
      return "الرجاء اخيار السبب";
    } else {
      return null;
    }
  }
}
