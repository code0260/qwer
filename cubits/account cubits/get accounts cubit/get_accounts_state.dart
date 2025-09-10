part of 'get_accounts_cubit.dart';

sealed class GetAccountState extends Equatable {
  const GetAccountState();

  @override
  List<Object> get props => [];
}

final class GetAccountInitial extends GetAccountState {}

class GetAccountLoading extends GetAccountState {}

class GetAccountFailure extends GetAccountState {
  final String errorMessage;

  const GetAccountFailure(this.errorMessage);
}

class GetAccountSuccess extends GetAccountState {
  final TreeNode treeNode;
  const GetAccountSuccess({
    required this.treeNode,
  });
  @override
  // TODO: implement props
  List<Object> get props => [treeNode];
}
