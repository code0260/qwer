import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/trial%20balance%20repo/trial_balance_repo_imp.dart';
import 'package:almonazim/data/model/account%20models/trial_balance_model.dart';
import 'package:equatable/equatable.dart';

part 'get_more_accounts_amount_state.dart';

class GetMoreAccountsAmountCubit extends SafeCubit<GetMoreAccountsAmountState> {
  GetMoreAccountsAmountCubit(this.trialBalanceRepo)
      : super(GetMoreAccountsAmountInitial());
  TrialBalanceRepoImpl trialBalanceRepo;
  List<int> accounts = [];
  Future<void> getTrialBalances() async {
    emit(GetMoreAccountsAmountLoading());
    var result = await trialBalanceRepo.getMoreAccountsAmount(accounts);
    result.fold((failure) {
      emit(GetMoreAccountsAmountFailure(failure.errMessage));
    }, (accounts) {
      emit(GetMoreAccountsAmountSuccess(accounts: accounts));
    });
  }
}
