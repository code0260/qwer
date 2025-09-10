part of 'edit_favorite_cubit.dart';

sealed class EditFavoriteState extends Equatable {
  const EditFavoriteState();

  @override
  List<Object> get props => [];
}

final class EditFavoriteInitial extends EditFavoriteState {}

class EditFavoriteLoading extends EditFavoriteState {}

class EditFavoriteFailure extends EditFavoriteState {
  final String errorMessage;

  const EditFavoriteFailure(this.errorMessage);
}

class EditFavoriteSuccess extends EditFavoriteState {}
