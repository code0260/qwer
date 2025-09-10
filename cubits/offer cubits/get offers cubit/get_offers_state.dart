part of 'get_offers_cubit.dart';

sealed class GetOfferState extends Equatable {
  const GetOfferState();

  @override
  List<Object> get props => [];
}

final class GetOfferInitial extends GetOfferState {}

class GetOfferLoading extends GetOfferState {}

class GetOfferFailure extends GetOfferState {
  final String errorMessage;

  const GetOfferFailure(this.errorMessage);
}

class GetOfferSuccess extends GetOfferState {
  final List<GetOfferModel> offers;
  const GetOfferSuccess({
    required this.offers,
  });
  @override
  List<Object> get props => [offers];
}
