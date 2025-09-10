import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/invoice%20repo/invoice_repo_imp.dart';
import 'package:almonazim/data/model/filter_model.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:equatable/equatable.dart';

part 'get_invoice_state.dart';

class GetInvoiceCubit extends SafeCubit<GetInvoiceState> {
  GetInvoiceCubit(this.invoiceRepo) : super(GetInvoiceInitial());
  InvoiceRepoImpl invoiceRepo;
  FilterModel filterModel = FilterModel(
      invoiceType: [],
      startDate: DateTime.now().subtract(const Duration(days: 1)),
      endDate: DateTime.now());
  Future<void> getInvoice() async {
    emit(GetInvoiceLoading());
    var result = await invoiceRepo.getInvoices(filterModel);
    result.fold((failure) {
      emit(GetInvoiceFailure(failure.errMessage));
    }, (invoices) {
      emit(GetInvoiceSuccess(invoices: invoices));
    });
  }

  Future<void> refreshInvoices(List<InvoiceType> invoiceType) async {
    emit(GetInvoiceLoading());
    filterModel = FilterModel(
      startDate: DateTime.now().subtract(const Duration(days: 1)),
      endDate: DateTime.now(),
      invoiceType: invoiceType,
    );
    var result = await invoiceRepo.refreshInvoices(filterModel);
    result.fold((failure) {
      emit(GetInvoiceFailure(failure.errMessage));
    }, (invoices) {
      emit(GetInvoiceSuccess(invoices: invoices));
    });
  }

  Future<void> getInvoiceByNumber(String invoiceNumber) async {
    emit(GetInvoiceLoading());
    var result = await invoiceRepo.getInvoiceByNumber(
        invoiceNumber, filterModel.invoiceType);
    result.fold((failure) {
      emit(GetInvoiceFailure(failure.errMessage));
    }, (invoices) {
      emit(GetInvoiceSuccess(invoices: invoices));
    });
  }
}
