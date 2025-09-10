import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/invoice%20repo/invoice_repo_imp.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'transfer_draft_sell_invoice_state.dart';

class TransferDraftSellInvoiceCubit
    extends SafeCubit<TransferDraftSellInvoiceState> {
  TransferDraftSellInvoiceCubit(this.invoiceRepo)
      : super(TransferDraftSellInvoiceInitial());
  InvoiceRepoImpl invoiceRepo;

  Future<void> transferSellDraftInvoice(InvoiceModel invoiceModel) async {
    emit(TransferDraftSellInvoiceLoading());
    Either<Failure, void> result;
    result = await invoiceRepo.addSellDraftInvoice(invoiceModel);
    result.fold((failure) {
      emit(TransferDraftSellInvoiceFailure(errorMessage: failure.errMessage));
    }, (invoiceId) {
      emit(TransferDraftSellInvoiceSuccess());
    });
  }
}
