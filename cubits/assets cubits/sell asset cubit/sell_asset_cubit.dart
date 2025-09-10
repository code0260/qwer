import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/assets%20repo/asset_repo_imp.dart';
import 'package:almonazim/data/model/asset%20models/sell_asset_model.dart';
import 'package:equatable/equatable.dart';

part 'sell_asset_state.dart';

class SellAssetCubit extends SafeCubit<SellAssetState> {
  SellAssetCubit(this.assetRepo)
      : super(const SellAssetInitial(hasDepreciation: true));
  AssetRepoImpl assetRepo;

  SellAssetModel sellAssetModel = SellAssetModel();

  Future<void> sellAsset() async {
    prepareBaseAmount();
    emit(SellAssetLoading());
    var result = await assetRepo.sellAsset(sellAssetModel);
    result.fold((failure) {
      emit(SellAssetFailure(errorMessage: failure.errMessage));
    }, (_) {
      emit(SellAssetSuccess());
    });
  }

  void prepareBaseAmount() {
    if (sellAssetModel.currencyId !=
        currencies
            .firstWhere(
              (element) => element.businessCurrencyIsBase == 1,
            )
            .businessCurrencyId) {
      sellAssetModel.amountInBase = convertAmountToBase(
          sellAssetModel.amount!, sellAssetModel.currencyId!);
    } else {
      sellAssetModel.amountInBase = null;
    }
  }

  String? get validateDataMessage {
    if (sellAssetModel.amount == null || sellAssetModel.amount == 0) {
      return "الرجاء إدخال تكلفة الأصل";
    } else if (sellAssetModel.currencyId == null) {
      return "الرجاء اختيار العملة";
    } else {
      return null;
    }
  }
}
