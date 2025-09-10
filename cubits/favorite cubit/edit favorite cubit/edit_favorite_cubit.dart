import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/Favorite%20repo/Favorite_repo.dart';
import 'package:almonazim/data/model/product%20models/product_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_favorite_state.dart';

class EditFavoriteCubit extends SafeCubit<EditFavoriteState> {
  EditFavoriteCubit(this.favoriteRepo) : super(EditFavoriteInitial());
  FavoriteRepo favoriteRepo;

  Future<void> deleteFavorite(ProductModel productModel) async {
    emit(EditFavoriteLoading());
    // This is done only for making the button becomes active fast but in real it needs time to add to the database
    productModel.favorite = 0;
    emit(EditFavoriteSuccess());
    var result = await favoriteRepo.deleteFavorite(productModel);
    result.fold((failure) {
      emit(EditFavoriteFailure(failure.errMessage));
    }, (favorite) {});
  }

  Future<void> addFavorite(ProductModel productModel) async {
    emit(EditFavoriteLoading());
    // This is done only for making the button becomes active fast but in real it needs time to add to the database
    productModel.favorite = 1;
    emit(EditFavoriteSuccess());
    var result = await favoriteRepo.addFavorite(productModel);
    result.fold((failure) {
      emit(EditFavoriteFailure(failure.errMessage));
    }, (favorite) {});
  }
}
