import 'dart:io';

import 'package:almonazim/core/helper/functions/other functions/pick_file.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/debts%20repo/debts_repo.dart';
import 'package:equatable/equatable.dart';

part 'import_debts_state.dart';

class ImportDebtsCubit extends SafeCubit<ImportDebtsState> {
  ImportDebtsCubit(this.debtsRepo) : super(ImportDebtsInitial());
  DebtsRepo debtsRepo;
  Future<void> uploadExcelFile() async {
    File? excelFile = await pickFile(allowedExtensions: ["xlsx", "XLSX"]);
    if (excelFile != null) {
      emit(ImportDebtsLoading());
      var response = await debtsRepo.importDebts(excelFile.path);
      response.fold((failure) {
        emit(ImportDebtsFailure(errorMessage: failure.errMessage));
      }, (_) {
        emit(ImportDebtsSuccess());
      });
    } else {
      emit(const ImportDebtsFailure(errorMessage: "لم يتم اختيار ملف"));
    }
  }
}
