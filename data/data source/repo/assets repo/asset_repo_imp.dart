import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/asset%20functions/prepare%20data/prepare_add_asset_data.dart';
import 'package:almonazim/core/helper/functions/asset%20functions/prepare%20data/prepare_sell_asset_data.dart';
import 'package:almonazim/data/data%20source/locale/store_insert_date_steps.dart';
import 'package:almonazim/data/data%20source/repo/assets%20repo/asset_repo.dart';
import 'package:almonazim/data/model/asset%20models/asset_input_model.dart';
import 'package:almonazim/data/model/asset%20models/asset_model.dart';
import 'package:almonazim/data/model/asset%20models/sell_asset_model.dart';
import 'package:dartz/dartz.dart';

class AssetRepoImpl implements AssetRepo {
  final ApiService apiService;
  AssetRepoImpl(this.apiService);

  @override
  Future<Either<Failure, void>> addAsset(
      AssetInputModel assetInputModel) async {
    final result = await apiService.post(
        url: AppLinks.addOneAssetLink,
        formDataIsEnabled: false,
        data: prepareAddAssetData(assetInputModel));

    return result.fold(
      (failure) => left(failure),
      (response) => right(null),
    );
  }

  @override
  Future<Either<Failure, void>> sellAsset(SellAssetModel sellAssetModel) async {
    // print(prepareSellAssetData(sellAssetModel));
    final result = await apiService.post(
        url: AppLinks.sellAssetLink,
        formDataIsEnabled: false,
        data: prepareSellAssetData(sellAssetModel));

    return result.fold(
      (failure) => left(failure),
      (response) => right(null),
    );
    // return left(ServerFailure('test'));
  }

  @override
  Future<Either<Failure, void>> importAssets(String filePath) async {
    final result = await apiService.uploadFile(
        url: AppLinks.importAssetsLink,
        requestName: "assets_excel_file",
        filePath: filePath);

    return result.fold(
      (failure) => left(failure),
      (response) {
        StoreInsertDateSteps.addStep("2");
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, List<AssetModel>>> getAssets(
      AssetCategory assetCategory) async {
    final result = await apiService.post(
      url: AppLinks.getAssetsLink,
      data: {
        "assets_category": assetCategory.name,
      },
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<AssetModel> assets = [];
        for (final asset in response['data']) {
          assets.add(AssetModel.fromJson(asset));
        }
        return right(assets);
      },
    );
  }
}
