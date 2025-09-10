part of 'refresh_business_cubit.dart';

sealed class RefreshBusinessState extends Equatable {
  const RefreshBusinessState();

  @override
  List<Object> get props => [];
}

final class RefreshBusinessInitial extends RefreshBusinessState {}

class RefreshBusinessLoading extends RefreshBusinessState {}

class RefreshBusinessFailure extends RefreshBusinessState {
  final String errorMessage;

  const RefreshBusinessFailure(this.errorMessage);
}

class RefreshBusinessSuccess extends RefreshBusinessState {}
