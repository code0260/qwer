part of 'refresh_products_cubit.dart';

sealed class RefreshProductState extends Equatable {
  const RefreshProductState();

  @override
  List<Object> get props => [];
}

final class RefreshProductInitial extends RefreshProductState {}

class RefreshProductLoading extends RefreshProductState {}

class RefreshProductFailure extends RefreshProductState {
  final String errorMessage;

  const RefreshProductFailure(this.errorMessage);
}

class RefreshProductSuccess extends RefreshProductState {}
