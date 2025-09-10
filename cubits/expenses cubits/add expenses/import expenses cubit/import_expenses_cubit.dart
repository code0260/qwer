import 'dart:io';

import 'package:almonazim/core/helper/functions/other functions/pick_file.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/expenses%20repo/expenses_repo_imp.dart';
import 'package:equatable/equatable.dart';

part 'import_expenses_state.dart';

class ImportExpensesCubit extends SafeCubit<ImportExpensesState> {
  ImportExpensesCubit(this.expensesRepo) : super(ImportExpensesInitial());
  ExpensesRepoImpl expensesRepo;
  Future<void> uploadExcelFile() async {
    File? excelFile = await pickFile(allowedExtensions: ["xlsx", "XLSX"]);
    if (excelFile != null) {
      emit(ImportExpensesLoading());
      var response = await expensesRepo.importExpenses(excelFile.path);
      response.fold((failure) {
        emit(ImportExpensesFailure(errorMessage: failure.errMessage));
      }, (_) {
        emit(ImportExpensesSuccess());
      });
    } else {
      emit(const ImportExpensesFailure(errorMessage: "لم يتم اختيار ملف"));
    }
  }
}
