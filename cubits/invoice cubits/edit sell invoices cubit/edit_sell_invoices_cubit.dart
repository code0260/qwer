import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_default_invoice_payment_status.dart';
import 'package:almonazim/data/data%20source/repo/invoice%20repo/invoice_repo_imp.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_sell_invoices_state.dart';

class EditSellInvoiceCubit extends SafeCubit<EditSellInvoiceState> {
  EditSellInvoiceCubit(this.invoiceRepo) : super(EditSellInvoiceInitial());
  InvoiceRepoImpl invoiceRepo;
  InvoiceModel invoiceModel = InvoiceModel(
      invoicesPaymentStatus:
          StoreDefaultInvoicePaymentStatus.getDefaultInvoicePaymentStatus());
  String? paymentStateWhenRefundOnly;
  bool? calculateRefundWithDiscount;
  Future<void> editInvoice() async {
    emit(EditSellInvoiceLoading());
    var result = await invoiceRepo.editSellInvoice(
        invoiceModel, paymentStateWhenRefundOnly, calculateRefundWithDiscount);
    result.fold((failure) {
      emit(EditSellInvoiceFailure(failure.errMessage));
    }, (units) {
      emit(EditSellInvoiceSuccess());
    });
  }

  String? get validateSellData {
    for (var editedItem in cartSellEditHome) {
      if (editedItem.chosenPlaceModels.any((element) =>
          element.placeModel.placesId == 0 ||
          element.placeModel.placesId == null)) {
        return 'عذرا المنتج ${editedItem.getProductModel.productModel.productsName} مفقود';
      }
    }
    return null;
  }

  void giveInvoiceModelData({
    int? invoicesId,
    int? invoicesClientId,
    int? debtsPaidAmountCurrencyId,
    String? invoicesType,
    double? invoicesUndiscountedAmount,
    double? invoicesDiscountedAmount,
    double? invoicesShippingCost,
    String? invoicesPaymentStatus,
    String? invoicesNotes,
    String? invoicesCreatedAt,
    String? invoicesAppliedAt,
    int? invoicesBusinessId,
    String? clientsName,
    double? debtsPaidAmount,
    String? debtsDueDate,
    int? debtsInvoicesId,
    double? invoicesDiscountValue, // New property
    String? invoicesDiscountType, // New property
  }) {
    invoiceModel = invoiceModel.copyWith(
      invoicesId: invoicesId,
      invoicesAppliedAt: invoicesAppliedAt,
      invoicesClientId: invoicesClientId,
      debtsPaidAmountCurrencyId: debtsPaidAmountCurrencyId,
      invoicesType: invoicesType,
      invoicesUndiscountedAmount: invoicesUndiscountedAmount,
      invoicesDiscountedAmount: invoicesDiscountedAmount,
      invoicesShippingCost: invoicesShippingCost,
      invoicesPaymentStatus: invoicesPaymentStatus,
      invoicesNotes: invoicesNotes != null && invoicesNotes.isNotEmpty
          ? invoicesNotes
          : null,
      invoicesCreatedAt: invoicesCreatedAt,
      invoicesBusinessId: invoicesBusinessId,
      clientsName: clientsName,
      debtsPaidAmount: debtsPaidAmount,
      debtsDueDate: debtsDueDate,
      debtsInvoicesId: debtsInvoicesId,
      invoicesDiscountValue: invoicesDiscountValue, // New property
      invoicesDiscountType: invoicesDiscountType, // New property
    );
  }
}
