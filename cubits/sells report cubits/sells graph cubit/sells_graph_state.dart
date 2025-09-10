part of 'sells_graph_cubit.dart';

sealed class SellsGraphState extends Equatable {
  const SellsGraphState();

  @override
  List<Object> get props => [];
}

final class SellsGraphInitial extends SellsGraphState {}

class SellsGraphLoading extends SellsGraphState {}

class SellsGraphFailure extends SellsGraphState {
  final String errorMessage;

  const SellsGraphFailure(this.errorMessage);
}

class SellsGraphSuccess extends SellsGraphState {
  final List<SellsGraphModel> sells;

  const SellsGraphSuccess({required this.sells});
}
