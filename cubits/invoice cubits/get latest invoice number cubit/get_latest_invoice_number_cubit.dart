import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/invoice%20repo/invoice_repo_imp.dart';
import 'package:equatable/equatable.dart';

part 'get_latest_invoice_number_state.dart';

class GetLatestInvoiceNumberCubit
    extends SafeCubit<GetLatestInvoiceNumberState> {
  GetLatestInvoiceNumberCubit(this.invoiceRepo)
      : super(GetLatestInvoiceNumberInitial());
  InvoiceRepoImpl invoiceRepo;

  Future<void> getLatestInvoiceNumbers() async {
    emit(GetLatestInvoiceNumberLoading());
    var result = await invoiceRepo.getLatestInvoiceNumbers();
    result.fold((failure) {
      emit(GetLatestInvoiceNumberFailure(failure.errMessage));
    }, (map) {
      emit(GetLatestInvoiceNumberSuccess());
    });
  }
}
