import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/invoice%20repo/invoice_repo_imp.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'upload_all_sell_invoice_state.dart';

class UploadAllSellInvoiceCubit extends SafeCubit<UploadAllSellInvoiceState> {
  UploadAllSellInvoiceCubit(this.invoiceRepo)
      : super(UploadAllSellInvoiceInitial());
  InvoiceRepoImpl invoiceRepo;

  Future<void> uploadAllSellInvoices() async {
    emit(UploadAllSellInvoiceLoading());
    Either<Failure, void> result;
    result = await invoiceRepo.uploadAllSellInvoices();
    result.fold((failure) {
      emit(UploadAllSellInvoiceFailure(errorMessage: failure.errMessage));
    }, (_) {
      emit(UploadAllSellInvoiceSuccess());
    });
  }
}
