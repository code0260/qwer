import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/trial%20balance%20repo/trial_balance_repo_imp.dart';
import 'package:almonazim/data/model/account%20models/account_input_model.dart';
import 'package:equatable/equatable.dart';

part 'get_trial_balance_state.dart';

class GetTrialBalanceCubit extends SafeCubit<GetTrialBalanceState> {
  GetTrialBalanceCubit(this.trialBalanceRepo) : super(GetTrialBalanceInitial());
  TrialBalanceRepoImpl trialBalanceRepo;
  Future<void> getTrialBalance(AccountInputModel accountInputModel) async {
    emit(GetTrialBalanceLoading());
    var result = await trialBalanceRepo.getAccountAmount(accountInputModel);
    result.fold((failure) {
      emit(GetTrialBalanceFailure(failure.errMessage));
    }, (amount) {
      emit(GetTrialBalanceSuccess(amount: amount));
    });
  }
}
