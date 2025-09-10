import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/cart%20models/buy_item_model.dart';
import 'package:almonazim/data/model/filter_model.dart';
import 'package:almonazim/data/model/invoice%20models/all_invoices_items_model.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';
import 'package:dartz/dartz.dart';

abstract class InvoiceRepo {
  Future<Either<Failure, int>> addSellInvoice(InvoiceModel invoiceModel);
  Future<Either<Failure, void>> addSellDraftInvoice(InvoiceModel invoiceModel);
  Future<Either<Failure, int>> addBuyInvoice(InvoiceModel invoiceModel);
  Future<Either<Failure, void>> addBuyDraftInvoice(InvoiceModel invoiceModel);
  Future<Either<Failure, void>> uploadAllBuyInvoices();
  Future<Either<Failure, void>> addRBCNIInvoice();
  Future<Either<Failure, void>> deleteInvoice(InvoiceModel invoiceModel);
  Future<Either<Failure, void>> editBuyInvoice(InvoiceModel invoiceModel,
      String? paymentStateWhenRefundOnly, bool? calculateRefundWithDiscount);
  Future<Either<Failure, List<InvoiceModel>>> getInvoices(
      FilterModel getInvoiceModel);
  Future<Either<Failure, Map>> getLatestInvoiceNumbers();
  Future<Either<Failure, AllInvoicesItemsModel>> getInvoicesItems(
      int invoiceId);
  Future<Either<Failure, List<BuyItemModel>>> getInvoiceDataForBuyEdit(
      int invoiceId);
  Future<Either<Failure, List<InvoiceModel>>> refreshInvoices(
      FilterModel filterModel);
  Future<Either<Failure, List<InvoiceModel>>> getInvoiceByNumber(
      String invoiceNumber, List<InvoiceType> invoiceType);
  Future<Either<Failure, List<SellItemModel>>> getInvoiceDataForSellEdit(
      int invoiceId);
  Future<Either<Failure, void>> editSellInvoice(InvoiceModel invoiceModel,
      String? paymentStateWhenRefundOnly, bool? calculateRefundWithDiscount);
  Future<Either<Failure, void>> addRSCNIInvoice(
      {int? clientId, int? partner, String? notes, required int buildingId});
  Future<Either<Failure, void>> uploadAllSellInvoices();
}
