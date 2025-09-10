part of 'delete_business_cubit.dart';

sealed class DeleteBusinessState extends Equatable {
  const DeleteBusinessState();

  @override
  List<Object> get props => [];
}

final class DeleteBusinessInitial extends DeleteBusinessState {}

class DeleteBusinessLoading extends DeleteBusinessState {}

class DeleteBusinessFailure extends DeleteBusinessState {
  final String errorMessage;

  const DeleteBusinessFailure({required this.errorMessage});
}

class DeleteBusinessSuccess extends DeleteBusinessState {
  const DeleteBusinessSuccess();
} // image states:

final class ImageSuccess extends DeleteBusinessState {}

final class ImageFailure extends DeleteBusinessState {}
