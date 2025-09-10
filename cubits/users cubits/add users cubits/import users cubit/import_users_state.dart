part of 'import_users_cubit.dart';

sealed class ImportUsersState extends Equatable {
  const ImportUsersState();

  @override
  List<Object> get props => [];
}

final class ImportUsersInitial extends ImportUsersState {}

class ImportUsersLoading extends ImportUsersState {}

class ImportUsersFailure extends ImportUsersState {
  final String errorMessage;

  const ImportUsersFailure({required this.errorMessage});
}

class ImportUsersSuccess extends ImportUsersState {}
