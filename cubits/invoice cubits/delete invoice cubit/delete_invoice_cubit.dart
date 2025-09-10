import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/invoice%20repo/invoice_repo_imp.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:equatable/equatable.dart';

part 'delete_invoice_state.dart';

class DeleteInvoiceCubit extends SafeCubit<DeleteInvoiceState> {
  DeleteInvoiceCubit(this.invoiceRepo) : super(DeleteInvoiceInitial());
  InvoiceRepoImpl invoiceRepo;
  Future<void> deleteInvoice(InvoiceModel invoiceModel) async {
    emit(DeleteInvoiceLoading());
    var result = await invoiceRepo.deleteInvoice(invoiceModel);
    result.fold((failure) {
      emit(DeleteInvoiceFailure(errorMessage: failure.errMessage));
    }, (_) {
      emit(DeleteInvoiceSuccess());
    });
  }
}
