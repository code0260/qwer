import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/search%20repo/search%20product%20repo/search_product_repo.dart';
import 'package:almonazim/data/model/cart%20models/buy_item_model.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';
import 'package:almonazim/data/model/inventory%20adjustment%20models/inventory_adjustment_data_model.dart';
import 'package:almonazim/data/model/product%20models/product_input_model.dart';
import 'package:almonazim/data/model/product%20models/product_model.dart';
import 'package:dartz/dartz.dart';

class SearchProductRepoImpl implements SearchProductRepo {
  ApiService apiService;
  SearchProductRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<BuyItemModel>>> getBuyProductsBySearch(
      String searchQuery) async {
    var result = await apiService.post(
      url: AppLinks.searchBuyProductLink,
      data: {"search": searchQuery},
    );

    return result.fold((failure) {
      return left(failure);
    }, (response) {
      for (final item in response["data"]) {
        searchBuyData.add(BuyItemModel.fromJson(item));
      }
      return right(searchBuyData);
    });
  }

  @override
  Future<Either<Failure, List<BuyItemModel>>> getBuyEditProductsBySearch(
      String searchQuery) async {
    var result = await apiService.post(
      url: AppLinks.searchBuyProductLink,
      data: {"search": searchQuery},
    );

    return result.fold((failure) {
      return left(failure);
    }, (response) {
      for (final item in response["data"]) {
        searchBuyEditData.add(BuyItemModel.fromJson(item));
      }
      return right(searchBuyEditData);
    });
  }

  @override
  Future<Either<Failure, List<BuyItemModel>>> getBuyBarcodeBySearch(
      String barcode) async {
    var result = await apiService.post(
      url: AppLinks.searchBuyBarcodeLink,
      data: {"barcode": barcode},
    );

    return result.fold((failure) {
      return left(failure);
    }, (response) {
      List<BuyItemModel> products = [];
      for (final product in response["data"]) {
        products.add(BuyItemModel.fromJson(product));
      }
      return right(products);
    });
  }

  @override
  Future<Either<Failure, List<SellItemModel>>> getSellBarcodeBySearch(
      String barcode) async {
    var result = await apiService.post(
      url: AppLinks.searchSellBarcodeLink,
      data: {"barcode": barcode},
    );

    return result.fold((failure) {
      return left(failure);
    }, (response) {
      List<SellItemModel> products = [];
      for (final product in response["data"]) {
        products.add(SellItemModel.fromJson(product));
      }
      return right(products);
    });
  }

  @override
  Future<Either<Failure, List<SellItemModel>>> getSellEditProductsBySearch(
      String searchQuery) async {
    var result = await apiService.post(
      url: AppLinks.searchSellProductLink,
      data: {"search": searchQuery},
    );
    return result.fold((failure) {
      return left(failure);
    }, (response) {
      for (final item in response["data"]) {
        searchSellEditData.add(SellItemModel.fromJson(item));
      }
      return right(searchSellEditData);
    });
  }

  @override
  Future<Either<Failure, List<BuyItemModel>>> getRBCNIProductsBySearch(
      String searchQuery) async {
    var result = await apiService.post(
      url: AppLinks.searchBuyProductLink,
      data: {"search": searchQuery},
    );

    return result.fold((failure) {
      return left(failure);
    }, (response) {
      for (final item in response["data"]) {
        searchRBCNIData.add(BuyItemModel.fromJson(item));
      }
      return right(searchRBCNIData);
    });
  }

  @override
  Future<Either<Failure, List<SellItemModel>>> getRSCNIProductsBySearch(
      String? searchQuery, String? barcode) async {
    var result = await apiService.post(
      url: AppLinks.searchRSCNIProductLink,
      data: {
        if (searchQuery != null) "search": searchQuery,
        if (barcode != null) "barcode": barcode,
      },
    );

    return result.fold((failure) {
      return left(failure);
    }, (response) {
      for (final item in response["data"]) {
        searchRSCNIData.add(SellItemModel.fromJson(item));
      }
      return right(searchRSCNIData);
    });
  }

  @override
  Future<Either<Failure, List<SellItemModel>>> getSellProductsBySearch(
      String searchQuery) async {
    var result = await apiService.post(
      url: AppLinks.searchSellProductLink,
      data: {"search": searchQuery},
    );

    return result.fold((failure) {
      return left(failure);
    }, (response) {
      for (final item in response["data"]) {
        searchSellData.add(SellItemModel.fromJson(item));
      }
      return right(searchSellData);
    });
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts(
      ProductInputModel productInputModel) async {
    final result = await apiService.post(
      url: AppLinks.searchProductLink,
      formDataIsEnabled: false,
      data: productInputModel.toMap(),
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        final List<ProductModel> products = response["data"]
            .map<ProductModel>((product) => ProductModel.fromJson(product))
            .toList();
        return right(products);
      },
    );
  }

  @override
  Future<Either<Failure, List<InventoryAdjustmentDataModel>>>
      getInventoryAdjustmentProductsBySearch(String searchQuery) async {
    var result = await apiService.post(
      url: AppLinks.searchInventoryAdjustmentProductLink,
      data: {"search": searchQuery},
    );

    return result.fold((failure) {
      return left(failure);
    }, (response) {
      for (final item in response["data"]) {
        searchInventoryAdjustmentData
            .add(InventoryAdjustmentDataModel.fromMap(item));
      }
      return right(searchInventoryAdjustmentData);
    });
  }

  @override
  Future<Either<Failure, List<InventoryAdjustmentDataModel>>>
      getInventoryAdjustmentBarcodeProductsBySearch(String barcode) async {
    var result = await apiService.post(
      url: AppLinks.searchInventoryAdjustmentProductLink,
      data: {"barcode": barcode},
    );

    return result.fold((failure) {
      return left(failure);
    }, (response) {
      for (final item in response["data"]) {
        searchInventoryAdjustmentData
            .add(InventoryAdjustmentDataModel.fromJson(item));
      }
      return right(searchInventoryAdjustmentData);
    });
  }
}
