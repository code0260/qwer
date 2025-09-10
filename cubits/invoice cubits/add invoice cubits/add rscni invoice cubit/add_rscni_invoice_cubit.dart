import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/invoice%20repo/invoice_repo_imp.dart';
import 'package:equatable/equatable.dart';

part 'add_rscni_invoice_state.dart';

class AddRSCNIInvoiceCubit extends SafeCubit<AddRSCNIInvoiceState> {
  AddRSCNIInvoiceCubit(this.invoiceRepo) : super(AddRSCNIInvoiceInitial());
  InvoiceRepoImpl invoiceRepo;

  Future<void> addRSCNIInvoice(
      {int? clientId,
      int? partner,
      String? notes,
      required int buildingId}) async {
    emit(AddRSCNIInvoiceLoading());
    var result = await invoiceRepo.addRSCNIInvoice(
        clientId: clientId,
        partner: partner,
        notes: notes,
        buildingId: buildingId);
    result.fold((failure) {
      emit(AddRSCNIInvoiceFailure(errorMessage: failure.errMessage));
    }, (_) {
      emit(AddRSCNIInvoiceSuccess());
    });
  }

  String? get validateData {
    return null;
  }
}
