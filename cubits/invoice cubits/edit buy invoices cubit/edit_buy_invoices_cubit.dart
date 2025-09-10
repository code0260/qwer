import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_default_invoice_payment_status.dart';
import 'package:almonazim/data/data%20source/repo/invoice%20repo/invoice_repo_imp.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_buy_invoices_state.dart';

class EditBuyInvoiceCubit extends SafeCubit<EditBuyInvoiceState> {
  EditBuyInvoiceCubit(this.unitRepo) : super(EditBuyInvoiceInitial());
  InvoiceRepoImpl unitRepo;
  InvoiceModel invoiceModel = InvoiceModel(
      invoicesPaymentStatus:
          StoreDefaultInvoicePaymentStatus.getDefaultInvoicePaymentStatus());
  String? paymentStateWhenRefundOnly;
  bool? calculateRefundWithDiscount;
  Future<void> editInvoice() async {
    emit(EditBuyInvoiceLoading());
    var result = await unitRepo.editBuyInvoice(
        invoiceModel, paymentStateWhenRefundOnly, calculateRefundWithDiscount);
    result.fold((failure) {
      emit(EditBuyInvoiceFailure(failure.errMessage));
    }, (units) {
      emit(EditBuyInvoiceSuccess());
    });
  }

  String? get validateBuyData {
    for (final item in cartBuyEditHome) {
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
