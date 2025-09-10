import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_invoices.dart';
import 'package:almonazim/data/data%20source/repo/invoice%20repo/invoice_repo_imp.dart';
import 'package:almonazim/data/model/invoice%20models/all_invoices_items_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'get_invoice_items_state.dart';

class GetInvoiceItemsCubit extends SafeCubit<GetInvoiceItemsState> {
  GetInvoiceItemsCubit(this.invoiceItemsRepo) : super(GetInvoiceItemsInitial());
  InvoiceRepoImpl invoiceItemsRepo;
  Future<void> getInvoiceItems(int invoicesId,
      {bool? isDraft = false,
      InvoiceType? invoiceType = InvoiceType.buy}) async {
    emit(GetInvoiceItemsLoading());
    Either<Failure, AllInvoicesItemsModel> result;
    if (isDraft == true) {
      if (invoiceType == InvoiceType.buy) {
        result = await StoreInvoices.getBuyLocalInvoiceItems(invoicesId);
      } else {
        result = await StoreInvoices.getSellLocalInvoiceItems(invoicesId);
      }
    } else {
      result = await invoiceItemsRepo.getInvoicesItems(invoicesId);
    }
    result.fold((failure) {
      emit(GetInvoiceItemsFailure(failure.errMessage));
    }, (invoiceItems) {
      emit(GetInvoiceItemsSuccess(allInvoicesItems: invoiceItems));
    });
  }
}
