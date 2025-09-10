import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/debts%20repo/debts_repo.dart';
import 'package:almonazim/data/model/debt%20models/debt_model.dart';
import 'package:almonazim/data/model/filter_model.dart';
import 'package:equatable/equatable.dart';

part 'get_debts_state.dart';

class GetDebtsCubit extends SafeCubit<GetDebtsState> {
  GetDebtsCubit(this.debtsRepo) : super(GetDebtsInitial());
  DebtsRepo debtsRepo;
  FilterModel filterModel = FilterModel(
    invoiceType: [],
  );
  Future<void> getDebts() async {
    emit(GetDebtsLoading());
    var result = await debtsRepo.getDebts(filterModel);
    result.fold((failure) {
      emit(GetDebtsFailure(failure.errMessage));
    }, (debts) {
      emit(GetDebtsSuccess(debts: debts));
    });
  }

  Future<void> refreshDebts(
      int? clientId, InvoiceType? invoiceType, bool isCompletedDebt) async {
    emit(GetDebtsLoading());
    filterModel = FilterModel(
        clientsId: clientId,
        invoiceType: invoiceType == null ? [] : [invoiceType],
        isCompletedDebt: isCompletedDebt);
    var result = await debtsRepo.refreshDebts(filterModel);
    result.fold((failure) {
      emit(GetDebtsFailure(failure.errMessage));
    }, (debts) {
      emit(GetDebtsSuccess(debts: debts));
    });
  }
}
