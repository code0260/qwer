import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/prepare_invoice_currency.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_invoices.dart';
import 'package:almonazim/data/data%20source/locale/store_default_invoice_payment_status.dart';
import 'package:almonazim/data/data%20source/locale/store_latest_invoice_number.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/data%20source/repo/invoice%20repo/invoice_repo_imp.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'add_buy_invoice_state.dart';

class AddBuyInvoiceCubit extends SafeCubit<AddBuyInvoiceState> {
  InvoiceModel invoiceModel = InvoiceModel(
      invoicesType: "buy",
      invoicesNumber: StoreInvoiceNumber.getAfterLatestInvoiceNumber("buy"),
      invoicesPaymentStatus:
          StoreDefaultInvoicePaymentStatus.getDefaultInvoicePaymentStatus());
  AddBuyInvoiceCubit(this.invoiceRepo) : super(AddBuyInvoiceInitial());
  InvoiceRepoImpl invoiceRepo;

  Future<void> addBuyInvoice() async {
    emit(AddBuyInvoiceLoading());
    prepareAmountCurrency();
    Either<Failure, int> result;
    if (await transferAtOnce()) {
      result = await invoiceRepo.addBuyInvoice(invoiceModel);
    } else {
      result = await StoreInvoices.storeBuyInvoiceLocally(invoiceModel);
    }
    result.fold((failure) {
      emit(AddBuyInvoiceFailure(errorMessage: failure.errMessage));
    }, (invoiceId) {
      emit(AddBuyInvoiceSuccess(invoiceId: invoiceId));
    });
  }

  Future<bool> transferAtOnce() async {
    var result = await StoreInvoices.getInvoices(InvoiceType.buy.name);
    return result.fold((failure) {
      emit(AddBuyInvoiceFailure(errorMessage: failure.errMessage));
      return false;
    }, (invoices) {
      if (invoices.isEmpty && StoreWorkOffline.getWorkOffline() == false) {
        return true;
      } else {
        return false;
      }
    });
  }

  String? get validateDataMessage {
    if (invoiceModel.invoicesClientId == null) {
      return "الرجاء اختيار عميل";
    } else if (invoiceModel.invoicesPaymentStatus == "partial") {
      if (invoiceModel.debtsPaidAmount == null) {
        return "الرجاء ادخال القيمة المدفوعة";
      }
      if (invoiceModel.invoicesDiscountedAmount ==
          invoiceModel.debtsPaidAmount) {
        return "الرجاء تغيير حالة الدفع إلى مدفوع";
      }
      // if (invoiceModel.debtsDueDate == null) { // for future I can put in setting of obligated to add the due date or not
      //   return "الرجاء ادخال  تاريخ الاستحقاق";
      // }
    } else if (invoiceModel.invoicesPaymentStatus == "unpaid") {
      // if (invoiceModel.debtsDueDate == null) { // for future I can put in setting of obligated to add the due date or not
      //   return "الرجاء ادخال  تاريخ الاستحقاق";
      // }
    } else {
      return null;
    }
    return null;
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
      );
    }

    if (invoiceModel.invoicesShippingCost != 0 &&
        invoiceModel.invoicesShippingCost != null) {
      double costInBase = convertAmountToBase(
          invoiceModel.invoicesShippingCost!,
          invoiceModel.invoicesShippingCurrencyId!);
      if (costInBase != invoiceModel.invoicesShippingCost) {
        giveInvoiceModelData(invoicesShippingCostInBase: costInBase);
      }
    }
  }

  void editClient(int id, String name) {
    emit(AddBuyClientChangedInvoiceSuccess(clientId: id));
  }

  void giveInvoiceModelData({
    int? invoicesId,
    int? invoicesClientId,
    int? debtsPaidAmountCurrencyId,
    String? invoicesType,
    double? invoicesUndiscountedAmount,
    double? invoicesDiscountedAmount,
    double? invoicesPaidAmount,
    double? invoicesShippingCost,
    double? invoicesShippingCostInBase,
    String? invoicesPaymentStatus,
    String? invoicesShippingPayment,
    String? invoicesNotes,
    String? invoicesCreatedAt,
    String? invoicesAppliedAt,
    int? invoicesBusinessId,
    String? clientsName,
    double? debtsPaidAmount,
    String? debtsDueDate,
    int? debtsInvoicesId,
    double? invoicesTotalTaxAmount, // Added property
    int? invoicesAmountCurrencyId, // Added property
    double? invoicesAmountInBase, // Added property
    double? debtsPaidAmountInBase, // Added property
    int? invoicesShippingClientId,
    int? invoicesShippingCurrencyId, // New property
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
      invoicesShippingCostInBase: invoicesShippingCostInBase,
      invoicesPaymentStatus: invoicesPaymentStatus,
      invoicesShippingPayment: invoicesShippingPayment,
      invoicesNotes: invoicesNotes != null && invoicesNotes.isNotEmpty
          ? invoicesNotes
          : null,
      invoicesPaidAmount: invoicesPaidAmount,
      invoicesCreatedAt: invoicesCreatedAt,
      invoicesBusinessId: invoicesBusinessId,
      clientsName: clientsName,
      debtsPaidAmount: debtsPaidAmount,
      debtsDueDate: debtsDueDate,
      debtsInvoicesId: debtsInvoicesId,
      invoicesTotalTaxAmount: invoicesTotalTaxAmount, // Added property
      invoicesAmountCurrencyId: invoicesAmountCurrencyId, // Added property
      invoicesAmountInBase: invoicesAmountInBase, // Added property
      debtsPaidAmountInBase: debtsPaidAmountInBase, // Added property
      invoicesShippingClientId: invoicesShippingClientId,
      invoicesShippingCurrencyId: invoicesShippingCurrencyId,
      invoicesDiscountValue: invoicesDiscountValue, // New property
      invoicesDiscountType: invoicesDiscountType, // New property
    );
  }
}
