import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/transaction%20repo/transaction_repo_imp.dart';
import 'package:equatable/equatable.dart';

part 'reverse_transaction_state.dart';

class ReverseTransactionCubit extends SafeCubit<ReverseTransactionState> {
  ReverseTransactionCubit(this.transactionRepoImpl)
      : super(ReverseTransactionInitial());
  TransactionRepoImpl transactionRepoImpl;
  Future<void> reverseTransaction(int transactionId) async {
    emit(ReverseTransactionLoading());
    var result = await transactionRepoImpl.reverseTransaction(transactionId);
    result.fold((failure) {
      emit(ReverseTransactionFailure(failure.errMessage));
    }, (_) {
      emit(const ReverseTransactionSuccess());
    });
  }
}
