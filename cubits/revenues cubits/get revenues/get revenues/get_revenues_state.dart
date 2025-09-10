part of 'get_revenues_cubit.dart';

sealed class GetRevenuesState extends Equatable {
  const GetRevenuesState();

  @override
  List<Object> get props => [];
}

final class GetRevenuesInitial extends GetRevenuesState {}

class GetRevenuesLoading extends GetRevenuesState {}

class GetRevenuesFailure extends GetRevenuesState {
  final String errorMessage;

  const GetRevenuesFailure(this.errorMessage);
}

class GetRevenuesSuccess extends GetRevenuesState {
  final GetRevenuesModel getRevenuesModel;
  const GetRevenuesSuccess({
    required this.getRevenuesModel,
  });
}
