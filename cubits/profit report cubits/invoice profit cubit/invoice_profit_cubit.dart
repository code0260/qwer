import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/profit%20report%20repo/profit_repo.dart';
import 'package:almonazim/data/model/filter_model.dart';
import 'package:almonazim/data/model/profit%20report%20models/invoice%20profit%20models/all_invoices_profit_model.dart';
import 'package:equatable/equatable.dart';

part 'invoice_profit_state.dart';

class InvoiceProfitCubit extends SafeCubit<InvoiceProfitState> {
  InvoiceProfitCubit(this.profitRepo) : super(InvoiceProfitInitial());
  ProfitRepo profitRepo;
  FilterModel filterModel = FilterModel(
      invoiceType: [],
      startDate: DateTime.now().subtract(const Duration(days: 30)),
      endDate: DateTime.now());
  Future<void> getInvoiceProfit() async {
    emit(InvoiceProfitLoading());
    var result = await profitRepo.getInvoiceProfit(filterModel);
    result.fold((failure) {
      emit(InvoiceProfitFailure(failure.errMessage));
    }, (model) {
      emit(InvoiceProfitSuccess(allInvoicesProfitModel: model));
    });
  }
}
