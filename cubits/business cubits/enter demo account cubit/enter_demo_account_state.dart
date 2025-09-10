part of 'enter_demo_account_cubit.dart';

sealed class EnterDemoAccountState extends Equatable {
  const EnterDemoAccountState();

  @override
  List<Object> get props => [];
}

final class EnterDemoAccountInitial extends EnterDemoAccountState {}

class EnterDemoAccountLoading extends EnterDemoAccountState {}

class EnterDemoAccountFailure extends EnterDemoAccountState {
  final String errorMessage;

  const EnterDemoAccountFailure({required this.errorMessage});
}

class EnterDemoAccountSuccess extends EnterDemoAccountState {
  const EnterDemoAccountSuccess();
} // image states:

final class ImageSuccess extends EnterDemoAccountState {}

final class ImageFailure extends EnterDemoAccountState {}
