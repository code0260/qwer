import 'dart:io';

import 'package:almonazim/core/helper/functions/other functions/pick_file.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/salaries%20repo/salaries_repo.dart';
import 'package:equatable/equatable.dart';

part 'import_salaries_state.dart';

class ImportSalariesCubit extends SafeCubit<ImportSalariesState> {
  ImportSalariesCubit(this.salariesRepo) : super(ImportSalariesInitial());
  SalariesRepo salariesRepo;
  Future<void> uploadExcelFile() async {
    File? excelFile = await pickFile(allowedExtensions: ["xlsx", "XLSX"]);
    if (excelFile != null) {
      emit(ImportSalariesLoading());
      var response = await salariesRepo.importSalaries(excelFile.path);
      response.fold((failure) {
        emit(ImportSalariesFailure(errorMessage: failure.errMessage));
      }, (_) {
        emit(ImportSalariesSuccess());
      });
    } else {
      emit(const ImportSalariesFailure(errorMessage: "لم يتم اختيار ملف"));
    }
  }
}
