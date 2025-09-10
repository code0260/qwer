part of 'add_business_cubit.dart';

sealed class AddBusinessState extends Equatable {
  const AddBusinessState();

  @override
  List<Object> get props => [];
}

final class AddBusinessInitial extends AddBusinessState {}

class AddBusinessLoading extends AddBusinessState {}

class AddBusinessFailure extends AddBusinessState {
  final String errorMessage;

  const AddBusinessFailure({required this.errorMessage});
}

class AddBusinessSuccess extends AddBusinessState {
  const AddBusinessSuccess();
} // image states:

final class ImageSuccess extends AddBusinessState {}

final class ImageFailure extends AddBusinessState {}
