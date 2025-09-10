import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/debt%20payment%20repo/debt_payment_repo.dart';
import 'package:almonazim/data/model/debt%20models/debt_model.dart';
import 'package:almonazim/data/model/debt%20models/debt_payment_input_model.dart';
import 'package:equatable/equatable.dart';

part 'add_debt_payment_state.dart';

class AddDebtPaymentCubit extends SafeCubit<AddDebtPaymentState> {
  AddDebtPaymentCubit(this.debtPaymentRepo) : super(AddDebtPaymentInitial());
  DebtPaymentRepo debtPaymentRepo;
  DebtPaymentInputModel debtPaymentInputModel = DebtPaymentInputModel();
  Future<void> addDebtPayment(DebtModel debtModel) async {
    prepareCurrency();
    emit(AddDebtPaymentLoading());
    var result =
        await debtPaymentRepo.addDebtPayment(debtPaymentInputModel, debtModel);
    result.fold((failure) {
      emit(AddDebtPaymentFailure(failure.errMessage));
    }, (_) {
      emit(AddDebtPaymentSuccess());
    });
  }

  void prepareCurrency() {
    if (debtPaymentInputModel.debtPaymentsAmountCurrencyId !=
        currencies
            .firstWhere((element) => element.businessCurrencyIsBase == 1)
            .businessCurrencyId) {
      debtPaymentInputModel.debtPaymentsAmountInBase = convertAmountToBase(
          debtPaymentInputModel.debtPaymentsAmount!,
          debtPaymentInputModel.debtPaymentsAmountCurrencyId!);
    } else {
      debtPaymentInputModel.debtPaymentsAmountInBase = null;
    }
  }

  void editCurrency(int id) {
    debtPaymentInputModel.debtPaymentsAmountCurrencyId = id;
    emit(AddDebtPaymentCurrencyChanged(currencyId: id));
  }
}
