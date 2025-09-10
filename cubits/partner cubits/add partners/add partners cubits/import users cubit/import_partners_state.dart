part of 'import_partners_cubit.dart';

sealed class ImportPartnersState extends Equatable {
  const ImportPartnersState();

  @override
  List<Object> get props => [];
}

final class ImportPartnersInitial extends ImportPartnersState {}

class ImportPartnersLoading extends ImportPartnersState {}

class ImportPartnersFailure extends ImportPartnersState {
  final String errorMessage;

  const ImportPartnersFailure({required this.errorMessage});
}

class ImportPartnersSuccess extends ImportPartnersState {}
