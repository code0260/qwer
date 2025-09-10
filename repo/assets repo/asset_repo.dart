import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/asset%20models/asset_input_model.dart';
import 'package:almonazim/data/model/asset%20models/asset_model.dart';
import 'package:almonazim/data/model/asset%20models/sell_asset_model.dart';
import 'package:dartz/dartz.dart';

abstract class AssetRepo {
  Future<Either<Failure, List<AssetModel>>> getAssets(
      AssetCategory assetCategory);
  Future<Either<Failure, void>> addAsset(AssetInputModel assetInputModel);
  Future<Either<Failure, void>> importAssets(String filePath);
  Future<Either<Failure, void>> sellAsset(SellAssetModel sellAssetModel);
}
