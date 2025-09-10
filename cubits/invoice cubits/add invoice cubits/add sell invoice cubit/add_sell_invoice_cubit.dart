import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/prepare_invoice_currency.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_invoices.dart';
import 'package:almonazim/data/data%20source/locale/store_default_client.dart';
import 'package:almonazim/data/data%20source/locale/store_default_invoice_payment_status.dart';
import 'package:almonazim/data/data%20source/locale/store_latest_invoice_number.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/data%20source/repo/invoice%20repo/invoice_repo_imp.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'add_sell_invoice_state.dart';

class AddSellInvoiceCubit extends SafeCubit<AddSellInvoiceState> {
  InvoiceModel invoiceModel = InvoiceModel(
      invoicesClientId:
          StoreDefaultClient.getDefaultClient(ClientType.customer.name),
      invoicesNumber: StoreInvoiceNumber.getAfterLatestInvoiceNumber("sell"),
      invoicesType: "sell",
      invoicesPaymentStatus:
          StoreDefaultInvoicePaymentStatus.getDefaultInvoicePaymentStatus());
  AddSellInvoiceCubit(this.invoiceRepo) : super(AddSellInvoiceInitial());
  InvoiceRepoImpl invoiceRepo;
  Future<void> addSellInvoice() async {
    emit(AddSellInvoiceLoading());
    prepareAmountCurrency();
    Either<Failure, int> result;
    if (await transferAtOnce()) {
      result = await invoiceRepo.addSellInvoice(invoiceModel);
    } else {
      result = await StoreInvoices.storeSellInvoiceLocally(invoiceModel);
    }
    result.fold((failure) {
      emit(AddSellInvoiceFailure(errorMessage: failure.errMessage));
    }, (invoiceId) {
      emit(AddSellInvoiceSuccess(invoiceId: invoiceId));
    });
  }

  Future<bool> transferAtOnce() async {
    var result = await StoreInvoices.getInvoices(InvoiceType.sell.name);
    return result.fold((failure) {
      emit(AddSellInvoiceFailure(errorMessage: failure.errMessage));
      return false;
    }, (invoices) {
      if (invoices.isEmpty && StoreWorkOffline.getWorkOffline() == false) {
        return true;
      } else {
        return false;
      }
    });
  }

  void prepareAmountCurrency() {
    giveInvoiceModelData(
        invoicesAmountCurrencyId: currentCurrencyModel.businessCurrencyId);
    if (currentCurrencyModel.businessCurrencyIsBase == 0) {
      giveInvoiceModelData(
        invoicesAmountInBase:
            prepareInvoiceCurrency(invoiceModel.invoicesDiscountedAmount!),
        debtsPaidAmountInBase: invoiceModel.debtsPaidAmount == null
            ? null
            : prepareInvoiceCurrency(
                invoiceModel.debtsPaidAmount!,
              ),
        invoicesShippingCostInBase: invoiceModel.invoicesShippingCost == null
            ? null
            : prepareInvoiceCurrency(
                invoiceModel.invoicesShippingCost!,
              ),
      );
    }
  }

  String? get validateDataMessage {
    if (invoiceModel.invoicesClientId == null &&
        invoiceModel.invoicesPartnerId == null) {
      return "الرجاء اختيار عميل";
    } else if (invoiceModel.invoicesPartnerId != null &&
        invoiceModel.invoicesPaymentStatus != "paid") {
      return "الشريك يدفع من حسابه لذا اجعل حالة الدفع ك مدفوع";
    } else if (invoiceModel.invoicesPaymentStatus == "partial") {
      if (invoiceModel.debtsPaidAmount == null) {
        return "الرجاء ادخال القيمة المدفوعة";
      }
      if (invoiceModel.invoicesDiscountedAmount ==
          invoiceModel.debtsPaidAmount) {
        return "الرجاء تغيير حالة الدفع إلى مدفوع";
      }
      return null;
    } else {
      return null;
    }
  }

  void giveInvoiceModelData({
    int? invoicesId,
    int? invoicesClientId,
    int? debtsPaidAmountCurrencyId,
    int? invoicesPartnerId,
    String? invoicesType,
    double? invoicesUndiscountedAmount,
    double? invoicesDiscountedAmount,
    double? invoicesPaidAmount,
    double? invoicesShippingCost,
    double? invoicesShippingCostInBase,
    String? invoicesPaymentStatus,
    String? invoicesNotes,
    String? partnersName,
    double? invoicesTotalTaxAmount,
    String? invoicesCreatedAt,
    String? invoicesAppliedAt,
    int? invoicesBusinessId,
    String? clientsName,
    double? debtsPaidAmount,
    String? debtsDueDate,
    int? debtsInvoicesId,
    int? invoicesAmountCurrencyId, // Added property
    double? invoicesAmountInBase, // Added property
    double? debtsPaidAmountInBase, // Added property
    double? invoicesDiscountValue, // New property
    String? invoicesDiscountType, // New property
  }) {
    invoiceModel = invoiceModel.copyWith(
      invoicesId: invoicesId,
      invoicesAppliedAt: invoicesAppliedAt,
      partnersName: partnersName,
      invoicesPaidAmount: invoicesPaidAmount,
      invoicesClientId: invoicesClientId,
      debtsPaidAmountCurrencyId: debtsPaidAmountCurrencyId,
      invoicesPartnerId: invoicesPartnerId,
      invoicesTotalTaxAmount: invoicesTotalTaxAmount,
      invoicesType: invoicesType,
      invoicesUndiscountedAmount: invoicesUndiscountedAmount,
      invoicesDiscountedAmount: invoicesDiscountedAmount,
      invoicesShippingCost: invoicesShippingCost,
      invoicesShippingCostInBase: invoicesShippingCostInBase,
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
      invoicesAmountCurrencyId: invoicesAmountCurrencyId, // Added property
      invoicesAmountInBase: invoicesAmountInBase, // Added property
      debtsPaidAmountInBase: debtsPaidAmountInBase, // Added property
      invoicesDiscountValue: invoicesDiscountValue, // New property
      invoicesDiscountType: invoicesDiscountType, // New property
    );
  }
}
