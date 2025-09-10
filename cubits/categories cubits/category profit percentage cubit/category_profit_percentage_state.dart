part of 'category_profit_percentage_cubit.dart';

sealed class CategoryProfitPercentageState extends Equatable {
  const CategoryProfitPercentageState();

  @override
  List<Object> get props => [];
}

final class CategoryProfitPercentageInitial
    extends CategoryProfitPercentageState {}

class CategoryProfitPercentageLoading extends CategoryProfitPercentageState {}

class CategoryProfitPercentageFailure extends CategoryProfitPercentageState {
  final String errorMessage;

  const CategoryProfitPercentageFailure(this.errorMessage);
}

class CategoryProfitPercentageSuccess extends CategoryProfitPercentageState {
  const CategoryProfitPercentageSuccess();
}
