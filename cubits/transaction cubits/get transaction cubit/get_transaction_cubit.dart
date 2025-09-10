import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/transaction%20repo/transaction_repo_imp.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'get_transaction_state.dart';

class GetTransactionCubit extends SafeCubit<GetTransactionState> {
  GetTransactionCubit(this.transactionRepo) : super(GetTransactionInitial());
  TransactionRepoImpl transactionRepo;
  ScrollController controller = ScrollController();
  List<TransactionModel> allTransactions = [];
  TransactionInputModel transactionInputModel = TransactionInputModel(
      startDate: DateTime.now().subtract(const Duration(days: 1 * 30)),
      endDate: DateTime.now());

  Future<void> getTransaction() async {
    addingGridListener();
    emit(GetTransactionLoading());
    var result = await transactionRepo.getTransactions(transactionInputModel);
    result.fold((failure) {
      emit(GetTransactionFailure(failure.errMessage));
    }, (transactions) {
      allTransactions.addAll(transactions);
      emit(GetTransactionSuccess());
    });
  }

  void refresh() async {
    transactionInputModel.requestNumber = 0;
    allTransactions.clear();
    getTransaction();
  }

  void addingGridListener() async {
    removingGridListener();
    await Future.delayed(const Duration(seconds: 1));
    controller.addListener(onGridScroll);
  }

  void removingGridListener() {
    // ignore: invalid_use_of_protected_member
    if (controller.hasListeners) {
      controller.removeListener(onGridScroll);
    } else {}
  }

  void disposeGridControl() {
    controller.dispose();
  }

  void onGridScroll() {
    if (controller.position.maxScrollExtent == controller.offset) {
      transactionInputModel.requestNumber += 1;
      getTransaction();
    }
  }

  void setCategoryDataCompleted() {
    removingGridListener();
  }

  @override
  Future<void> close() {
    disposeGridControl();
    return super.close();
  }
}
