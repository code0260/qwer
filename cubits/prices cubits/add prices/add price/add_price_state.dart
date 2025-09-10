part of 'add_price_cubit.dart';

sealed class AddPriceState extends Equatable {
  const AddPriceState();

  @override
  List<Object> get props => [];
}

final class AddPriceInitial extends AddPriceState {}

class AddPriceLoading extends AddPriceState {}

class AddPriceFailure extends AddPriceState {
  final String errorMessage;

  const AddPriceFailure(this.errorMessage);
}

class AddPriceSuccess extends AddPriceState {
  const AddPriceSuccess();
}
