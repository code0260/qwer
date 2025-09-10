part of 'add_feedback_cubit.dart';

sealed class AddFeedbackState extends Equatable {
  const AddFeedbackState();

  @override
  List<Object> get props => [];
}

final class AddFeedbackInitial extends AddFeedbackState {}

class AddFeedbackLoading extends AddFeedbackState {}

class AddFeedbackFailure extends AddFeedbackState {
  final String errorMessage;

  const AddFeedbackFailure({required this.errorMessage});
}

class AddFeedbackSuccess extends AddFeedbackState {
  const AddFeedbackSuccess();
}
