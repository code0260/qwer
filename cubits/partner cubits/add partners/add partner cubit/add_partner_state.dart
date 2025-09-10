part of 'add_partner_cubit.dart';

abstract class AddPartnerState extends Equatable {
  const AddPartnerState();

  @override
  List<Object?> get props => [];
}

class AddPartnerInitial extends AddPartnerState {}

class AddPartnerLoading extends AddPartnerState {}

class AddPartnerSuccess extends AddPartnerState {
  const AddPartnerSuccess();
}

class AddPartnerFailure extends AddPartnerState {
  final String errorMessage;

  const AddPartnerFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
