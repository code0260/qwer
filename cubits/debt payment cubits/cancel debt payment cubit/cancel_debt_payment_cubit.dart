import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/debt%20payment%20repo/debt_payment_repo.dart';
import 'package:almonazim/data/model/debt%20models/debt_model.dart';
import 'package:almonazim/data/model/debt%20models/debt_payment_input_model.dart';
import 'package:equatable/equatable.dart';

part 'cancel_debt_payment_state.dart';

class CancelDebtPaymentCubit extends SafeCubit<CancelDebtPaymentState> {
  CancelDebtPaymentCubit(this.debtPaymentRepo)
      : super(CancelDebtPaymentInitial());
  DebtPaymentRepo debtPaymentRepo;
  DebtPaymentInputModel debtPaymentInputModel = DebtPaymentInputModel();
  Future<void> cancelDebtPayment(DebtModel debtModel) async {
    emit(CancelDebtPaymentLoading());
    var result = await debtPaymentRepo.cancelDebtPayment(
        debtPaymentInputModel, debtModel);
    result.fold((failure) {
      emit(CancelDebtPaymentFailure(failure.errMessage));
    }, (_) {
      emit(CancelDebtPaymentSuccess());
    });
  }
}
