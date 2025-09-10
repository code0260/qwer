part of 'get_units_cubit.dart';

sealed class GetUnitState extends Equatable {
  const GetUnitState();

  @override
  List<Object> get props => [];
}

final class GetUnitInitial extends GetUnitState {}

class GetUnitLoading extends GetUnitState {}

class GetUnitFailure extends GetUnitState {
  final String errorMessage;

  const GetUnitFailure(this.errorMessage);
}

class GetUnitSuccess extends GetUnitState {
  final List<UnitModel> units;
  const GetUnitSuccess({
    required this.units,
  });
  @override
  // TODO: implement props
  List<Object> get props => [units];
}
