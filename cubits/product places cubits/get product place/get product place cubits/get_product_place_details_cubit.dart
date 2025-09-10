import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/product%20place%20repo/product_place_repo_imp.dart';
import 'package:almonazim/data/model/product%20place%20models/product_place_details_model.dart';
import 'package:equatable/equatable.dart';

part 'get_product_place_details_state.dart';

class GetProductPlaceDetailsCubit
    extends SafeCubit<GetProductPlaceDetailsState> {
  GetProductPlaceDetailsCubit(this.productPlaceRepoImpl)
      : super(GetProductPlaceDetailsInitial());
  ProductPlaceRepoImpl productPlaceRepoImpl;
  Future<void> getProductPlaceDetails(int productsId, int buildingsId) async {
    emit(GetProductPlaceDetailsLoading());
    var result = await productPlaceRepoImpl.getProductPlacesDetails(
        productsId, buildingsId);
    result.fold((failure) {
      emit(GetProductPlaceDetailsFailure(failure.errMessage));
    }, (details) {
      emit(GetProductPlaceDetailsSuccess(productPlaceDetails: details));
    });
  }
}
