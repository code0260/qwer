import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_invoices.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:equatable/equatable.dart';

part 'get_draft_buy_invoice_state.dart';

class GetDraftBuyInvoicesCubit extends SafeCubit<GetDraftBuyInvoicesState> {
  GetDraftBuyInvoicesCubit() : super(GetDraftBuyInvoicesInitial());
  // FilterModel filterModel = FilterModel(invoiceType: []);
  Future<void> getDraftBuyInvoices() async {
    emit(GetDraftBuyInvoicesLoading());
    var result = await StoreInvoices.getInvoices(InvoiceType.buy.name);
    result.fold((failure) {
      emit(GetDraftBuyInvoicesFailure(failure.errMessage));
    }, (invoices) {
      emit(GetDraftBuyInvoicesSuccess(invoices: invoices));
    });
  }

  Future<void> getDraftBuyInvoicesByNumber(String invoiceNumber) async {
    emit(GetDraftBuyInvoicesLoading());
    var result = await StoreInvoices.searchInvoicesByNumber(invoiceNumber);
    result.fold((failure) {
      emit(GetDraftBuyInvoicesFailure(failure.errMessage));
    }, (invoices) {
      emit(GetDraftBuyInvoicesSuccess(invoices: invoices));
    });
  }
}
