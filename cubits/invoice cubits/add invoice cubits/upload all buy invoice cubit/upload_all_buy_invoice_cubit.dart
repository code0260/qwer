import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/invoice%20repo/invoice_repo_imp.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'upload_all_buy_invoice_state.dart';

class UploadAllBuyInvoiceCubit extends SafeCubit<UploadAllBuyInvoiceState> {
  UploadAllBuyInvoiceCubit(this.invoiceRepo)
      : super(UploadAllBuyInvoiceInitial());
  InvoiceRepoImpl invoiceRepo;

  Future<void> uploadAllBuyInvoices() async {
    emit(UploadAllBuyInvoiceLoading());
    Either<Failure, void> result;
    result = await invoiceRepo.uploadAllBuyInvoices();
    result.fold((failure) {
      emit(UploadAllBuyInvoiceFailure(errorMessage: failure.errMessage));
    }, (_) {
      emit(UploadAllBuyInvoiceSuccess());
    });
  }
}
