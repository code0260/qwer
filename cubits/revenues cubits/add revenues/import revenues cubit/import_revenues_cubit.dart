import 'dart:io';

import 'package:almonazim/core/helper/functions/other functions/pick_file.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/revenues%20repo/revenues_repo_imp.dart';
import 'package:equatable/equatable.dart';

part 'import_revenues_state.dart';

class ImportRevenuesCubit extends SafeCubit<ImportRevenuesState> {
  ImportRevenuesCubit(this.revenuesRepo) : super(ImportRevenuesInitial());
  RevenuesRepoImpl revenuesRepo;
  Future<void> uploadExcelFile() async {
    File? excelFile = await pickFile(allowedExtensions: ["xlsx", "XLSX"]);
    if (excelFile != null) {
      emit(ImportRevenuesLoading());
      var response = await revenuesRepo.importRevenues(excelFile.path);
      response.fold((failure) {
        emit(ImportRevenuesFailure(errorMessage: failure.errMessage));
      }, (_) {
        emit(ImportRevenuesSuccess());
      });
    } else {
      emit(const ImportRevenuesFailure(errorMessage: "لم يتم اختيار ملف"));
    }
  }
}
