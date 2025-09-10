part of 'edit_reorder_point _cubit.dart';

sealed class EditReorderPointState extends Equatable {
  const EditReorderPointState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class EditReorderPointInitial extends EditReorderPointState {}

class EditReorderPointLoading extends EditReorderPointState {}

class EditReorderPointFailure extends EditReorderPointState {
  final String errorMessage;

  const EditReorderPointFailure(this.errorMessage);
}

class EditReorderPointSuccess extends EditReorderPointState {}
