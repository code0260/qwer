import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/transaction%20repo/transaction_repo_imp.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';
import 'package:equatable/equatable.dart';

part 'add_transaction_state.dart';

class AddTransactionCubit extends SafeCubit<AddTransactionState> {
  AddTransactionCubit(this.transactionRepoImpl)
      : super(AddTransactionInitial());
  TransactionRepoImpl transactionRepoImpl;
  AddTransactionModel addTransactionModel = AddTransactionModel(
      transactionModel: const TransactionModel(), lines: []);
  double difference = 0;
  Future<void> addTransaction() async {
    emit(AddTransactionLoading());
    var result = await transactionRepoImpl.addTransaction(addTransactionModel);
    result.fold((failure) {
      emit(AddTransactionFailure(failure.errMessage));
    }, (_) {
      emit(const AddTransactionSuccess());
    });
  }

  String? get validateDataMessage {
    if (addTransactionModel.transactionModel.transactionsDescription == null) {
      return "الرجاء اختيار وصف القيد العام ";
    } else if (addTransactionModel.lines.isEmpty) {
      return "عذراً لا يوجد اي بنود للقيد بعد \n يرجى إضافتها";
    } else if (difference != 0) {
      return "الطرف الدائن لا يساوي الطرف المدين \n يرجى تصليحها";
    } else {
      return null;
    }
  }
}
