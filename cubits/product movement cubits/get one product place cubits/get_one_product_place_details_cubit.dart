import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/product%20place%20repo/product_place_repo_imp.dart';
import 'package:almonazim/data/model/place%20models/place_input_model.dart';
import 'package:almonazim/data/model/product%20place%20models/product_place_details_model.dart';
import 'package:equatable/equatable.dart';

part 'get_one_product_place_details_state.dart';

class GetOneProductPlaceDetailsCubit
    extends SafeCubit<GetOneProductPlaceDetailsState> {
  GetOneProductPlaceDetailsCubit(this.productPlaceRepoImpl)
      : super(GetOneProductPlaceDetailsInitial());
  ProductPlaceRepoImpl productPlaceRepoImpl;
  PlaceInputModel placeInputModel = PlaceInputModel();
  Future<void> getProductPlaceDetails(int productsId) async {
    emit(GetOneProductPlaceDetailsLoading());
    var result = await productPlaceRepoImpl.getOneProductPlacesDetails(
        productsId, placeInputModel);
    result.fold((failure) {
      emit(GetOneProductPlaceDetailsFailure(failure.errMessage));
    }, (details) {
      emit(GetOneProductPlaceDetailsSuccess(productPlaceDetails: details));
    });
  }
}
