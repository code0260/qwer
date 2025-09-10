part of 'edit_business_cubit.dart';

sealed class EditBusinessState extends Equatable {
  const EditBusinessState();

  @override
  List<Object> get props => [];
}

final class EditBusinessInitial extends EditBusinessState {}

class EditBusinessLoading extends EditBusinessState {}

class EditBusinessFailure extends EditBusinessState {
  final String errorMessage;

  const EditBusinessFailure({required this.errorMessage});
}

class EditBusinessSuccess extends EditBusinessState {
  const EditBusinessSuccess();
} // image states:

final class ImageSuccess extends EditBusinessState {}

final class ImageFailure extends EditBusinessState {}
