part of 'get_partners_cubit.dart';

sealed class GetPartnerState extends Equatable {
  const GetPartnerState();

  @override
  List<Object> get props => [];
}

final class GetPartnerInitial extends GetPartnerState {}

class GetPartnerLoading extends GetPartnerState {}

class GetPartnerFailure extends GetPartnerState {
  final String errorMessage;

  const GetPartnerFailure(this.errorMessage);
}

class GetPartnerSuccess extends GetPartnerState {
  final List<PartnerModel> partners;
  const GetPartnerSuccess({
    required this.partners,
  });
  @override
  // TODO: implement props
  List<Object> get props => [partners];
}
