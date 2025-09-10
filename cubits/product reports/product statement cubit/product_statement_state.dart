part of 'product_statement_cubit.dart';

sealed class ProductStatementState extends Equatable {
  const ProductStatementState();

  @override
  List<Object> get props => [];
}

final class ProductStatementInitial extends ProductStatementState {}

class ProductStatementLoading extends ProductStatementState {}

class ProductStatementFailure extends ProductStatementState {
  final String errorMessage;

  const ProductStatementFailure(this.errorMessage);
}

class ProductStatementSuccess extends ProductStatementState {
  final ProductStatementModel statementModel;

  const ProductStatementSuccess({required this.statementModel});
}
