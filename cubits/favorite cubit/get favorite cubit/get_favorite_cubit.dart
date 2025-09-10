import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/favorite%20repo/favorite_repo_impl.dart';
import 'package:almonazim/data/model/product%20models/product_model.dart';
import 'package:equatable/equatable.dart';

part 'get_favorite_state.dart';

class GetFavoriteCubit extends SafeCubit<GetFavoriteState> {
  GetFavoriteCubit(this.favoriteRepo) : super(GetFavoriteInitial());
  FavoriteRepoImpl favoriteRepo;

  Future<void> getFavorite({required bool isWantedMore}) async {
    emit(GetFavoriteLoading());
    var result = await favoriteRepo.getFavorite(isWantedMore);
    result.fold((failure) {
      emit(GetFavoriteFailure(failure.errMessage));
    }, (products) {
      emit(GetFavoriteSuccess(products: products));
    });
  }

  @override
  Future<void> close() {
    favoritesMap.clear();
    return super.close();
  }
}
