import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/data%20source/repo/accounts%20repo/account_repo_imp.dart';
import 'package:almonazim/data/model/account%20models/account_model.dart';
import 'package:equatable/equatable.dart';

part 'balance_sheet_state.dart';

class BalanceSheetCubit extends SafeCubit<BalanceSheetState> {
  BalanceSheetCubit(this.accountRepo) : super(BalanceSheetInitial());
  AccountRepoImpl accountRepo;
  int? accountParentId;
  List<AccountModel> accounts = [];

  Future<void> initBalanceSheet() async {
    emit(BalanceSheetLoading());
    var result = await accountRepo.getAccountAmounts();
    result.fold((failure) {
      emit(BalanceSheetFailure(failure.errMessage));
    }, (tree) async {
      accounts = StoreAccounts.getAccountsModels()!;
      emit(BalanceSheetSuccess(
          lines: accounts
              .where((element) =>
                  element.accountsCode == '1' ||
                  element.accountsCode == '2' ||
                  element.accountsCode == '21')
              .toList()));
    });
  }

  Future<void> getBalanceSheet() async {
    emit(BalanceSheetLoading());
    emit(BalanceSheetSuccess(
        lines: accounts
            .where((element) => element.accountsParentId == accountParentId)
            .toList()));
  }
}
