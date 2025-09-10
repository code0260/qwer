part of 'finish_demo_account_cubit.dart';

sealed class FinishDemoAccountState extends Equatable {
  const FinishDemoAccountState();

  @override
  List<Object> get props => [];
}

final class FinishDemoAccountInitial extends FinishDemoAccountState {}

class FinishDemoAccountLoading extends FinishDemoAccountState {}

class FinishDemoAccountFailure extends FinishDemoAccountState {
  final String errorMessage;

  const FinishDemoAccountFailure({required this.errorMessage});
}

class FinishDemoAccountSuccess extends FinishDemoAccountState {
  const FinishDemoAccountSuccess();
} // image states:

final class ImageSuccess extends FinishDemoAccountState {}

final class ImageFailure extends FinishDemoAccountState {}
