import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/debt%20payment%20repo/debt_payment_repo.dart';
import 'package:almonazim/data/model/debt%20models/add_payments_model.dart';
import 'package:equatable/equatable.dart';

part 'add_payments_state.dart';

class AddPaymentsCubit extends SafeCubit<AddPaymentsState> {
  AddPaymentsCubit(this.debtPaymentRepo) : super(AddPaymentsInitial());
  DebtPaymentRepo debtPaymentRepo;
  AddPaymentsModel addPaymentsModel = AddPaymentsModel(debts: []);
  Future<void> addDebtPayment() async {
    emit(AddPaymentsLoading());
    var result = await debtPaymentRepo.addPayments(addPaymentsModel);
    result.fold((failure) {
      emit(AddPaymentsFailure(failure.errMessage));
    }, (_) {
      emit(AddPaymentsSuccess());
    });
  }

  void editCurrency(int id) {
    addPaymentsModel.paymentsAmountCurrencyId = id;
    refreshTotalDebts();
    emit(AddPaymentsCurrencyChanged(currencyId: id));
  }

  void editClient(int id) {
    addPaymentsModel.clientId = id;
    emit(AddPaymentsClientChanged(clientId: id));
  }

  void refreshTotalDebts() {
    addPaymentsModel.total = 0;
    for (final debt in addPaymentsModel.debts) {
      addPaymentsModel.total += convertAmount(
          debt.debtsTotalAmount! - debt.debtsPaidAmount!,
          debt.debtsAmountCurrencyId!,
          addPaymentsModel.paymentsAmountCurrencyId!);
    }
  }
}
