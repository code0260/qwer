import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_invoices.dart';
import 'package:almonazim/data/data%20source/repo/invoice%20repo/invoice_repo_imp.dart';
import 'package:equatable/equatable.dart';

part 'delete_draft_invoice_state.dart';

class DeleteDraftInvoiceCubit extends SafeCubit<DeleteDraftInvoiceState> {
  DeleteDraftInvoiceCubit(this.invoiceRepo)
      : super(DeleteDraftInvoiceInitial());
  InvoiceRepoImpl invoiceRepo;
  Future<void> deleteInvoice(int invoiceId) async {
    emit(DeleteDraftInvoiceLoading());
    var result = await StoreInvoices.deleteInvoice(invoiceId);
    result.fold((failure) {
      emit(DeleteDraftInvoiceFailure(errorMessage: failure.errMessage));
    }, (_) {
      emit(DeleteDraftInvoiceSuccess());
    });
  }
}
