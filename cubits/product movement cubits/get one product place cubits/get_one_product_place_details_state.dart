part of 'get_one_product_place_details_cubit.dart';

sealed class GetOneProductPlaceDetailsState extends Equatable {
  const GetOneProductPlaceDetailsState();

  @override
  List<Object> get props => [];
}

final class GetOneProductPlaceDetailsInitial
    extends GetOneProductPlaceDetailsState {}

class GetOneProductPlaceDetailsLoading extends GetOneProductPlaceDetailsState {}

class GetOneProductPlaceDetailsFailure extends GetOneProductPlaceDetailsState {
  final String errorMessage;

  const GetOneProductPlaceDetailsFailure(this.errorMessage);
}

class GetOneProductPlaceDetailsSuccess extends GetOneProductPlaceDetailsState {
  final ProductPlaceDetailsModel productPlaceDetails;
  const GetOneProductPlaceDetailsSuccess({required this.productPlaceDetails});
}
