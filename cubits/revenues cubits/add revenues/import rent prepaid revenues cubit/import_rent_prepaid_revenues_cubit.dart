import 'dart:io';

import 'package:almonazim/core/helper/functions/other functions/pick_file.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/revenues%20repo/revenues_repo_imp.dart';
import 'package:equatable/equatable.dart';

part 'import_rent_prepaid_revenues_state.dart';

class ImportRentPrepaidRevenuesCubit
    extends SafeCubit<ImportRentPrepaidRevenuesState> {
  ImportRentPrepaidRevenuesCubit(this.rentPrepaidRevenuesRepo)
      : super(ImportRentPrepaidRevenuesInitial());
  RevenuesRepoImpl rentPrepaidRevenuesRepo;
  Future<void> uploadExcelFile() async {
    File? excelFile = await pickFile(allowedExtensions: ["xlsx", "XLSX"]);
    if (excelFile != null) {
      emit(ImportRentPrepaidRevenuesLoading());
      var response = await rentPrepaidRevenuesRepo
          .importRentPrepaidRevenues(excelFile.path);
      response.fold((failure) {
        emit(
            ImportRentPrepaidRevenuesFailure(errorMessage: failure.errMessage));
      }, (_) {
        emit(ImportRentPrepaidRevenuesSuccess());
      });
    } else {
      emit(const ImportRentPrepaidRevenuesFailure(
          errorMessage: "لم يتم اختيار ملف"));
    }
  }
}
