import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/sync%20offline%20data/sync_offline_sell_prices.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/upload%20buy%20invoice/prepare_buy_data.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/upload%20buy%20invoice/prepare_buy_draft_data.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/upload%20buy%20invoice/prepare_upload_all_buy_invoices.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/upload%20sell%20invoice/prepare_sell_data.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/upload%20sell%20invoice/prepare_sell_draft_data.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/upload%20sell%20invoice/prepare_upload_all_sell_invoices.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_invoices.dart';
import 'package:almonazim/data/data%20source/locale/store_latest_invoice_number.dart';
import 'package:almonazim/data/data%20source/repo/invoice%20repo/invoice_repo.dart';
import 'package:almonazim/data/model/cart%20models/buy_item_model.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';
import 'package:almonazim/data/model/filter_model.dart';
import 'package:almonazim/data/model/invoice%20models/all_invoices_items_model.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:dartz/dartz.dart';

class InvoiceRepoImpl implements InvoiceRepo {
  ApiService apiService;
  InvoiceRepoImpl(this.apiService);

  @override
  Future<Either<Failure, int>> addBuyInvoice(InvoiceModel invoiceModel) async {
    String data = '';
    try {
      data = await prepareBuyData(invoiceModel);
      // print(data);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
    var result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.insertBuyInvoiceLink,
        data: data);

    return result.fold((failure) => left(failure), (response) async {
      await StoreInvoiceNumber.setLatestInvoiceNumber(
          invoiceModel.invoicesType!,
          response["data"]["latest_invoice_number"]);
      return right((response["data"]["invoices_id"] as String).toInt());
    });
    // return left(ServerFailure('test'));
  }

  @override
  Future<Either<Failure, void>> addBuyDraftInvoice(
      InvoiceModel invoiceModel) async {
    String data = '';
    try {
      data = await prepareBuyDraftData(invoiceModel);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
    // print(data);
    var result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.insertBuyInvoiceLink,
        data: data);

    return result.fold((failure) => left(failure), (response) async {
      await StoreInvoices.deleteInvoice(invoiceModel.invoicesId!);
      await StoreInvoiceNumber.setLatestInvoiceNumber(
          invoiceModel.invoicesType!,
          response["data"]["latest_invoice_number"]);
      cartBuyHome.clear();
      return right(null);
    });
    // return right(null);
  }

  @override
  Future<Either<Failure, void>> uploadAllBuyInvoices() async {
    String data = '';
    try {
      data = await prepareUploadAllBuyInvoices();
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
    // print(data);
    var result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.uploadAllBuyInvoiceLink,
        data: data);
    return result.fold((failure) => left(failure), (response) async {
      try {
        for (final (invoiceId as int) in response['uploadedInvoices']) {
          await StoreInvoices.deleteInvoice(invoiceId);
        }
        if (response['latest_invoice_number'] != null) {
          await StoreInvoiceNumber.setLatestInvoiceNumber(
              'buy', response["latest_invoice_number"]);
        }
        if (response['message'] != null) {
          return left(ServerFailure(response['message']));
        }
      } catch (e) {
        return left(ServerFailure(e.toString()));
      }
      return right(null);
    });
    // return left(ServerFailure("test"));
  }

  @override
  Future<Either<Failure, void>> addSellDraftInvoice(
      InvoiceModel invoiceModel) async {
    String data = '';
    try {
      data = await prepareSellDraftData(invoiceModel);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
    // print(data);
    var result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.insertDraftSellInvoiceLink,
        data: data);
    cartSellHome.clear();
    return result.fold((failure) => left(failure), (response) async {
      try {
        await StoreInvoices.deleteInvoice(invoiceModel.invoicesId!);
        await StoreInvoiceNumber.setLatestInvoiceNumber(
            invoiceModel.invoicesType!,
            response["data"]["latest_invoice_number"]);
        await syncOfflineSellPrices();
      } catch (e) {
        return left(ServerFailure(e.toString()));
      }
      return right(null);
    });
    // return left(ServerFailure("test"));
  }

