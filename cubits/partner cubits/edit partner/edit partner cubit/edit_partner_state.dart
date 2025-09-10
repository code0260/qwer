part of 'edit_partner_cubit.dart';

sealed class EditPartnerState extends Equatable {
  const EditPartnerState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class EditPartnerInitial extends EditPartnerState {}

class EditPartnerLoading extends EditPartnerState {}

class EditPartnerFailure extends EditPartnerState {
  final String errorMessage;

  const EditPartnerFailure(this.errorMessage);
}

class EditPartnerSuccess extends EditPartnerState {}
