part of 'delete_categories_cubit.dart';

sealed class DeleteCategoriesState extends Equatable {
  const DeleteCategoriesState();

  @override
  List<Object> get props => [];
}

final class DeleteCategoriesInitial extends DeleteCategoriesState {}

class DeleteCategoriesLoading extends DeleteCategoriesState {}

class DeleteCategoriesFailure extends DeleteCategoriesState {
  final String errorMessage;

  const DeleteCategoriesFailure(this.errorMessage);
}

class DeleteCategoriesSuccess extends DeleteCategoriesState {}