  @override
  Future<Either<Failure, void>> uploadAllSellInvoices() async {
    String data = '';
    try {
      data = await prepareUploadAllSellInvoices();
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
    // print(data);
    var result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.uploadAllSellInvoiceLink,
        data: data);
    return result.fold((failure) => left(failure), (response) async {
      try {
        for (final (invoiceId as int) in response['uploadedInvoices']) {
          await StoreInvoices.deleteInvoice(invoiceId);
        }
        if (response['latest_invoice_number'] != null) {
          await StoreInvoiceNumber.setLatestInvoiceNumber(
              'sell', response["latest_invoice_number"]);
        }
        if (response['message'] != null) {
          return left(ServerFailure(response['message']));
        }
        await syncOfflineSellPrices();
      } catch (e) {
        return left(ServerFailure(e.toString()));
      }
      return right(null);
    });
    // return left(ServerFailure("test"));
  }

  @override
  Future<Either<Failure, int>> addSellInvoice(InvoiceModel invoiceModel) async {
    String data = '';
    try {
      data = await prepareSellData(invoiceModel);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
    var result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.insertSellInvoiceLink,
        data: data);
    return result.fold((failure) => left(failure), (response) async {
      await StoreInvoiceNumber.setLatestInvoiceNumber(
          invoiceModel.invoicesType!,
          response["data"]["latest_invoice_number"]);
      return right((response["data"]["invoices_id"] as String).toInt());
    });
    // return left(ServerFailure("d"));
  }

  @override
  Future<Either<Failure, void>> addRBCNIInvoice() async {
    // print(rBCNIHome
    //     .map(
    //       (e) => e.toMap(),
    //     )
    //     .toList());
    var result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.addRBCNIInvoice,
        data: rBCNIHome
            .map(
              (e) => e.toMap(),
            )
            .toList());

