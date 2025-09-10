import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/transaction%20repo/transaction_repo_imp.dart';
import 'package:almonazim/data/model/account%20models/account_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/general%20ledger/general_ledger_model.dart';
import 'package:equatable/equatable.dart';

part 'general_ledger_state.dart';

class GeneralLedgerCubit extends SafeCubit<GeneralLedgerState> {
  GeneralLedgerCubit(this.transactionRepoImpl) : super(GeneralLedgerInitial());
  TransactionRepoImpl transactionRepoImpl;
  AccountInputModel accountInputModel = AccountInputModel(
      startDate: DateTime.now().subtract(const Duration(days: 7)),
      endDate: DateTime.now());
  Future<void> getGeneralLedger() async {
    emit(GeneralLedgerLoading());
    var result = await transactionRepoImpl.getGeneralLedger(accountInputModel);
    result.fold((failure) {
      emit(GeneralLedgerFailure(failure.errMessage));
    }, (model) {
      emit(GeneralLedgerSuccess(generalLedgerModel: model));
    });
  }

  String? get validateAccountDataMessage {
    if (accountInputModel.accountsId == null) {
      return "الرجاء اختيار الحساب";
    } else {
      return null;
    }
  }
}
