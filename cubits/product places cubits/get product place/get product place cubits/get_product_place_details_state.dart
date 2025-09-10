part of 'get_product_place_details_cubit.dart';

sealed class GetProductPlaceDetailsState extends Equatable {
  const GetProductPlaceDetailsState();

  @override
  List<Object> get props => [];
}

final class GetProductPlaceDetailsInitial extends GetProductPlaceDetailsState {}

class GetProductPlaceDetailsLoading extends GetProductPlaceDetailsState {}

class GetProductPlaceDetailsFailure extends GetProductPlaceDetailsState {
  final String errorMessage;

  const GetProductPlaceDetailsFailure(this.errorMessage);
}

class GetProductPlaceDetailsSuccess extends GetProductPlaceDetailsState {
  final List<ProductPlaceDetailsModel> productPlaceDetails;
  const GetProductPlaceDetailsSuccess({required this.productPlaceDetails});
}
