import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_prices.dart';
import 'package:almonazim/data/data%20source/locale/store_insert_date_steps.dart';
import 'package:almonazim/data/data%20source/repo/prices%20repo/prices_repo.dart';
import 'package:almonazim/data/model/price%20models/all_prices_model.dart';
import 'package:almonazim/data/model/price%20models/prices_input_model.dart';
import 'package:dartz/dartz.dart';

class PricesRepoImpl implements PricesRepo {
  final ApiService apiService;

  PricesRepoImpl(this.apiService);

  @override
  Future<Either<Failure, void>> getSellPrices() async {
    var result = await apiService.get(url: AppLinks.getSellPricesLink);

    return result.fold((failure) => left(failure), (response) async {
      //& price
      List<int> priceIds = [];
      for (final price in response["data"]) {
        priceIds.add(price['prices_id']);
        await StorePrices.updatePriceData(price);
      }
      await StorePrices.deletePricesViaIdList(priceIds);
      return right(null);
    });
  }

  @override
  Future<Either<Failure, AllPricesModel>> getPricesInfo(
      PriceInputModel priceInputModel) async {
    var result = await apiService.post(
        url: AppLinks.getProductPricesLink,
        data: priceInputModel.toMap(),
        formDataIsEnabled: false);

    return result.fold(
      (failure) => left(failure),
      (response) => right(AllPricesModel.formJson(response["data"])),
    );
  }

  @override
  Future<Either<Failure, void>> addPrice(
      PriceInputModel priceInputModel) async {
    // print(priceInputModel.toMap());
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.addPriceLink,
        data: priceInputModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
    // return left(ServerFailure('errMessage'));
  }

  @override
  Future<Either<Failure, void>> importPrices(String filePath) async {
    final result = await apiService.uploadFile(
        url: AppLinks.importPricesLink,
        requestName: "prices_excel_file",
        filePath: filePath);

    return result.fold(
      (failure) => left(failure),
      (response) {
        StoreInsertDateSteps.addStep("5");
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, Map>> getRelatedPricesIds(
      List<PriceInputModel> prices) async {
    var data = {
      "prices": prices
          .map(
            (clientModel) => clientModel.toMap(),
          )
          .toList()
    };
    // print(data);
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.getRelatedPricesIdsLink,
        data: data);

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(response["data"]);
      },
    );
    // return left(ServerFailure('test'));
  }
}
