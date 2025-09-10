import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/cash%20report%20repos/cash%20account%20statment%20repo/cash_account_statment_repo.dart';
import 'package:almonazim/data/model/cash%20models/cash_input_model.dart';
import 'package:almonazim/data/model/report%20models/cash%20report%20models/cash_account_statement_model.dart';
import 'package:equatable/equatable.dart';

part 'cash_account_statement_state.dart';

class CashAccountStatementCubit extends SafeCubit<CashAccountStatementState> {
  CashAccountStatementCubit(this.cashRepo)
      : super(CashAccountStatementInitial());
  CashAccountStatementRepo cashRepo;
  CashInputModel cashInputModel = CashInputModel(
      startDate: DateTime.now().subtract(const Duration(days: 1)),
      endDate: DateTime.now());
  Future<void> getCashAccountStatement() async {
    emit(CashAccountStatementLoading());
    var result = await cashRepo.getCashAccountStatements(cashInputModel);
    result.fold((failure) {
      emit(CashAccountStatementFailure(failure.errMessage));
    }, (model) {
      emit(CashAccountStatementSuccess(statementModel: model));
    });
  }
}
