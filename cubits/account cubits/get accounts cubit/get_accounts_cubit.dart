import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/data%20source/repo/accounts%20repo/account_repo_imp.dart';
import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:equatable/equatable.dart';

part 'get_accounts_state.dart';

class GetAccountCubit extends SafeCubit<GetAccountState> {
  GetAccountCubit(this.accountRepo) : super(GetAccountInitial());
  AccountRepoImpl accountRepo;
  Future<void> getAccount() async {
    emit(GetAccountLoading());
    TreeNode? localeTree = StoreAccounts.getChartOfAccounts();
    if (localeTree != null) {
      emit(GetAccountSuccess(treeNode: localeTree));
    } else {
      var result = await accountRepo.getAllAccounts();
      result.fold((failure) {
        emit(GetAccountFailure(failure.errMessage));
      }, (tree) {
        emit(GetAccountSuccess(treeNode: tree));
      });
    }
  }

  Future<void> refreshAccounts() async {
    emit(GetAccountLoading());
    var result = await accountRepo.getAllAccounts();
    result.fold((failure) {
      emit(GetAccountFailure(failure.errMessage));
    }, (tree) {
      emit(GetAccountSuccess(treeNode: tree));
    });
  }

  Future<void> refreshAccountAmounts() async {
    emit(GetAccountLoading());
    var result = await accountRepo.getAccountAmounts();
    result.fold((failure) {
      emit(GetAccountFailure(failure.errMessage));
    }, (tree) {
      emit(GetAccountSuccess(treeNode: tree));
    });
  }
}
