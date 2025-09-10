part of 'add_categories_cubit.dart';

sealed class AddCategoriesState extends Equatable {
  const AddCategoriesState();

  @override
  List<Object> get props => [];
}

final class AddCategoriesInitial extends AddCategoriesState {}

class AddCategoriesLoading extends AddCategoriesState {}

class AddCategoriesFailure extends AddCategoriesState {
  final String errorMessage;

  const AddCategoriesFailure(this.errorMessage);
}

class AddCategoriesSuccess extends AddCategoriesState {
  const AddCategoriesSuccess();
}