    return result.fold((failure) => left(failure), (response) {
      return right(null);
    });
    // return right(null);
  }

  @override
  Future<Either<Failure, void>> addRSCNIInvoice(
      {int? clientId,
      int? partner,
      String? notes,
      required int buildingId}) async {
    // print(rSCNIHome
    //     .map(
    //       (e) => e.toMap(),
    //     )
    //     .toList());
    var result = await apiService
        .post(formDataIsEnabled: false, url: AppLinks.addRSCNIInvoice, data: {
      "data": rSCNIHome
          .map(
            (e) => e.toMap(),
          )
          .toList(),
      "clients_id": clientId,
      "partners_id": partner,
      "buildings_id": buildingId,
      "notes": notes,
    });

    return result.fold((failure) => left(failure), (response) {
      return right(null);
    });
    // return right(null);
  }

  @override
  Future<Either<Failure, void>> deleteInvoice(InvoiceModel invoiceModel) async {
    var result = await apiService.post(url: AppLinks.deleteInvoicesLink, data: {
      "invoices_id": invoiceModel.invoicesId,
    });

    return result.fold((failure) {
      return left(failure);
    }, (response) {
      return right(null);
    });
  }

  @override
  Future<Either<Failure, List<InvoiceModel>>> getInvoiceByNumber(
      String invoiceNumber, List<InvoiceType> invoiceType) async {
    var result = await apiService.post(
        url: AppLinks.getInvoicesByNumberLink,
        formDataIsEnabled: false,
        data: {
          "invoices_number": invoiceNumber,
          "invoices_type": invoiceType
              .map(
                (e) => e.name,
              )
              .toList(),
        });

    return result.fold((failure) {
      return left(failure);
    }, (response) {
      List<InvoiceModel> invoicesLocale = [];
      for (final invoice in response["data"]) {
        invoicesLocale.add(InvoiceModel.fromJson(invoice));
      }
      return right(invoicesLocale);
    });
  }

  @override
  Future<Either<Failure, List<InvoiceModel>>> getInvoices(
      FilterModel filterModel) async {
    if (!invoices.containsKey(filterModel)) {
      var result = await apiService.post(
          formDataIsEnabled: false,
          url: AppLinks.getInvoicesLink,
          data: filterModel.toServer());

      return result.fold((failure) {
        return left(failure);
      }, (response) {
        if (invoices.length > 10) {
          invoices.clear();
        }
        List<InvoiceModel> invoicesLocale = [];
        for (final invoice in response["data"]) {
          invoicesLocale.add(InvoiceModel.fromJson(invoice));
        }
        invoices[filterModel] = invoicesLocale;
        return right(invoices[filterModel]!);
      });
    } else {
      return right(invoices[filterModel]!);
    }
  }

  @override
  Future<Either<Failure, Map>> getLatestInvoiceNumbers() async {
    var result =
        await apiService.get(url: AppLinks.getLatestInvoiceNumbersLink);

    return result.fold((failure) {
      return left(failure);
    }, (response) async {
      for (final entry in (response["data"] as Map).entries) {
        await StoreInvoiceNumber.setLatestInvoiceNumber(entry.key, entry.value);
      }
      return right(response);
    });
  }

  @override
  Future<Either<Failure, AllInvoicesItemsModel>> getInvoicesItems(
      int invoiceId) async {
    var result = await apiService.post(
        url: AppLinks.getInvoicesItemsLink, data: {"invoices_id": invoiceId});

    return result.fold((failure) {
      return left(failure);
    }, (response) {
      return right(AllInvoicesItemsModel.fromJson(response["data"]));
    });
  }

  @override
  Future<Either<Failure, List<BuyItemModel>>> getInvoiceDataForBuyEdit(
      int invoiceId) async {
    var result = await apiService.post(
        url: AppLinks.getInvoiceDataForBuyEditLink,
        data: {"invoices_id": invoiceId});

    return result.fold((failure) {
      return left(failure);
    }, (response) {
      List<BuyItemModel> list = [];
      for (final item in response["data"]) {
        cartBuyEditOriginalHome.add(BuyItemModel.fromJson(item));
        list.add(BuyItemModel.fromJson(item));
      }
      return right(list);
    });
  }

  @override
  Future<Either<Failure, List<SellItemModel>>> getInvoiceDataForSellEdit(
      int invoiceId) async {
    var result = await apiService.post(
        url: AppLinks.getInvoiceDataForSellEditLink,
        data: {"invoices_id": invoiceId});

    return result.fold((failure) {
      return left(failure);
    }, (response) {
      List<SellItemModel> list = [];
      for (final item in response["data"]) {
        cartSellEditOriginalHome.add(SellItemModel.fromJson(item));
        list.add(SellItemModel.fromJson(item));
      }
      return right(list);
    });
  }

  @override
  Future<Either<Failure, List<InvoiceModel>>> refreshInvoices(
      FilterModel filterModel) async {
    invoices.clear();
    var result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.getInvoicesLink,
        data: filterModel.toServer());

    return result.fold((failure) {
      return left(failure);
    }, (response) {
      List<InvoiceModel> invoicesLocale = [];
      for (final invoice in response["data"]) {
        invoicesLocale.add(InvoiceModel.fromJson(invoice));
      }
      invoices[filterModel] = invoicesLocale;
      return right(invoices[filterModel]!);
    });
  }

  @override
  Future<Either<Failure, void>> editBuyInvoice(
      InvoiceModel invoiceModel,
      String? paymentStateWhenRefundOnly,
      bool? calculateRefundWithDiscount) async {
    var data = {
      "invoice": invoiceModel.toJson(),
      "payment_state_when_refund_only": paymentStateWhenRefundOnly,
      "calculate_refund_with_discount": calculateRefundWithDiscount,
      "buyItemModels": cartBuyEditHome
          .map(
            (e) => e.toMap(),
          )
          .toList()
    };
    // print(data);
    var result = await apiService.post(
        url: AppLinks.editBuyInvoicesLink,
        formDataIsEnabled: false,
        data: data);

    return result.fold((failure) {
      return left(failure);
    }, (response) {
      return right(null);
    });
    // return right(null);
  }

  @override
  Future<Either<Failure, void>> editSellInvoice(
      InvoiceModel invoiceModel,
      String? paymentStateWhenRefundOnly,
      bool? calculateRefundWithDiscount) async {
    var data = {
      "invoice": invoiceModel.toJson(),
      "payment_state_when_refund_only": paymentStateWhenRefundOnly,
      "calculate_refund_with_discount": calculateRefundWithDiscount,
      "sellItemModels": cartSellEditHome
          .map(
            (e) => e.toMap(),
          )
          .toList()
    };
    // print(data);
    var result = await apiService.post(
        url: AppLinks.editSellInvoicesLink,
        formDataIsEnabled: false,
        data: data);

    return result.fold((failure) {
      return left(failure);
    }, (response) {
      return right(null);
    });
    // return right(null);
  }
}
