import 'package:almonazim/data/model/account%20models/account_input_model.dart';
import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:dartz/dartz.dart';
import 'package:almonazim/core/errors/failures.dart';

abstract class AccountRepo {
  Future<Either<Failure, TreeNode>> getAllAccounts();
  Future<Either<Failure, void>> addAccount(AccountInputModel accountInputModel);
  Future<Either<Failure, void>> editAccount(
      AccountInputModel accountInputModel);
  Future<Either<Failure, TreeNode>> getAccountAmounts();
}
