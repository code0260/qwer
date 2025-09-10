import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/invoice%20repo/invoice_repo_imp.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'transfer_draft_buy_invoice_state.dart';

class TransferDraftBuyInvoiceCubit
    extends SafeCubit<TransferDraftBuyInvoiceState> {
  TransferDraftBuyInvoiceCubit(this.invoiceRepo)
      : super(TransferDraftBuyInvoiceInitial());
  InvoiceRepoImpl invoiceRepo;

  Future<void> transferBuyDraftInvoice(InvoiceModel invoiceModel) async {
    emit(TransferDraftBuyInvoiceLoading());
    Either<Failure, void> result;
    result = await invoiceRepo.addBuyDraftInvoice(invoiceModel);
    result.fold((failure) {
      emit(TransferDraftBuyInvoiceFailure(errorMessage: failure.errMessage));
    }, (invoiceId) {
      emit(TransferDraftBuyInvoiceSuccess());
    });
  }
}
