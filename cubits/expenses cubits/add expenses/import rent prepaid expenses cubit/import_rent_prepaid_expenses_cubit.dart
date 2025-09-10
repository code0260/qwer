import 'dart:io';

import 'package:almonazim/core/helper/functions/other functions/pick_file.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/expenses%20repo/expenses_repo_imp.dart';
import 'package:equatable/equatable.dart';

part 'import_rent_prepaid_expenses_state.dart';

class ImportRentPrepaidExpensesCubit
    extends SafeCubit<ImportRentPrepaidExpensesState> {
  ImportRentPrepaidExpensesCubit(this.rentPrepaidExpensesRepo)
      : super(ImportRentPrepaidExpensesInitial());
  ExpensesRepoImpl rentPrepaidExpensesRepo;
  Future<void> uploadExcelFile() async {
    File? excelFile = await pickFile(allowedExtensions: ["xlsx", "XLSX"]);
    if (excelFile != null) {
      emit(ImportRentPrepaidExpensesLoading());
      var response = await rentPrepaidExpensesRepo
          .importRentPrepaidExpenses(excelFile.path);
      response.fold((failure) {
        emit(
            ImportRentPrepaidExpensesFailure(errorMessage: failure.errMessage));
      }, (_) {
        emit(ImportRentPrepaidExpensesSuccess());
      });
    } else {
      emit(const ImportRentPrepaidExpensesFailure(
          errorMessage: "لم يتم اختيار ملف"));
    }
  }
}
