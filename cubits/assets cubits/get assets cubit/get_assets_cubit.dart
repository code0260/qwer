import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/assets%20repo/asset_repo.dart';
import 'package:almonazim/data/model/asset%20models/asset_model.dart';
import 'package:equatable/equatable.dart';

part 'get_assets_state.dart';

class GetAssetCubit extends SafeCubit<GetAssetState> {
  GetAssetCubit(this.assetRepo) : super(GetAssetInitial());
  AssetRepo assetRepo;
  Future<void> getAsset(AssetCategory assetCategory) async {
    emit(GetAssetLoading());
    var result = await assetRepo.getAssets(assetCategory);
    result.fold((failure) {
      emit(GetAssetFailure(failure.errMessage));
    }, (assets) {
      emit(GetAssetSuccess(assets: assets));
    });
  }
}
