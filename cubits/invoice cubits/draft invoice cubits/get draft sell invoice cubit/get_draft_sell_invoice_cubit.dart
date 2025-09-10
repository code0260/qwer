import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_invoices.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:equatable/equatable.dart';

part 'get_draft_sell_invoice_state.dart';

class GetDraftSellInvoicesCubit extends SafeCubit<GetDraftSellInvoicesState> {
  GetDraftSellInvoicesCubit() : super(GetDraftSellInvoicesInitial());
  // FilterModel filterModel = FilterModel(invoiceType: []);
  Future<void> getDraftSellInvoices() async {
    emit(GetDraftSellInvoicesLoading());
    var result = await StoreInvoices.getInvoices(InvoiceType.sell.name);
    result.fold((failure) {
      emit(GetDraftSellInvoicesFailure(failure.errMessage));
    }, (invoices) {
      emit(GetDraftSellInvoicesSuccess(invoices: invoices));
    });
  }

  Future<void> getDraftSellInvoicesByNumber(String invoiceNumber) async {
    emit(GetDraftSellInvoicesLoading());
    var result = await StoreInvoices.searchInvoicesByNumber(invoiceNumber);
    result.fold((failure) {
      emit(GetDraftSellInvoicesFailure(failure.errMessage));
    }, (invoices) {
      emit(GetDraftSellInvoicesSuccess(invoices: invoices));
    });
  }
}
