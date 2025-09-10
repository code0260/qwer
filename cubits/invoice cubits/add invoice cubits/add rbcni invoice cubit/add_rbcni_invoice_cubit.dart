import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/invoice%20repo/invoice_repo_imp.dart';
import 'package:equatable/equatable.dart';

part 'add_rbcni_invoice_state.dart';

class AddRBCNIInvoiceCubit extends SafeCubit<AddRBCNIInvoiceState> {
  AddRBCNIInvoiceCubit(this.invoiceRepo) : super(AddRBCNIInvoiceInitial());
  InvoiceRepoImpl invoiceRepo;

  Future<void> addRBCNIInvoice() async {
    emit(AddRBCNIInvoiceLoading());
    var result = await invoiceRepo.addRBCNIInvoice();
    result.fold((failure) {
      emit(AddRBCNIInvoiceFailure(errorMessage: failure.errMessage));
    }, (_) {
      emit(AddRBCNIInvoiceSuccess());
    });
  }

  String? get validateData {
    for (final item in rBCNIHome) {
      if (item.placeModel.placesId == null || item.placeModel.placesId == 0) {
        return "الرجاء إدخال مكان ${item.productModel.productsName}";
      } else if (item.batchModel.batchesProductsTotalCount == null) {
        return "الرجاء إدخال كمية ${item.productModel.productsName}";
      } else if (item.batchModel.batchesProductsBuyPrice == null) {
        return "الرجاء إدخال سعر شراء ${item.productModel.productsName}";
      } else if (item.batchModel.batchesCountUnitId == null) {
        return "الرجاء إدخال  الواحدة ${item.productModel.productsName}";
      }
    }
    return null;
  }
}
