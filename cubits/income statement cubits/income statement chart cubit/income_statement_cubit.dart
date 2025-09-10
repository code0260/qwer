import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/income%20statement%20report%20repo/income_statement_repo.dart';
import 'package:almonazim/data/model/report%20models/income%20statement%20report%20models/income_statement_input_model.dart';
import 'package:almonazim/data/model/report%20models/income%20statement%20report%20models/income_statement_line_model.dart';
import 'package:equatable/equatable.dart';

part 'income_statement_state.dart';

class IncomeStatementCubit extends SafeCubit<IncomeStatementState> {
  IncomeStatementCubit(this.incomeStatementRepo)
      : super(IncomeStatementInitial());
  IncomeStatementRepo incomeStatementRepo;
  IncomeStatementInputModel incomeStatementInputModel =
      IncomeStatementInputModel(
          endDate: DateTime.now(),
          startDate: DateTime.now().subtract(const Duration(days: 30)));
  Future<void> getIncomeStatement() async {
    emit(IncomeStatementLoading());
    var result =
        await incomeStatementRepo.getIncomeStatement(incomeStatementInputModel);
    result.fold((failure) {
      emit(IncomeStatementFailure(failure.errMessage));
    }, (lines) {
      emit(IncomeStatementSuccess(lines: lines));
    });
  }
}
