part of 'edit_categories_cubit.dart';

sealed class EditCategoriesState extends Equatable {
  const EditCategoriesState();

  @override
  List<Object> get props => [];
}

final class EditCategoriesInitial extends EditCategoriesState {}

class EditCategoriesLoading extends EditCategoriesState {}

class EditCategoriesFailure extends EditCategoriesState {
  final String errorMessage;

  const EditCategoriesFailure(this.errorMessage);
}

class EditCategoriesSuccess extends EditCategoriesState {}
