part of 'import_categories_cubit.dart';

sealed class ImportCategoriesState extends Equatable {
  const ImportCategoriesState();

  @override
  List<Object> get props => [];
}

final class ImportCategoriesInitial extends ImportCategoriesState {}

class ImportCategoriesLoading extends ImportCategoriesState {}

class ImportCategoriesFailure extends ImportCategoriesState {
  final String errorMessage;

  const ImportCategoriesFailure({required this.errorMessage});
}

class ImportCategoriesSuccess extends ImportCategoriesState {}
