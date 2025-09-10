import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/transaction%20repo/transaction_repo_imp.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_model.dart';
import 'package:equatable/equatable.dart';

part 'get_transaction_line_state.dart';

class GetTransactionLineCubit extends SafeCubit<GetTransactionLineState> {
  GetTransactionLineCubit(this.transactionRepo)
      : super(GetTransactionLineInitial());
  TransactionRepoImpl transactionRepo;
  Future<void> getTransactionLine(int transactionId) async {
    emit(GetTransactionLineLoading());
    var result = await transactionRepo.getTransactionLines(transactionId);
    result.fold((failure) {
      emit(GetTransactionLineFailure(failure.errMessage));
    }, (transactionLines) {
      emit(GetTransactionLineSuccess(transactionLines: transactionLines));
    });
  }
}
