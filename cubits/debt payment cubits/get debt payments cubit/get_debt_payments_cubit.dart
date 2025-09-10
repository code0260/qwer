import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/debt%20payment%20repo/debt_payment_repo_imp.dart';
import 'package:almonazim/data/model/debt%20models/get_debt_payment_model.dart';
import 'package:almonazim/data/model/filter_model.dart';
import 'package:equatable/equatable.dart';

part 'get_debt_payments_state.dart';

class GetDebtPaymentsCubit extends SafeCubit<GetDebtPaymentsState> {
  GetDebtPaymentsCubit(this.clientRepo) : super(GetDebtPaymentsInitial());
  DebtPaymentRepoImpl clientRepo;
  FilterModel filterModel = FilterModel(
      startDate: DateTime.now().subtract(const Duration(days: 1)),
      endDate: DateTime.now(),
      invoiceType: [InvoiceType.sell]);
  Future<void> getDebtPayments() async {
    emit(GetDebtPaymentsLoading());
    var result = await clientRepo.getDebtPayments(filterModel);
    result.fold((failure) {
      emit(GetDebtPaymentsFailure(failure.errMessage));
    }, (debtPayments) {
      emit(GetDebtPaymentsSuccess(debtPayments: debtPayments));
    });
  }
}
